---
layout: page
title: Blog
permalink: /blog/
---

Stay up to date with the latest news, tutorials, and features from our community.

<ul class="post-list">
{% for post in site.posts %}
  <li>
    <article>
      <header>
        <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
        <time datetime="{{ post.date | date_to_xmlschema }}">
          {{ post.date | date: "%B %d, %Y" }}
        </time>
        {% if post.author %}
          • <span class="author">{{ post.author }}</span>
        {% endif %}
      </header>
      {% if post.excerpt %}
      <div class="post-excerpt">
        {{ post.excerpt | strip_html | truncate: 200 }}
      </div>
      {% endif %}
    </article>
  </li>
{% endfor %}
</ul>

{% if site.posts.size == 0 %}
<p><em>No blog posts yet. Check back soon for updates!</em></p>
{% endif %}

---

## Categories

Browse posts by category:

- Model building techniques
- Tool and supply reviews
- Community showcases
- Site updates

## Subscribe

Stay updated with our latest posts by subscribing to our [RSS feed](/feed.xml).
