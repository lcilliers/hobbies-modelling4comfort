// Main JavaScript for Models4Comfort

// Markdown rendering function
function renderMarkdown(markdownText, targetElement) {
    if (typeof marked !== 'undefined') {
        const html = marked.parse(markdownText);
        document.getElementById(targetElement).innerHTML = html;
    }
}

// Load Markdown content from a file
async function loadMarkdownContent(filepath, targetElement) {
    try {
        const response = await fetch(filepath);
        if (!response.ok) throw new Error('File not found');
        const markdown = await response.text();
        renderMarkdown(markdown, targetElement);
    } catch (error) {
        console.error('Error loading markdown:', error);
    }
}

// Image lightbox functionality
function initializeLightbox() {
    const galleryItems = document.querySelectorAll('.gallery-item');
    
    galleryItems.forEach(item => {
        item.addEventListener('click', function() {
            const img = this.querySelector('img');
            if (img) {
                openLightbox(img.src, img.alt);
            }
        });
    });
}

function openLightbox(src, alt) {
    const lightbox = document.createElement('div');
    lightbox.className = 'lightbox';
    lightbox.innerHTML = `
        <div class="lightbox-content">
            <span class="lightbox-close">&times;</span>
            <img src="${src}" alt="${alt}">
            <p>${alt}</p>
        </div>
    `;
    
    document.body.appendChild(lightbox);
    
    lightbox.addEventListener('click', function(e) {
        if (e.target.className === 'lightbox' || e.target.className === 'lightbox-close') {
            document.body.removeChild(lightbox);
        }
    });
}

// Smooth scrolling for anchor links
function initializeSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
}

// Load comments using Utterances
function loadComments(repo) {
    const commentsSection = document.getElementById('comments');
    if (!commentsSection) return;
    
    const script = document.createElement('script');
    script.src = 'https://utteranc.es/client.js';
    script.setAttribute('repo', repo);
    script.setAttribute('issue-term', 'pathname');
    script.setAttribute('theme', 'github-light');
    script.setAttribute('crossorigin', 'anonymous');
    script.async = true;
    
    commentsSection.appendChild(script);
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    // Initialize lightbox for galleries
    initializeLightbox();
    
    // Initialize smooth scrolling
    initializeSmoothScroll();
    
    // Load comments if on a post/project page
    const commentsContainer = document.getElementById('comments');
    if (commentsContainer) {
        loadComments('lcilliers/hobbies-modelling4comfort');
    }
    
    // Add active class to current nav link
    const currentPage = window.location.pathname.split('/').pop() || 'index.html';
    document.querySelectorAll('.site-nav a').forEach(link => {
        if (link.getAttribute('href') === currentPage) {
            link.style.color = 'var(--secondary-color)';
            link.style.fontWeight = 'bold';
        }
    });
});

// Utility: Format date
function formatDate(dateString) {
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    return new Date(dateString).toLocaleDateString('en-US', options);
}

// Export functions for use in other scripts
window.Models4Comfort = {
    renderMarkdown,
    loadMarkdownContent,
    loadComments,
    formatDate
};
