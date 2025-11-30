---
layout: page
title: Video Library
permalink: /videos/
---

Welcome to our video library! Watch tutorials, project walkthroughs, and tips from experienced modellers.

## Featured Videos

### Getting Started with Scale Modelling

{% include video.html youtube="dQw4w9WgXcQ" caption="Introduction to Scale Modelling (Sample Video)" %}

## Video Categories

### Tutorials
- Basic assembly techniques
- Painting and weathering
- Airbrushing fundamentals
- Custom modifications

### Project Walkthroughs
- Start-to-finish builds
- Time-lapse builds
- Restoration projects

## How to Add Videos

### Embedding YouTube Videos

To embed a YouTube video, use the video include:

```liquid
{% raw %}{% include video.html youtube="VIDEO_ID" caption="Your caption" %}{% endraw %}
```

Replace `VIDEO_ID` with the YouTube video ID (the part after `v=` in the URL).

### Hosting Your Own Videos

For self-hosted videos, place them in `assets/videos/` and use:

```liquid
{% raw %}{% include video.html src="assets/videos/your-video.mp4" poster="assets/images/thumbnail.jpg" caption="Your caption" %}{% endraw %}
```

## Submit Your Video

Have a video you'd like to share? [Register](/register/) and contact us to have your content featured!
