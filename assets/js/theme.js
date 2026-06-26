// theme.js — theme toggle wiring + mobile drawer + minor enhancements.
(function () {
  "use strict";

  var FOCUSABLE =
    'a[href], button:not([disabled]), input:not([disabled]), ' +
    'textarea:not([disabled]), select:not([disabled]), ' +
    '[tabindex]:not([tabindex="-1"])';

  function getTheme() {
    var t = document.documentElement.getAttribute("data-theme");
    return t === "light" || t === "dark" ? t : "dark";
  }

  function focusableElements(container) {
    if (!container) return [];
    return Array.prototype.slice
      .call(container.querySelectorAll(FOCUSABLE))
      .filter(function (el) {
        return el.offsetParent !== null || el === document.activeElement;
      });
  }

  // Theme toggle ---------------------------------------------------------
  var toggle = document.getElementById("theme-toggle");
  if (toggle) {
    // FOUC script (in <head>) has already set data-theme by now.
    toggle.setAttribute("aria-pressed", String(getTheme() === "dark"));

    toggle.addEventListener("click", function () {
      var next = getTheme() === "dark" ? "light" : "dark";
      document.documentElement.setAttribute("data-theme", next);
      try {
        localStorage.setItem("theme", next);
      } catch (e) {}
      toggle.setAttribute("aria-pressed", String(next === "dark"));
    });
  }

  // Mobile drawer --------------------------------------------------------
  var menuBtn = document.getElementById("menu-toggle");
  var sidebar = document.getElementById("sidebar");
  var backdrop = document.querySelector(".backdrop");

  function closeDrawer(returnFocus) {
    if (!sidebar || !sidebar.classList.contains("open")) {
      if (menuBtn) menuBtn.setAttribute("aria-expanded", "false");
      document.body.style.removeProperty("overflow");
      return;
    }
    sidebar.classList.remove("open");
    if (backdrop) backdrop.classList.remove("show");
    if (menuBtn) menuBtn.setAttribute("aria-expanded", "false");
    document.body.style.removeProperty("overflow");
    if (returnFocus && menuBtn) menuBtn.focus();
  }

  function openDrawer() {
    if (sidebar) sidebar.classList.add("open");
    if (backdrop) backdrop.classList.add("show");
    if (menuBtn) menuBtn.setAttribute("aria-expanded", "true");
    document.body.style.overflow = "hidden";

    if (sidebar) {
      var focusable = focusableElements(sidebar);
      if (focusable.length > 0) focusable[0].focus();
    }
  }

  function drawerIsOpen() {
    return !!(sidebar && sidebar.classList.contains("open"));
  }

  // Correct initial state.
  if (menuBtn) menuBtn.setAttribute("aria-expanded", "false");

  if (menuBtn && sidebar) {
    menuBtn.addEventListener("click", function () {
      if (drawerIsOpen()) {
        closeDrawer(true);
      } else {
        openDrawer();
      }
    });
  }

  if (backdrop) {
    backdrop.addEventListener("click", function () {
      closeDrawer(true);
    });
  }

  // Keyboard handling: Escape closes; Tab is trapped within the sidebar.
  document.addEventListener("keydown", function (e) {
    if (e.key === "Escape") {
      if (drawerIsOpen()) closeDrawer(true);
      return;
    }

    if (e.key !== "Tab" || !drawerIsOpen()) return;

    // If focus has leaked outside the sidebar, pull it back in.
    if (!sidebar.contains(document.activeElement)) {
      e.preventDefault();
      var leaked = focusableElements(sidebar);
      if (leaked.length > 0) {
        if (e.shiftKey) leaked[leaked.length - 1].focus();
        else leaked[0].focus();
      }
      return;
    }

    var focusable = focusableElements(sidebar);
    if (focusable.length === 0) return;
    var first = focusable[0];
    var last = focusable[focusable.length - 1];
    var active = document.activeElement;

    if (e.shiftKey && active === first) {
      e.preventDefault();
      last.focus();
    } else if (!e.shiftKey && active === last) {
      e.preventDefault();
      first.focus();
    }
  });

  // Close drawer when a sidebar link is clicked (mobile)
  if (sidebar) {
    sidebar.addEventListener("click", function (e) {
      if (e.target.closest("a")) {
        if (window.matchMedia("(max-width: 900px)").matches) closeDrawer(true);
      }
    });
  }

  // Reset drawer state on resize back to desktop
  window.addEventListener("resize", function () {
    if (!window.matchMedia("(max-width: 900px)").matches) {
      closeDrawer(false);
    }
  });
})();

