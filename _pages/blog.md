---
layout: page
title: Blog
permalink: /blog/
---

Welcome to our blog! Here you'll find the latest posts from our community, including tutorials, project showcases, and modelling tips.

<ul class="post-list">
{% for post in site.posts %}
  <li>
    <h2><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h2>
    <p class="post-meta">
      <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %d, %Y" }}</time>
      {% if post.author %} • {{ post.author }}{% endif %}
    </p>
    <p class="post-excerpt">{{ post.excerpt | strip_html | truncate: 200 }}</p>
    <a href="{{ post.url | relative_url }}">Read more →</a>
  </li>
{% endfor %}
</ul>

{% if site.posts.size == 0 %}
<p>No posts yet! Check back soon for exciting content.</p>
{% endif %}
