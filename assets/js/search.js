// search.js — lazy Pagefind wiring for the topbar search input.
// No deps. Degrades gracefully when the Pagefind index is absent (dev mode).
(function () {
  "use strict";

  var input = document.getElementById("search");
  var resultsEl = document.getElementById("search-results");
  if (!input || !resultsEl) return;

  var PAGEFIND_URL = "/pagefind/pagefind.js";
  var MAX_RESULTS = 8;
  var DEBOUNCE_MS = 150;
  var CLOSE_DELAY_MS = 150;

  var pagefind = null;
  var indexReady = false;
  var initFailed = false;
  var initStarted = false;

  var debounceTimer = null;
  var currentItems = [];
  var activeIndex = -1;
  var closeTimer = null;

  // --- index bootstrap --------------------------------------------------

  function ensureIndex() {
    if (initStarted) return;
    initStarted = true;
    import(PAGEFIND_URL)
      .then(function (mod) {
        pagefind = mod;
        return pagefind.init();
      })
      .then(function () {
        indexReady = true;
        if (input.value) runSearch(input.value);
      })
      .catch(function () {
        indexReady = false;
        initFailed = true;
        if (input.value) renderUnavailable();
      });
  }

  // --- dropdown helpers -------------------------------------------------

  function show() {
    if (closeTimer) {
      clearTimeout(closeTimer);
      closeTimer = null;
    }
    resultsEl.hidden = false;
    input.setAttribute("aria-expanded", "true");
  }

  function hide() {
    resultsEl.hidden = true;
    input.setAttribute("aria-expanded", "false");
    setActive(-1);
  }

  function setActive(idx) {
    activeIndex = idx;
    for (var i = 0; i < currentItems.length; i++) {
      if (i === idx) {
        currentItems[i].setAttribute("aria-selected", "true");
      } else {
        currentItems[i].removeAttribute("aria-selected");
      }
    }
    if (idx >= 0 && currentItems[idx]) {
      currentItems[idx].scrollIntoView({ block: "nearest" });
    }
  }

  function clearResults() {
    resultsEl.innerHTML = "";
    currentItems = [];
    activeIndex = -1;
  }

  // --- rendering --------------------------------------------------------

  function renderUnavailable() {
    clearResults();
    var empty = document.createElement("div");
    empty.className = "search-results__empty";
    empty.textContent = "Search index unavailable — run the build step.";
    resultsEl.appendChild(empty);
    show();
  }

  function renderEmpty(query) {
    clearResults();
    var empty = document.createElement("div");
    empty.className = "search-results__empty";
    empty.textContent = query
      ? "No results for \u201C" + query + "\u201D."
      : "Start typing to search the guide.";
    resultsEl.appendChild(empty);
    show();
  }

  function buildItem(result, idx) {
    var a = document.createElement("a");
    a.className = "search-result";
    a.setAttribute("role", "option");
    a.setAttribute("tabindex", "-1");
    a.setAttribute("data-idx", String(idx));
    a.href = "#";

    var titleEl = document.createElement("span");
    titleEl.className = "search-result__title";
    titleEl.textContent = "\u2026";

    var excerptEl = document.createElement("span");
    excerptEl.className = "search-result__excerpt";

    a.appendChild(titleEl);
    a.appendChild(excerptEl);

    result
      .data()
      .then(function (data) {
        if (!data) return;
        if (data.url) a.href = data.url;
        var title =
          (data.meta && data.meta.title) || data.url || "Untitled";
        titleEl.textContent = title;
        if (data.excerpt) {
          // Pagefind excerpts only contain text + <mark>; safe to inject.
          excerptEl.innerHTML = data.excerpt;
        }
      })
      .catch(function () {
        titleEl.textContent = "Untitled";
      });

    a.addEventListener("mouseenter", function () {
      setActive(idx);
    });

    currentItems.push(a);
    return a;
  }

  function renderResults(results) {
    clearResults();
    var frag = document.createDocumentFragment();
    var count = Math.min(results.length, MAX_RESULTS);
    for (var i = 0; i < count; i++) {
      frag.appendChild(buildItem(results[i], i));
    }
    resultsEl.appendChild(frag);
    show();
  }

  // --- search -----------------------------------------------------------

  function runSearch(query) {
    query = query.trim();
    if (!query) {
      clearResults();
      hide();
      return;
    }

    if (initFailed || !indexReady) {
      renderUnavailable();
      return;
    }

    pagefind
      .search(query)
      .then(function (res) {
        var results = (res && res.results) || [];
        if (results.length === 0) {
          renderEmpty(query);
        } else {
          renderResults(results);
        }
      })
      .catch(function () {
        renderUnavailable();
      });
  }

  function debouncedSearch(query) {
    if (debounceTimer) clearTimeout(debounceTimer);
    debounceTimer = setTimeout(function () {
      debounceTimer = null;
      runSearch(query);
    }, DEBOUNCE_MS);
  }

  // --- events -----------------------------------------------------------

  input.addEventListener("focus", ensureIndex);
  input.addEventListener("input", function () {
    ensureIndex();
    if (!input.value.trim()) {
      clearResults();
      hide();
      return;
    }
    debouncedSearch(input.value);
  });

  input.addEventListener("keydown", function (e) {
    if (e.key === "Escape") {
      if (!resultsEl.hidden) {
        hide();
        e.preventDefault();
      }
      return;
    }

    if (e.key === "ArrowDown") {
      if (currentItems.length > 0) {
        e.preventDefault();
        if (!resultsEl.hidden) {
          var next = activeIndex + 1;
          if (next >= currentItems.length) next = 0;
          setActive(next);
          currentItems[next].focus();
        }
      }
      return;
    }

    if (e.key === "ArrowUp") {
      if (currentItems.length > 0 && !resultsEl.hidden) {
        e.preventDefault();
        var prev = activeIndex - 1;
        if (prev < 0) prev = currentItems.length - 1;
        setActive(prev);
        currentItems[prev].focus();
      }
      return;
    }
  });

  // Keyboard nav when a result is focused.
  resultsEl.addEventListener("keydown", function (e) {
    var idx = activeIndex;

    if (e.key === "ArrowDown") {
      e.preventDefault();
      var next = idx + 1;
      if (next >= currentItems.length) next = 0;
      setActive(next);
      currentItems[next].focus();
      return;
    }

    if (e.key === "ArrowUp") {
      e.preventDefault();
      var prev = idx - 1;
      if (prev < 0) {
        // Up from the first result returns focus to the input.
        setActive(-1);
        input.focus();
      } else {
        setActive(prev);
        currentItems[prev].focus();
      }
      return;
    }

    if (e.key === "Escape") {
      e.preventDefault();
      hide();
      input.focus();
      return;
    }

    if (e.key === "Home") {
      e.preventDefault();
      setActive(0);
      currentItems[0].focus();
      return;
    }

    if (e.key === "End" && currentItems.length > 0) {
      e.preventDefault();
      var last = currentItems.length - 1;
      setActive(last);
      currentItems[last].focus();
      return;
    }
  });

  // Enter on a focused result navigates (default <a> behaviour); just close.
  resultsEl.addEventListener("click", function (e) {
    var a = e.target.closest("a.search-result");
    if (a) {
      // allow normal navigation
      hide();
    }
  });

  // Close on blur, but delay so a click on a result registers first.
  input.addEventListener("blur", function () {
    closeTimer = setTimeout(function () {
      hide();
    }, CLOSE_DELAY_MS);
  });
  input.addEventListener("focus", function () {
    if (closeTimer) {
      clearTimeout(closeTimer);
      closeTimer = null;
    }
  });

  // Keep the dropdown open while interacting with it.
  resultsEl.addEventListener("mousedown", function (e) {
    // Prevent the input blur from firing before the click resolves.
    if (e.target.closest("a.search-result")) e.preventDefault();
  });

  // Clicking outside closes the dropdown.
  document.addEventListener("click", function (e) {
    if (!input.contains(e.target) && !resultsEl.contains(e.target)) {
      hide();
    }
  });
})();
