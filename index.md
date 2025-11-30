---
layout: default
title: Home
---

<div class="home">
  <section class="hero">
    <h1>Welcome to Modelling4Comfort</h1>
    <p>Discover the art and joy of modelling as a hobby. Browse our collection of photos, videos, and tutorials.</p>
  </section>

  <section class="features">
    <div class="feature-box">
      <h3>📸 Photo Gallery</h3>
      <p>Browse our extensive collection of modelling photos showcasing various projects and techniques.</p>
      <a href="{{ '/gallery/' | relative_url }}" class="btn">View Gallery</a>
    </div>
    <div class="feature-box">
      <h3>🎥 Video Tutorials</h3>
      <p>Watch step-by-step video tutorials and project walkthroughs from our community.</p>
      <a href="{{ '/videos/' | relative_url }}" class="btn">Watch Videos</a>
    </div>
    <div class="feature-box">
      <h3>💬 Community</h3>
      <p>Join our community, share your work, and engage with fellow modelling enthusiasts.</p>
      <a href="{{ '/register/' | relative_url }}" class="btn">Join Us</a>
    </div>
  </section>

  <section class="recent-posts">
    <h2>Latest Blog Posts</h2>
    <ul class="post-list">
      {% for post in site.posts limit:5 %}
      <li>
        <h2><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h2>
        <p class="post-meta">{{ post.date | date: "%B %d, %Y" }}</p>
        <p class="post-excerpt">{{ post.excerpt | strip_html | truncate: 150 }}</p>
      </li>
      {% endfor %}
    </ul>
    <p><a href="{{ '/blog/' | relative_url }}" class="btn btn-primary">View All Posts</a></p>
  </section>
</div>
