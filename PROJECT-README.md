# Models4Comfort - Diorama Modeling Website

Welcome to Models4Comfort! This repository contains a comprehensive website setup for showcasing diorama modeling projects, build logs, techniques, and the creative journey of miniature modeling.

## 🎨 About This Project

This is a hobby website documenting:
- **Diorama Projects**: Detailed showcases of completed and ongoing builds
- **Build Logs**: Step-by-step documentation of the building process
- **Techniques**: Tutorials and tips for modeling and weathering
- **Gallery**: Visual documentation of the creative process

## 🚀 Quick Start

This repository includes **4 different approaches** to building your website. Choose the one that fits your needs:

### 1. Jekyll (Recommended for Beginners) ⭐
- **Location**: Root directory
- **Setup**: Works out-of-the-box with GitHub Pages
- **Start**: `bundle install && bundle exec jekyll serve`
- **Best for**: Simplicity, no build tools needed locally

### 2. Hugo (Fast & Powerful)
- **Location**: `hugo/` directory
- **Setup**: Install Hugo locally
- **Start**: `cd hugo && hugo server`
- **Best for**: Speed, advanced features

### 3. Simple HTML/CSS/JS (No Build Tools)
- **Location**: `simple-html/` directory
- **Setup**: None required
- **Start**: Open `simple-html/index.html` or use Live Server
- **Best for**: Maximum simplicity, learning

### 4. Eleventy (Modern & Flexible)
- **Location**: `eleventy/` directory
- **Setup**: `cd eleventy && npm install`
- **Start**: `npm start`
- **Best for**: Modern JavaScript workflows

## 📁 Project Structure

```
Models4Comfort/
├── _config.yml              # Jekyll configuration
├── _layouts/                # Jekyll layouts
├── _includes/               # Jekyll includes
├── _projects/               # Project showcase pages
├── _builds/                 # Build log entries
├── _techniques/             # Technique tutorials
├── assets/                  # Shared assets (images, CSS, JS)
├── hugo/                    # Hugo static site
├── simple-html/             # Simple HTML version
├── eleventy/                # Eleventy (11ty) version
├── .github/workflows/       # GitHub Actions for deployment
└── README.md               # This file
```

## 🌐 Deployment

### GitHub Pages (Free)

1. **Enable GitHub Pages**:
   - Go to Settings → Pages
   - Source: Select "GitHub Actions"
   - Save

2. **Choose Your Generator**:
   - Jekyll: Keep `.github/workflows/jekyll.yml`
   - Hugo: Keep `.github/workflows/hugo.yml`
   - Eleventy: Keep `.github/workflows/eleventy.yml`
   - Delete or rename the others

3. **Push to GitHub**:
   ```bash
   git add .
   git commit -m "Initial site setup"
   git push origin main
   ```

4. **Visit Your Site**:
   - https://lcilliers.github.io/hobbies-modelling4comfort/

## 💬 Comments System

The site supports GitHub-based comments via Utterances or Giscus:

1. **Install Utterances** (simpler):
   - Visit: https://github.com/apps/utterances
   - Install on this repository
   - Configuration is already complete!

2. **Or use Giscus** (more features):
   - Enable Discussions in repository settings
   - Visit: https://github.com/apps/giscus
   - Follow setup instructions

See `COMMENTS-SETUP.md` for detailed instructions.

## 📝 Creating Content

### New Project

Create a file in `_projects/my-project.md`:

```markdown
---
layout: project
title: "My Awesome Diorama"
scale: "1:35"
status: "In Progress"
featured_image: "/assets/images/my-project.jpg"
tags: [WW2, Tanks, Winter]
comments: true
---

Your project description here...
```

### New Build Log

Create a file in `_builds/build-log-###.md`:

```markdown
---
layout: build
title: "Build Log #1 - Starting the Base"
date: 2025-11-30
project: "/projects/my-project/"
materials: ["XPS Foam", "PVA Glue", "Sand"]
tools: ["Hot wire cutter", "Sandpaper"]
comments: true
---

Today's progress...
```

### New Technique

Create a file in `_techniques/technique-name.md`:

```markdown
---
layout: post
title: "How to Create Realistic Snow"
tags: [techniques, weathering, winter]
comments: true
---

Tutorial content...
```

## 🎨 Customization

### Jekyll (_config.yml)
- Update site title, description, author
- Configure social media links
- Adjust navigation menu

### Hugo (hugo/config.toml)
- Update site parameters
- Configure menu items
- Set theme options

### Eleventy (eleventy/.eleventy.js)
- Customize collections
- Add filters and shortcodes
- Configure plugins

## 🖼️ Adding Images

Store images in `assets/images/`:

```
assets/images/
├── projects/          # Project images
├── builds/            # Build log photos
├── techniques/        # Tutorial images
└── gallery/           # General gallery
```

Reference in Markdown:
```markdown
![Description](/assets/images/my-image.jpg)
```

## 📚 Documentation

- **Jekyll**: See root README files and Jekyll docs
- **Hugo**: See `hugo/README.md`
- **Simple HTML**: See `simple-html/README.md`
- **Eleventy**: See `eleventy/README.md`
- **Comments**: See `COMMENTS-SETUP.md`
- **Deployment**: See `.github/workflows/README.md`

## 🛠️ Development

### Prerequisites

**For Jekyll**:
- Ruby 2.7+ and Bundler
- Run: `bundle install`

**For Hugo**:
- Hugo Extended 0.120+
- Download from: https://gohugo.io/installation/

**For Eleventy**:
- Node.js 18+
- Run: `cd eleventy && npm install`

**For Simple HTML**:
- Just a web browser!
- Optional: Live Server extension for VS Code

### Local Development

```bash
# Jekyll
bundle exec jekyll serve
# Visit: http://localhost:4000

# Hugo
cd hugo && hugo server
# Visit: http://localhost:1313

# Eleventy
cd eleventy && npm start
# Visit: http://localhost:8080

# Simple HTML
# Use Live Server or any HTTP server
```

## 🤝 Contributing

This is a personal hobby project, but suggestions are welcome!

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📜 License

This project is for personal use. Content and design are © 2025 Models4Comfort.

## 🔗 Links

- **Live Site**: https://lcilliers.github.io/hobbies-modelling4comfort/
- **Repository**: https://github.com/lcilliers/hobbies-modelling4comfort
- **GitHub Profile**: https://github.com/lcilliers

## 📧 Contact

For questions or suggestions, open an issue or use the comments system on the live site.

---

Built with ❤️ for the scale modeling community. Happy building! 🎨🔨
