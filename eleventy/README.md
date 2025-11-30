# 11ty (Eleventy) Setup

Modern static site generator with powerful templating.

## Installation

```bash
cd eleventy
npm install
```

## Usage

### Development server with live reload
```bash
npm start
```

Visit: http://localhost:8080

### Build for production
```bash
npm run build
```

Output will be in `_site/` directory.

## Features

- Nunjucks templating
- Markdown support
- Collections for projects, builds, and techniques
- Syntax highlighting
- Image optimization (with eleventy-img plugin)
- Comments via Utterances

## Directory Structure

```
eleventy/
├── .eleventy.js        # Configuration
├── package.json        # Dependencies
├── src/
│   ├── _layouts/       # Page layouts
│   ├── _includes/      # Reusable components
│   ├── _data/          # Site data (JSON/JS)
│   ├── projects/       # Project pages
│   ├── builds/         # Build logs
│   ├── assets/         # CSS, JS, images
│   └── index.md        # Homepage
└── _site/              # Built site (git ignored)
```

## Creating Content

### New Project
Create a file in `src/projects/my-project.md`:

```markdown
---
layout: project.njk
title: My Diorama Project
scale: 1:35
status: In Progress
featured_image: /images/project.jpg
comments: true
---

Your project content here...
```

### New Build Log
Create a file in `src/builds/build-log-1.md`:

```markdown
---
layout: post.njk
title: Build Log - Day 1
date: 2025-11-30
project: my-diorama-project
---

Today's progress...
```
