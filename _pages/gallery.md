---
layout: page
title: Photo Gallery
permalink: /gallery/
---

Welcome to our photo gallery! Here you'll find a collection of modelling projects, work-in-progress shots, and finished pieces from our community.

## Featured Projects

<div class="gallery">
  <div class="gallery-item">
    <img src="https://via.placeholder.com/400x300?text=Model+1" alt="Sample model 1">
    <p class="gallery-caption">Sample Project 1</p>
  </div>
  <div class="gallery-item">
    <img src="https://via.placeholder.com/400x300?text=Model+2" alt="Sample model 2">
    <p class="gallery-caption">Sample Project 2</p>
  </div>
  <div class="gallery-item">
    <img src="https://via.placeholder.com/400x300?text=Model+3" alt="Sample model 3">
    <p class="gallery-caption">Sample Project 3</p>
  </div>
</div>

## How to Add Your Photos

To add your photos to the gallery:

1. Place your images in the `assets/images/` folder
2. Use the image include in your markdown:

```liquid
{% raw %}{% include image.html src="assets/images/your-image.jpg" alt="Description" caption="Your caption" %}{% endraw %}
```

Or use a gallery with multiple images:

```liquid
{% raw %}{% include gallery.html images=page.gallery %}{% endraw %}
```

## Tips for Great Model Photography

- Use natural lighting when possible
- Shoot from multiple angles
- Use a plain background to make your model stand out
- Consider macro photography for detailed shots
