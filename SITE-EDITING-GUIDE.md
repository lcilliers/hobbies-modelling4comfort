# Site Editing Guide - Standards & Tips

A comprehensive guide to editing and maintaining your Models4Comfort website, including best practices, standards, and helpful tips.

---

## Table of Contents

1. [Hiding Content from Publication](#hiding-content-from-publication)
2. [Front Matter Standards](#front-matter-standards)
3. [Image Guidelines](#image-guidelines)
4. [Writing Style Guide](#writing-style-guide)
5. [Link Best Practices](#link-best-practices)
6. [Markdown Formatting](#markdown-formatting)
7. [File Naming Conventions](#file-naming-conventions)
8. [SEO Best Practices](#seo-best-practices)
9. [Common Mistakes to Avoid](#common-mistakes-to-avoid)
10. [Quick Reference](#quick-reference)

---

## Hiding Content from Publication

### Option 1: Draft Posts (Best for Individual Pages)

For individual pages in collections, add `published: false` to the front matter:

```yaml
---
layout: post
title: "German Sail Boat - Build Log #001"
published: false  # This page won't be published
date: 2025-12-01
---
```

**Use when:**
- Working on a build log that's not ready
- Creating a technique tutorial that needs more photos
- Drafting a project page

### Option 2: Draft Folder

Move files to a `_drafts` folder. Jekyll won't publish these unless you run with `--drafts` flag:

```
_drafts/
  ├── unfinished-technique.md
  └── work-in-progress-build.md
```

**Use when:**
- You have multiple drafts to organize
- You want to keep drafts separate from published content

### Option 3: HTML Comments (Best for Sections Within Pages)

Use HTML comments to hide specific sections in a page:

```markdown
## Visible Section

This content will show.

<!-- 
## Hidden Section

This content is commented out and won't appear on the site.
You can include multiple paragraphs, images, etc.

- Hidden list item
- Another hidden item
-->

## Another Visible Section
```

**Use when:**
- Hiding "Coming Soon" projects on projects.md
- Commenting out incomplete sections
- Temporarily removing content without deleting it

### Option 4: Liquid `if` Statements (Advanced)

Use conditional logic in your front matter:

```yaml
---
layout: default
title: My Page
show_future_plans: false
---

{% if page.show_future_plans %}
## Future Plans Section
This only shows if show_future_plans is true
{% endif %}
```

**Use when:**
- You want to easily toggle sections on/off
- Creating reusable templates with optional sections

---

## Front Matter Standards

Front matter is the YAML block at the top of each file. Always use consistent formatting:

### For Projects (_projects/)

```yaml
---
layout: project
title: "German Sail Boat"
date: 2025-11-30
thumbnail: assets/images/projects/german-sail-boat/IMG-20220403-WA0009.jpg
status: "In Progress"  # Options: Planning, In Progress, Completed
difficulty: "Advanced"  # Options: Beginner, Intermediate, Advanced
scale: "1:50"
categories: [ships, maritime, sailing]
tags: [rigging, weathering, scratch-building]
gallery:
  - assets/images/projects/german-sail-boat/image1.jpg
  - assets/images/projects/german-sail-boat/image2.jpg
---
```

### For Build Logs (_builds/)

```yaml
---
layout: post
title: "German Sail Boat - Build Log #001"
date: 2025-12-01
project: german-sail-boat
build_number: 1
tags: [ships, planning, kit-review]
thumbnail: assets/images/builds/german-sail-boat-001/thumbnail.jpg
---
```

### For Techniques (_techniques/)

```yaml
---
layout: post
title: "Winter Weathering Effects"
date: 2025-12-01
difficulty: "Intermediate"  # Beginner, Intermediate, Advanced
categories: [scenery, weathering]
tags: [snow, ice, winter, texturing]
time_required: "2-3 hours"
materials:
  - Baking soda
  - White glue
  - Texture paste
projects_used:
  - cabin-in-woods
  - country-house
---
```

### For Regular Pages

```yaml
---
layout: default
title: "About"
permalink: /about/
---
```

---

## Image Guidelines

### File Naming

**DO:**
- Use descriptive names: `german-sail-boat-rigging-detail.jpg`
- Use lowercase with hyphens: `winter-scene-overview.jpg`
- Include project name: `cabin-weathering-step-1.jpg`

**DON'T:**
- Use spaces: `My Photo.jpg` ❌
- Use special characters: `photo@#$.jpg` ❌
- Use generic names: `IMG_001.jpg` ❌ (unless processed from phone)

### File Size & Optimization

**Always optimize images before adding to site:**

```powershell
# Basic optimization
.\scripts\imagemagick-optimize.ps1 -SourcePath "C:\path\to\images" -OutputPath ".\assets\images\projects\project-name"

# With green screen replacement
.\scripts\imagemagick-optimize.ps1 -SourcePath "C:\path\to\images" -OutputPath ".\assets\images\projects\project-name" -ReplaceGreenScreen -BackgroundImage ".\backgrounds\sky-clouds-01.jpg"
```

**Target specs:**
- **Max width:** 1920px (will resize larger images)
- **Quality:** 85% for JPG
- **Format:** JPG for photos, PNG for graphics with transparency
- **File size:** Aim for under 500KB per image

### Image Placement

**Use relative paths with Liquid filter:**

```markdown
![German Sail Boat]({{ 'assets/images/projects/german-sail-boat/main.jpg' | relative_url }})
```

**Gallery images in front matter:**

```yaml
gallery:
  - assets/images/projects/german-sail-boat/image1.jpg
  - assets/images/projects/german-sail-boat/image2.jpg
```

Note: No leading slash, relative from root.

### Alt Text Standards

Always include descriptive alt text:

```markdown
![Close-up of rigging showing traditional knotwork and scaled rope tension]({{ 'assets/images/projects/german-sail-boat/rigging-detail.jpg' | relative_url }})
```

**Alt text should:**
- Describe what's in the image
- Be 10-20 words
- Include relevant context
- Not start with "Image of" or "Picture of"

---

## Writing Style Guide

### Tone & Voice

- **Conversational but professional** - Write like you're talking to a fellow modeler
- **First person is fine** - "I found that...", "My approach was..."
- **Be honest about mistakes** - They're valuable learning opportunities
- **Share the journey** - Include both successes and challenges

### Structure

**Every page should have:**
1. Clear introduction (what this is about)
2. Logical sections with headings
3. Practical information (materials, steps, tips)
4. Relevant links to related content
5. Images to illustrate points

**Build logs should follow:**
1. Current Build Stage
2. Work Completed Since Last Update
3. Photo Gallery
4. Techniques Used
5. Challenges & Solutions
6. Materials & Tools Used
7. Next Steps
8. Time Investment

**Technique tutorials should include:**
1. Overview (what you'll learn)
2. Difficulty & Time Required
3. Materials & Tools List
4. Step-by-Step Instructions
5. Tips & Tricks
6. Common Mistakes to Avoid
7. Project Examples
8. Variations

### Headings Hierarchy

```markdown
# Page Title (only one H1, usually from front matter)

## Major Section (H2)

### Subsection (H3)

#### Minor Point (H4)
```

**Rules:**
- Only ONE H1 per page (the title)
- Don't skip levels (H2 → H4 without H3)
- Keep headings concise (3-7 words)
- Use sentence case, not Title Case

### Lists

**Use bullet lists for:**
- Unordered items
- Materials
- Features

**Use numbered lists for:**
- Sequential steps
- Instructions
- Procedures

**Example:**
```markdown
## Materials Needed

- White glue
- Baking soda
- Texture paste
- Acrylic white paint

## Application Steps

1. Mix glue and baking soda (2:1 ratio)
2. Apply to surface with brush
3. Texture with stippling motion
4. Allow to dry completely
5. Dry brush with white paint
```

---

## Link Best Practices

### Internal Links

**Always use the relative_url filter:**

```markdown
[View All Projects]({{ '/projects/' | relative_url }})
[German Sail Boat]({{ '/projects/german-sail-boat/' | relative_url }})
[Winter Weathering]({{ '/techniques/winter-weathering/' | relative_url }})
```

**Why?** Ensures links work with GitHub Pages baseurl.

### External Links

**Open in new tab for external sites:**

```markdown
[ImageMagick Official Site](https://imagemagick.org){:target="_blank"}
```

### Link Text

**DO:**
- Use descriptive text: `[View the complete tutorial](link)`
- Be specific: `[German Sail Boat project page](link)`

**DON'T:**
- Use "click here": `[click here](link)` ❌
- Use bare URLs in text: `Visit https://example.com` ❌
- Use vague text: `[link](link)` ❌

---

## Markdown Formatting

### Emphasis

```markdown
*italic text* or _italic text_
**bold text** or __bold text__
***bold italic*** or ___bold italic___
```

### Code

**Inline code:**
```markdown
Use the `imagemagick-optimize.ps1` script.
```

**Code blocks:**
````markdown
```powershell
git add .
git commit -m "Update project"
git push
```
````

### Blockquotes

```markdown
> This is a quote or callout.
> It can span multiple lines.
```

### Horizontal Rules

```markdown
---
```

Use to separate major sections.

### Tables

```markdown
| Material      | Quantity | Cost  |
|---------------|----------|-------|
| Baking Soda   | 1 box    | £2    |
| White Glue    | 250ml    | £5    |
| Texture Paste | 500ml    | £12   |
```

### Special Kramdown Features

**Add CSS classes:**
```markdown
This paragraph will have a class.
{: .special-class}
```

**Add IDs:**
```markdown
## My Section
{: #custom-id}
```

---

## File Naming Conventions

### Consistency is Key

**Projects:** `project-name.md` (lowercase, hyphens)
```
german-sail-boat.md
ancient-forest.md
ss-great-britain.md
```

**Build Logs:** `project-name-###.md` (with build number)
```
german-sail-boat-001.md
german-sail-boat-002.md
ancient-forest-001.md
```

**Techniques:** `technique-name.md` (descriptive)
```
winter-weathering.md
rigging-basics.md
water-effects.md
scratch-building-trees.md
```

### Image Folders

Match project/content naming:
```
assets/images/projects/german-sail-boat/
assets/images/builds/german-sail-boat-001/
assets/images/techniques/winter-weathering/
```

---

## SEO Best Practices

### Page Titles

**Format:** `Specific Topic - Models4Comfort`

Front matter should have descriptive titles:
```yaml
---
title: "Winter Weathering Effects Tutorial - Realistic Snow & Ice"
---
```

### Meta Descriptions

Add to front matter for better search results:
```yaml
---
title: "My Project"
description: "Learn how to create realistic winter weathering effects including snow, ice, and frost on diorama buildings and vehicles."
---
```

### URL Structure

Keep URLs clean and descriptive:
- ✅ `/projects/german-sail-boat/`
- ✅ `/techniques/winter-weathering/`
- ❌ `/page1/` 
- ❌ `/post-123/`

### Keywords

Include relevant keywords naturally in:
- Page title
- First paragraph
- Headings
- Image alt text
- Link text

**Don't:**
- Stuff keywords unnaturally
- Repeat keywords excessively
- Use keywords in hidden text

---

## Common Mistakes to Avoid

### 1. Broken Image Paths

❌ **Wrong:**
```markdown
![Image](/assets/images/photo.jpg)  # Leading slash breaks on refresh
```

✅ **Correct:**
```markdown
![Image]({{ 'assets/images/photo.jpg' | relative_url }})
```

### 2. Broken Internal Links

❌ **Wrong:**
```markdown
[Projects](/projects/)  # Doesn't work with baseurl
```

✅ **Correct:**
```markdown
[Projects]({{ '/projects/' | relative_url }})
```

### 3. Large Unoptimized Images

❌ **Wrong:**
- Uploading 5MB images directly from camera
- Using 4000px wide images

✅ **Correct:**
- Always run through `imagemagick-optimize.ps1`
- Target 1920px max width
- Keep under 500KB per image

### 4. Inconsistent Front Matter

❌ **Wrong:**
```yaml
---
layout: project
Date: 2025-12-01  # Capital D
Status: in progress  # Inconsistent casing
---
```

✅ **Correct:**
```yaml
---
layout: project
date: 2025-12-01
status: "In Progress"
---
```

### 5. Missing Alt Text

❌ **Wrong:**
```markdown
![]({{ 'assets/images/photo.jpg' | relative_url }})
```

✅ **Correct:**
```markdown
![German sail boat showing detailed rigging work]({{ 'assets/images/photo.jpg' | relative_url }})
```

### 6. HTML in Markdown

❌ **Wrong:**
```markdown
<div class="projects-grid">
## My Projects
Content here...
</div>
```

Liquid tags won't process inside HTML blocks!

✅ **Correct:**
```markdown
## My Projects
Content here...
{: .projects-grid}
```

### 7. Skipping Git Commits

❌ **Wrong:**
- Making many changes without commits
- Using vague commit messages: "updates"

✅ **Correct:**
- Commit after each logical change
- Use descriptive messages: "Add rigging tutorial with 8 step photos"

### 8. Not Testing Locally

❌ **Wrong:**
- Push directly to GitHub without checking

✅ **Correct:**
- Preview changes locally if possible
- Check image paths work
- Verify links aren't broken
- Review on mobile view

---

## Quick Reference

### Common Tasks Checklist

**Adding a New Project:**
- [ ] Create `project-name.md` in `_projects/`
- [ ] Add front matter with all required fields
- [ ] Optimize images with script
- [ ] Place images in `assets/images/projects/project-name/`
- [ ] Add gallery array to front matter (no leading slashes)
- [ ] Use relative_url filter for all links
- [ ] Add alt text to all images
- [ ] Link to related techniques
- [ ] Commit with descriptive message

**Adding a Build Log:**
- [ ] Create `project-name-###.md` in `_builds/`
- [ ] Follow build log template structure
- [ ] Add progress photos
- [ ] Link to project page
- [ ] Reference techniques used
- [ ] Update builds.md landing page
- [ ] Commit and push

**Adding a Technique Tutorial:**
- [ ] Create `technique-name.md` in `_techniques/`
- [ ] Include all required sections
- [ ] Add step-by-step photos
- [ ] List materials/tools needed
- [ ] Show examples from projects
- [ ] Update techniques.md landing page
- [ ] Commit and push

### Publishing Workflow

```powershell
# 1. Check what's changed
git status

# 2. Review changes (optional)
git diff

# 3. Stage files
git add .
# Or specific files:
git add file1.md file2.md

# 4. Commit with message
git commit -m "Descriptive message about changes"

# 5. Push to GitHub
git push

# 6. Wait 2-3 minutes for GitHub Actions to deploy

# 7. Check live site
# https://lcilliers.github.io/hobbies-modelling4comfort/
```

### Front Matter Templates

**Quick Copy/Paste:**

```yaml
# Project
---
layout: project
title: "Project Name"
date: 2025-12-01
status: "In Progress"
difficulty: "Intermediate"
categories: [category1, category2]
tags: [tag1, tag2, tag3]
gallery:
  - assets/images/projects/project-name/image1.jpg
  - assets/images/projects/project-name/image2.jpg
---

# Build Log
---
layout: post
title: "Project Name - Build Log #001"
date: 2025-12-01
project: project-name
build_number: 1
tags: [tag1, tag2]
---

# Technique
---
layout: post
title: "Technique Name"
date: 2025-12-01
difficulty: "Intermediate"
categories: [category]
tags: [tag1, tag2]
time_required: "2-3 hours"
---
```

### Image Optimization Command

```powershell
# Basic optimization
.\scripts\imagemagick-optimize.ps1 `
  -SourcePath "\\LSUK-SYNRACK\HomeMedia\hobbies\model building\project-folder" `
  -OutputPath ".\assets\images\projects\project-name"

# With green screen
.\scripts\imagemagick-optimize.ps1 `
  -SourcePath "\\LSUK-SYNRACK\HomeMedia\hobbies\model building\project-folder" `
  -OutputPath ".\assets\images\projects\project-name" `
  -ReplaceGreenScreen `
  -BackgroundImage ".\backgrounds\sky-clouds-01.jpg"
```

### Useful Kramdown Syntax

```markdown
# Add CSS class to element
Content here
{: .css-class-name}

# Add ID
## Heading
{: #custom-id}

# Add multiple attributes
Content here
{: .class-name #custom-id}

# Link opening in new tab
[Link Text](url){:target="_blank"}
```

---

## Resources

- **Jekyll Documentation:** https://jekyllrb.com/docs/
- **Kramdown Syntax:** https://kramdown.gettalong.org/syntax.html
- **Liquid Template Language:** https://shopify.github.io/liquid/
- **GitHub Pages:** https://docs.github.com/en/pages
- **Markdown Guide:** https://www.markdownguide.org/

---

## Site-Specific Files Reference

**Configuration:**
- `_config.yml` - Site settings, baseurl, collections

**Documentation:**
- `PUBLISHING-GUIDE.md` - How to publish changes
- `IMAGEMAGICK-GUIDE.md` - Image processing details
- `SITE-EDITING-GUIDE.md` - This file
- `NEW-PAGES-SUMMARY.md` - Overview of site structure

**Scripts:**
- `scripts/imagemagick-optimize.ps1` - Image optimization
- `scripts/copy-project-images.ps1` - Copy images from network storage
- `scripts/optimize-images.ps1` - .NET fallback optimization

**Layouts:**
- `_layouts/default.html` - Base layout
- `_layouts/project.html` - Project pages
- `_layouts/post.html` - Build logs and techniques

**Styling:**
- `assets/css/main.css` - All site styles

---

*Last Updated: December 1, 2025*
*Version: 1.0*
