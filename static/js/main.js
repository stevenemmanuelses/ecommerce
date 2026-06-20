document.addEventListener('DOMContentLoaded', function () {
  const dropdown = document.querySelector('.categories-dropdown');
  if (!dropdown) return;
  const toggle = dropdown.querySelector('.categories-toggle');
  const menu = dropdown.querySelector('.categories-menu');

  function close() {
    dropdown.classList.remove('open');
    toggle.setAttribute('aria-expanded', 'false');
  }
  function open() {
    dropdown.classList.add('open');
    toggle.setAttribute('aria-expanded', 'true');
  }

  toggle.addEventListener('click', function (e) {
    e.stopPropagation();
    if (dropdown.classList.contains('open')) close(); else open();
  });

  // Close when clicking outside
  document.addEventListener('click', function (e) {
    if (!dropdown.contains(e.target)) close();
  });

  // Close on Escape
  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') close();
  });
});