// ------------------------------------------------------------------
// Cover page: category filter pills
// Self-contained; only runs when the .filters nav is present.
// ------------------------------------------------------------------
(function () {
  "use strict";

  var filters = document.querySelector(".filters");
  if (!filters) return;

  var buttons = Array.prototype.slice.call(
    filters.querySelectorAll(".filter")
  );
  var cards = Array.prototype.slice.call(
    document.querySelectorAll(".cover__grid .card")
  );
  var grid = document.querySelector(".cover__grid");

  function applyFilter(value) {
    var visible = 0;
    cards.forEach(function (card) {
      var cat = card.getAttribute("data-category") || "";
      var show = value === "all" || cat === value;
      card.classList.toggle("is-hidden", !show);
      if (show) visible++;
    });
    toggleEmpty(visible === 0);
    syncUrl(value);
  }

  function setActive(value) {
    var matched = false;
    buttons.forEach(function (btn) {
      var isActive = btn.getAttribute("data-filter") === value;
      btn.setAttribute("aria-pressed", String(isActive));
      btn.classList.toggle("is-active", isActive);
      if (isActive) matched = true;
    });
    if (!matched) {
      var allBtn = filters.querySelector('.filter[data-filter="all"]');
      if (allBtn) {
        allBtn.setAttribute("aria-pressed", "true");
        allBtn.classList.add("is-active");
      }
      value = "all";
    }
    applyFilter(value);
  }

  function toggleEmpty(empty) {
    var existing = grid.parentNode.querySelector(".cover__empty");
    if (!empty) {
      if (existing) existing.parentNode.removeChild(existing);
      return;
    }
    if (existing) return;
    var node = document.createElement("p");
    node.className = "cover__empty";
    node.textContent = "No chapters in this category.";
    grid.parentNode.insertBefore(node, grid.nextSibling);
  }

  function syncUrl(value) {
    if (!window.history || !window.history.replaceState) return;
    var url;
    try {
      url = new URL(window.location.href);
    } catch (e) {
      return;
    }
    if (value && value !== "all") {
      url.searchParams.set("cat", value);
    } else {
      url.searchParams.delete("cat");
    }
    window.history.replaceState(null, "", url.toString());
  }

  function currentCatFromUrl() {
    try {
      var url = new URL(window.location.href);
      return url.searchParams.get("cat") || "";
    } catch (e) {
      return "";
    }
  }

  // Click handling via event delegation.
  filters.addEventListener("click", function (e) {
    var btn = e.target.closest(".filter");
    if (!btn || !filters.contains(btn)) return;
    setActive(btn.getAttribute("data-filter"));
  });

  // Keyboard: Left/Right arrows move focus between filter buttons
  // (aria toolbar pattern). Enter/Space work natively on <button>.
  filters.addEventListener("keydown", function (e) {
    if (e.key !== "ArrowLeft" && e.key !== "ArrowRight") return;
    var idx = buttons.indexOf(document.activeElement);
    if (idx === -1) return;
    e.preventDefault();
    var next =
      e.key === "ArrowRight"
        ? (idx + 1) % buttons.length
        : (idx - 1 + buttons.length) % buttons.length;
    buttons[next].focus();
  });

  // Restore state from ?cat= on load.
  var initial = currentCatFromUrl();
  if (initial) {
    setActive(initial);
  }
})();

// Clickable algorithm table rows — clicking anywhere on a row navigates to
// that algorithm's page (data-href on <tr>). The inner <a class="algo-link">
// stays as the keyboard-accessible target.
(function () {
  "use strict";
  var table = document.querySelector(".algo-table");
  if (!table) return;
  table.addEventListener("click", function (e) {
    if (e.target.closest("a")) return;          // inner anchor handles itself
    var tr = e.target.closest("tr[data-href]");
    if (!tr) return;
    var href = tr.getAttribute("data-href");
    if (!href) return;
    if (e.metaKey || e.ctrlKey) {                // open in new tab
      window.open(href, "_blank", "noopener");
    } else {
      window.location.href = href;
    }
  });
})();
