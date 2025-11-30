// Mobile navigation toggle
document.addEventListener('DOMContentLoaded', function() {
  const menuToggle = document.querySelector('.menu-toggle');
  const siteNav = document.querySelector('.site-nav');

  if (menuToggle && siteNav) {
    menuToggle.addEventListener('click', function() {
      siteNav.classList.toggle('active');
      
      // Toggle aria-expanded attribute
      const isExpanded = siteNav.classList.contains('active');
      menuToggle.setAttribute('aria-expanded', isExpanded);
    });

    // Close menu when clicking outside
    document.addEventListener('click', function(event) {
      if (!menuToggle.contains(event.target) && !siteNav.contains(event.target)) {
        siteNav.classList.remove('active');
        menuToggle.setAttribute('aria-expanded', false);
      }
    });

    // Close menu on escape key
    document.addEventListener('keydown', function(event) {
      if (event.key === 'Escape' && siteNav.classList.contains('active')) {
        siteNav.classList.remove('active');
        menuToggle.setAttribute('aria-expanded', false);
        menuToggle.focus();
      }
    });
  }
});

// Lazy loading images (fallback for older browsers)
if ('loading' in HTMLImageElement.prototype) {
  // Browser supports native lazy loading - no action needed
} else {
  // Fallback for older browsers
  const script = document.createElement('script');
  script.src = 'https://cdnjs.cloudflare.com/ajax/libs/lazysizes/5.3.2/lazysizes.min.js';
  document.body.appendChild(script);
}
