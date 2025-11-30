# Modelling4Comfort

A hobby website for sharing model building projects, photos, videos, and community discussions. Built with Jekyll and hosted on GitHub Pages.

## Features

- **Photo Gallery**: Showcase completed builds with detailed descriptions
- **Video Support**: Embed YouTube, Vimeo, or local video files
- **Blog**: Share news, tutorials, and community updates
- **Comments**: Disqus integration for community discussions
- **Responsive Design**: Works on desktop, tablet, and mobile devices
- **RSS Feed**: Subscribe to content updates

## Getting Started

### Prerequisites

- Ruby 3.0+
- Bundler

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

3. Run the local server:
   ```bash
   bundle exec jekyll serve
   ```

4. Open your browser to `http://localhost:4000`

### Building for Production

```bash
bundle exec jekyll build
```

The site will be generated in the `_site` directory.

## Project Structure

```
├── _config.yml          # Site configuration
├── _layouts/            # Page templates
│   ├── default.html     # Base layout
│   ├── home.html        # Homepage layout
│   ├── page.html        # Static pages
│   ├── post.html        # Blog posts
│   └── gallery-item.html # Gallery items
├── _includes/           # Reusable components
│   ├── disqus.html      # Comments integration
│   ├── video.html       # Video embedding
│   └── image-gallery.html # Photo galleries
├── _posts/              # Blog posts
├── _gallery/            # Gallery collection
├── assets/
│   ├── css/             # Stylesheets
│   ├── js/              # JavaScript
│   └── images/          # Site images
└── .github/workflows/   # CI/CD configuration
```

## Configuration

Edit `_config.yml` to customize:

- **Site title and description**
- **Disqus shortname** for comments
- **Social links**
- **Permalink structure**

### Enabling Comments

1. Create a [Disqus](https://disqus.com) account
2. Register your site to get a shortname
3. Add your shortname to `_config.yml`:
   ```yaml
   disqus:
     shortname: your-disqus-shortname
   ```

## Adding Content

### Blog Posts

Create a new file in `_posts/` with the format `YYYY-MM-DD-title.md`:

```yaml
---
layout: post
title: "Your Post Title"
date: 2024-01-01 12:00:00 -0000
categories: [category1, category2]
tags: [tag1, tag2]
author: Your Name
---

Your content here...
```

### Gallery Items

Create a new file in `_gallery/`:

```yaml
---
title: "Build Title"
description: "Brief description"
date: 2024-01-01
thumbnail: "/assets/images/your-image.jpg"
image: "/assets/images/your-image.jpg"
---

Detailed description and build notes...
```

### Embedding Videos

Use the video include in your content:

```liquid
{% include video.html url="https://www.youtube.com/watch?v=VIDEO_ID" %}
```

## Deployment

The site automatically deploys to GitHub Pages when you push to the `main` branch. The workflow is defined in `.github/workflows/jekyll.yml`.

### Manual Deployment

You can also trigger a deployment manually from the GitHub Actions tab.

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

This project is open source and available under the [MIT License](LICENSE).

## Acknowledgments

- Built with [Jekyll](https://jekyllrb.com/)
- Hosted on [GitHub Pages](https://pages.github.com/)
- Comments powered by [Disqus](https://disqus.com/)