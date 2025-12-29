// Models4Comfort - Main JavaScript

(function() {
  'use strict';
  
  // Smooth scroll for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      const target = document.querySelector(this.getAttribute('href'));
      if (target) {
        e.preventDefault();
        target.scrollIntoView({
          behavior: 'smooth',
          block: 'start'
        });
      }
    });
  });
  
  // Image lazy loading fallback (for older browsers)
  if ('loading' in HTMLImageElement.prototype) {
    const images = document.querySelectorAll('img[loading="lazy"][data-src]');
    images.forEach(img => {
      if (img.dataset.src) {
        img.src = img.dataset.src;
      }
    });
  }
  
  // Gallery image click to enlarge (basic implementation)
  const galleryImages = document.querySelectorAll('.gallery-item img');
  galleryImages.forEach(img => {
    img.addEventListener('click', function() {
      // Create lightbox overlay
      const overlay = document.createElement('div');
      overlay.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.9);
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 1000;
        cursor: pointer;
      `;
      
      const enlargedImg = document.createElement('img');
      enlargedImg.src = this.src;
      enlargedImg.style.cssText = `
        max-width: 90%;
        max-height: 90%;
        object-fit: contain;
      `;
      
      overlay.appendChild(enlargedImg);
      document.body.appendChild(overlay);
      
      // Close on click
      overlay.addEventListener('click', function() {
        document.body.removeChild(overlay);
      });
      
      // Close on ESC key
      document.addEventListener('keydown', function closeOnEsc(e) {
        if (e.key === 'Escape' && document.body.contains(overlay)) {
          document.body.removeChild(overlay);
          document.removeEventListener('keydown', closeOnEsc);
        }
      });
    });
  });
  
  // Mobile menu auto-close when link is clicked
  const navTrigger = document.getElementById('nav-trigger');
  if (navTrigger) {
    const navLinks = document.querySelectorAll('.site-nav .trigger a');
    navLinks.forEach(link => {
      link.addEventListener('click', function() {
        navTrigger.checked = false;
      });
    });
  }
  
  // Add loading class to images while they load
  document.querySelectorAll('img').forEach(img => {
    if (!img.complete) {
      img.classList.add('loading');
      img.addEventListener('load', function() {
        this.classList.remove('loading');
        this.classList.add('loaded');
      });
    }
  });
  
})();
