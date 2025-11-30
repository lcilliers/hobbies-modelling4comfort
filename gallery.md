---
layout: page
title: Gallery
permalink: /gallery/
---

Browse our collection of model builds, dioramas, and miniatures from our community. Click on any item to see more details and join the discussion.

<div class="gallery-grid">
{% for item in site.gallery %}
  <div class="gallery-card">
    {% if item.thumbnail %}
    <a href="{{ item.url | relative_url }}">
      <img src="{{ item.thumbnail | relative_url }}" alt="{{ item.title }}" loading="lazy">
    </a>
    {% endif %}
    <div class="gallery-card-content">
      <h3><a href="{{ item.url | relative_url }}">{{ item.title }}</a></h3>
      {% if item.description %}
      <p>{{ item.description | truncate: 100 }}</p>
      {% endif %}
    </div>
  </div>
{% endfor %}
</div>

{% if site.gallery.size == 0 %}
<p><em>No gallery items yet. Check back soon for amazing model builds!</em></p>
{% endif %}

---

## Want to Submit Your Work?

We're always looking for great builds to feature in our gallery. If you'd like to share your work with the community, please [join us](/register/) and reach out through the comments or contact page.

### Photo Guidelines

For the best presentation of your work:

- Use good lighting (natural light works best)
- Include multiple angles
- Consider close-up shots of details
- A plain background helps your model stand out
- Include a size reference when relevant
