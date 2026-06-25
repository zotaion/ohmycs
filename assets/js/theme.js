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
