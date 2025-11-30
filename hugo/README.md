# Hugo Quick Start Guide

## Installation

### Install Hugo (Extended version recommended):

**Windows (using Chocolatey):**
```powershell
choco install hugo-extended
```

**Windows (using Scoop):**
```powershell
scoop install hugo-extended
```

**Manual Download:**
Download from https://github.com/gohugoio/hugo/releases

## Usage

### Create a new post:
```bash
hugo new content/posts/my-first-post.md
```

### Create a new project:
```bash
hugo new content/projects/my-diorama.md
```

### Run local development server:
```bash
cd hugo
hugo server -D
```

Visit: http://localhost:1313

### Build for production:
```bash
hugo --minify
```

The built site will be in the `public/` directory.

## Directory Structure

```
hugo/
├── config.toml          # Configuration
├── content/             # Your markdown content
│   ├── projects/        # Project showcases
│   ├── builds/          # Build logs
│   └── posts/           # Blog posts
├── archetypes/          # Content templates
├── static/              # Static files (images, etc.)
├── themes/              # Themes
└── public/              # Generated site (git ignored)
```
