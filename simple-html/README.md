# Simple HTML/CSS/JS Setup

This folder contains a simple, no-build-required website structure that works with Markdown.

## Features

- Pure HTML/CSS/JavaScript (no build tools required)
- Markdown support via marked.js (loaded from CDN)
- Responsive design
- Image lightbox
- Comments via Utterances
- Works with any simple web server

## Usage

### Option 1: Using Live Server (VS Code Extension)

1. Install "Live Server" extension in VS Code
2. Right-click on `index.html`
3. Select "Open with Live Server"

### Option 2: Using Python's built-in server

```bash
cd simple-html
python -m http.server 8000
```

Visit: http://localhost:8000

### Option 3: Using Node.js http-server

```bash
npx http-server simple-html -p 8000
```

## File Structure

```
simple-html/
├── index.html           # Homepage
├── projects.html        # Projects listing
├── builds.html          # Build logs
├── about.html          # About page
├── css/
│   └── style.css       # All styles
├── js/
│   └── main.js         # Main JavaScript
├── content/            # Markdown content files
│   ├── projects/
│   └── builds/
└── images/             # Image assets
```

## Adding Markdown Content

You can load Markdown files dynamically:

```javascript
Models4Comfort.loadMarkdownContent('content/my-post.md', 'content');
```

Or write Markdown directly in JavaScript:

```javascript
const markdown = `
# My Project
This is **bold** text.
`;
Models4Comfort.renderMarkdown(markdown, 'content');
```

## Deployment

Simply upload the entire `simple-html` folder to any static hosting service:
- GitHub Pages
- Netlify
- Vercel
- Any web server
