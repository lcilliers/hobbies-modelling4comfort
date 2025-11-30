# Modelling4Comfort

A hobby website showcasing modelling projects with photos, videos, and community features. Built with Jekyll and hosted on GitHub Pages.

## Features

- **Markdown Content** - Write content using simple markdown syntax
- **Photo Gallery** - Showcase modelling projects with images
- **Video Support** - Embed YouTube videos or host your own
- **Comments** - Disqus-powered comment system for community engagement
- **User Registration** - Integration with Disqus and GitHub for user participation
- **Responsive Design** - Works on desktop and mobile devices
- **Blog** - Share tutorials, project showcases, and tips

## Getting Started

### Prerequisites

- Ruby 3.0 or higher
- Bundler gem

### Local Development

1. Clone the repository:
   ```bash
   git clone https://github.com/lcilliers/hobbies-modelling4comfort.git
   cd hobbies-modelling4comfort
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Run the development server:
   ```bash
   bundle exec jekyll serve
   ```

4. Open your browser to `http://localhost:4000`

## Site Structure

```
├── _config.yml          # Site configuration
├── _layouts/            # Page templates
├── _includes/           # Reusable components
│   ├── disqus.html      # Comments
│   ├── image.html       # Image embed
│   ├── video.html       # Video embed
│   └── gallery.html     # Photo gallery
├── _pages/              # Static pages
├── _posts/              # Blog posts
├── assets/
│   ├── css/             # Stylesheets
│   ├── images/          # Image files
│   └── videos/          # Video files
├── index.md             # Homepage
└── README.md            # This file
```

## Adding Content

### Create a Blog Post

Create a new file in `_posts/` with the format `YYYY-MM-DD-title.md`:

```markdown
---
layout: post
title: "Your Post Title"
date: 2024-01-15 10:00:00 -0000
author: Your Name
comments: true
tags: [tag1, tag2]
---

Your content here...
```

### Add Images

Use the image include in your markdown:

```liquid
{% include image.html src="assets/images/photo.jpg" alt="Description" caption="Caption text" %}
```

### Embed Videos

For YouTube videos:
```liquid
{% include video.html youtube="VIDEO_ID" caption="Video description" %}
```

For self-hosted videos:
```liquid
{% include video.html src="assets/videos/video.mp4" poster="assets/images/thumbnail.jpg" caption="Description" %}
```

## Configuration

Edit `_config.yml` to customize:

- Site title and description
- Disqus shortname (for comments)
- Social links
- Navigation menu

### Setting Up Comments

1. Create a Disqus account at [disqus.com](https://disqus.com)
2. Create a new site and get your shortname
3. Update `disqus.shortname` in `_config.yml`

## Deployment

The site automatically deploys to GitHub Pages when you push to the `main` branch. The deployment is handled by the GitHub Actions workflow in `.github/workflows/jekyll-pages.yml`.

### Enable GitHub Pages

1. Go to your repository Settings
2. Navigate to Pages
3. Under "Build and deployment", select "GitHub Actions"

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is open source and available under the [MIT License](LICENSE).