# Site Editing Guide - Standards & Tips

A comprehensive guide to editing and maintaining your Models4Comfort website, including best practices, standards, and helpful tips.

---

## Table of Contents

1. [Hiding Content from Publication](#hiding-content-from-publication)
2. [Front Matter Standards](#front-matter-standards)
3. [Image Guidelines](#image-guidelines)
4. [Image Layout Options](#image-layout-options)
5. [Writing Style Guide](#writing-style-guide)
6. [Link Best Practices](#link-best-practices)
7. [Markdown Formatting](#markdown-formatting)
8. [Build Log Organization & Naming](#build-log-organization--naming)
9. [File Naming Conventions](#file-naming-conventions)
10. [SEO Best Practices](#seo-best-practices)
11. [Common Mistakes to Avoid](#common-mistakes-to-avoid)
12. [Feedback & Contact Forms](#feedback--contact-forms)
13. [Quick Reference](#quick-reference)

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

### Photo Gallery Display

To display a photo gallery in project pages, use this code snippet:

**Step 1: Add gallery images to front matter**

```yaml
---
layout: project
title: "Your Project"
gallery:
  - assets/images/projects/project-name/image1.jpg
  - assets/images/projects/project-name/image2.jpg
  - assets/images/projects/project-name/image3.jpg
  - assets/images/projects/project-name/image4.jpg
---
```

**Step 2: Add gallery display code in your markdown**

```liquid
## Photo Gallery

<div class="gallery-grid">
{% for image in page.gallery %}
  <div class="gallery-item">
    <img src="{{ image | relative_url }}" alt="Project name - {{ forloop.index }}" loading="lazy">
  </div>
{% endfor %}
</div>
```

**Features:**
- Automatically loops through all images in the `gallery:` array
- Uses responsive grid layout from `main.css`
- Adds proper alt text with image number
- Includes lazy loading for better performance
- Click images to view in lightbox (via `main.js`)

**Customization:**
- Change the alt text to be more descriptive for your project
- Adjust the number of images by adding/removing from the gallery array
- The grid automatically adjusts based on screen size

---

## Image Layout Options

For detailed information about advanced image layouts in build logs, see **[IMAGE-LAYOUT-GUIDE.md](IMAGE-LAYOUT-GUIDE.md)**.

### Quick Overview

You have multiple layout options for displaying images:

**1. Default Centered (Single Images)**
```markdown
![Description]({{ 'assets/images/builds/project/photo.jpg' | relative_url }})
*Caption: Description*
```

**2. Two Images Side by Side**
```html
<div class="image-row-2">
  <div>
    <img src="{{ 'path/photo1.jpg' | relative_url }}" alt="Description">
    <div class="caption">Caption 1</div>
  </div>
  <div>
    <img src="{{ 'path/photo2.jpg' | relative_url }}" alt="Description">
    <div class="caption">Caption 2</div>
  </div>
</div>
```

**3. Three Images Side by Side**
```html
<div class="image-row-3">
  <!-- Similar structure with three images -->
</div>
```

**4. Image Left with Text Wrap**
```markdown
<img src="photo.jpg" class="img-left" alt="Description">

Your text wraps around the image on the right...

<div class="clear"></div>
```

**5. Image Right with Text Wrap**
```markdown
<img src="photo.jpg" class="img-right" alt="Description">

Your text wraps around the image on the left...

<div class="clear"></div>
```

### When to Use Each Layout

- **Centered**: Main photos, hero shots, important progress images
- **2-in-row**: Before/after comparisons, two-angle views
- **3-in-row**: Detail sequences, multi-angle documentation
- **Left/Right wrap**: Technique explanations, reference photos with detailed text

**→ See [IMAGE-LAYOUT-GUIDE.md](IMAGE-LAYOUT-GUIDE.md) for complete examples and code samples**

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

### Anchor Links (Jumping to Sections)

**Jekyll automatically creates anchor IDs from headings:**

- Converts to lowercase
- Replaces spaces with hyphens
- Removes special characters

**Examples:**

```markdown
## Build Logs by Project
```
Creates anchor: `#build-logs-by-project`

```markdown
## Latest Build Updates (Last 10)
```
Creates anchor: `#latest-build-updates-last-10`

**Link to these sections:**

```markdown
[View build logs by project]({{ '/builds/#build-logs-by-project' | relative_url }})
[Jump to SS Great Britain section]({{ '/builds/#ss-great-britain' | relative_url }})
```

**Within the same page:**

```markdown
[Back to top](#top)
[See the techniques section](#techniques)
```

**Custom anchor IDs (if needed):**

```markdown
## My Section {#custom-id}
```

Then link with: `[Link text](#custom-id)`

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

## Build Log Organization & Naming

### Documentation Approaches: When to Use Each

The site supports two distinct approaches for documenting projects:

#### 1. Comprehensive Project Pages (Source-Narrative)
**Best for:** Completed projects, portfolio showcases, comprehensive retrospectives

A single, cohesive project page that tells the complete story from concept to completion with integrated images throughout the narrative.

**Characteristics:**
- Single markdown file in `_projects/`
- Organized into 6-10 chronological chapters
- 40-50+ inline images integrated throughout narrative
- Template-generated gallery from front matter
- Pure markdown (no HTML tags)
- Professional portfolio presentation
- Complete story in one place

**Example:** `_projects/log-cabin.md` (679 lines, 9 chapters, 50 images)

**Use when:**
- ✅ Project is completely finished
- ✅ You have all images and content ready
- ✅ Want polished, portfolio-quality presentation
- ✅ Story flows better as unified narrative
- ✅ Retrospective documentation

**Front Matter Example:**
```yaml
---
layout: project
title: "Log Cabin in the Woods - Scratch-Built Wilderness Diorama"
date: 2024-04-10
categories: [Architectural, Nature]
tags: [scratch-build, cabin, woodland]
scale: "1:35"
featured_image: /assets/images/projects/log-cabin/log-cabin-gallery-001.jpg
gallery:
  - /assets/images/projects/log-cabin/log-cabin-gallery-001.jpg
  - /assets/images/projects/log-cabin/log-cabin-gallery-002.jpg
  - /assets/images/projects/log-cabin/log-cabin-gallery-003.jpg
---
```

**See:** [SOURCE-NARRATIVE-METHODOLOGY.md](SOURCE-NARRATIVE-METHODOLOGY.md) for complete workflow

#### 2. Incremental Build Logs
**Best for:** Projects in progress, real-time updates, collaborative projects

Multiple build log entries documenting progress as it happens, organized by project folder.

**Characteristics:**
- Multiple markdown files in `_builds/project-name/`
- Each entry = distinct build session or phase
- Sequential numbering (001-, 002-, 003-)
- Real-time documentation during construction
- Can include detailed comparisons and layouts
- Easier to update incrementally

**Example:** `_builds/ss-great-britain/` (5 build log files)

**Use when:**
- ✅ Project is currently in progress
- ✅ Want to document as you build
- ✅ Learning/process documentation is priority
- ✅ Project might pause and resume
- ✅ Multiple people contributing
- ✅ Frequent incremental updates

**Front Matter Example:**
```yaml
---
layout: build
title: "SS Great Britain - Build Log #002: Hull Construction"
date: 2022-02-10
project: ss-great-britain
step: 2
materials: [balsa wood, styrene, brass rod]
tags: [hull, construction, scratch-building]
---
```

#### Comparison Table

| Aspect | Project Page | Build Logs |
|--------|--------------|------------|
| **Files** | 1 comprehensive file | Multiple incremental files |
| **When** | After completion | During construction |
| **Narrative** | Unified story | Episodic updates |
| **Images** | 40-50+ integrated | 5-10 per entry |
| **Organization** | Chapters | Sequential entries |
| **Maintenance** | Single file to update | Multiple files |
| **Presentation** | Portfolio quality | Process documentation |
| **Gallery** | Template auto-generated | Manual in each entry |
| **Best For** | Showcasing finished work | Learning/process docs |

#### Transitioning from Build Logs to Project Page

When a project is complete, you may want to create a comprehensive project page:

**Option 1: Archive Build Logs**
Create a redirect README in the build logs folder:

```markdown
---
layout: build  
title: "Project Name - Build Documentation"
date: 2024-01-20
project: project-name
excerpt: "Complete build documentation has been incorporated into the main project page."
---

## Build Documentation Moved

The complete build process for this project has been incorporated into the main 
project page as a comprehensive narrative.

**[View the complete project story →]({{ '/projects/project-name/' | relative_url }})**

The project page includes:
- Full build narrative from concept to completion
- X chronological chapters covering all construction phases
- XX integrated build process images
- X-image gallery of the finished diorama

*Project completed: YYYY-MM-DD*
```

Then delete the old individual build log files, keeping only the README redirect.

**Option 2: Keep Both**
Maintain both build logs (process documentation) and project page (final showcase).
- Build logs show real-time construction journey
- Project page presents polished final narrative
- Cross-link between them for different audiences

#### Template Behavior - Auto-Generated Galleries

**CRITICAL**: The `project` layout template automatically generates galleries.

**How It Works:**
1. Template reads `gallery:` array from front matter
2. Auto-generates `<section class="project-gallery">` at bottom of page
3. Creates grid layout with all gallery images
4. Applies `relative_url` filter to each path

**Template Code** (`_layouts/project.html`):
```html
{% if page.gallery %}
<section class="project-gallery">
  <h2>Gallery</h2>
  <div class="gallery-grid">
    {% for image in page.gallery %}
    <div class="gallery-item">
      <img src="{{ image | relative_url }}" alt="{{ page.title }} - Gallery Image">
    </div>
    {% endfor %}
  </div>
</section>
{% endif %}
```

**Requirements:**
- ✅ Gallery paths must be **absolute**: `/assets/images/projects/name/file.jpg`
- ✅ Paths start with forward slash `/`
- ✅ Include full path and filename
- ❌ Never create manual gallery sections in markdown
- ❌ Don't use relative paths (just filenames won't work)

**Why Absolute Paths?**
Template applies `{{ image | relative_url }}` filter which needs the full path from site root to resolve correctly.

### Folder Structure

Build logs are organized by project in separate folders within `_builds/`:

```
_builds/
  ├── log-cabin/
  │   ├── 001-project-planning.md
  │   ├── 002-foundation-walls.md
  │   └── 003-roof-construction.md
  ├── ss-great-britain/
  │   ├── 001-planning-research.md
  │   ├── 002-hull-construction.md
  │   ├── 003-decking.md
  │   └── 004-sails-and-rigging.md
  └── german-sail-boat/
      └── 001-initial-assembly.md
```

### Why This Structure Works

**✅ Each folder is a unique namespace:**
- Files in different folders don't conflict
- Jekyll creates unique URLs: `/builds/project-name/001-phase/`
- Easy to find all logs for a specific project

**✅ Consistent numbering across projects is GOOD:**
- Every project can have `001-planning.md`
- Numbers show sequence within each project
- Predictable organization makes maintenance easier

**✅ Folder name provides project context:**
- No need to include project name in filename
- Keeps filenames shorter and cleaner
- `001-planning.md` is better than `ss-great-britain-001-planning.md`

### Naming Convention for Build Logs

**Pattern:** `###-descriptive-phase.md`

**Examples:**
- `001-planning-research.md` - Initial planning and research
- `002-hull-construction.md` - Hull building phase
- `003-painting-weathering.md` - Painting and weathering
- `004-final-assembly.md` - Final assembly
- `005-completion.md` - Project completion

**Best Practices:**

1. **Use sequential numbers starting at 001:**
   ```
   001-planning.md
   002-construction.md
   003-detailing.md
   ```

2. **Keep phase names descriptive but concise:**
   - ✅ `001-planning-research.md`
   - ✅ `002-hull-construction.md`
   - ❌ `001-p.md` (too vague)
   - ❌ `001-initial-planning-phase-and-material-research.md` (too long)

3. **Use consistent phase naming across projects:**
   - Most projects start with planning/research
   - Similar projects use similar phase names
   - Makes it easier to understand progress across portfolio

### Linking Build Logs to Projects

Use the `project:` field in front matter to link build logs to their project page:

**In build log file:**
```yaml
---
layout: post
title: "SS Great Britain - Build Log #001: Planning"
project: ss-great-britain  # Must match project file name
build_number: 1
---
```

**Corresponding project file:**
```
_projects/ss-great-britain.md  # Filename matches project: field
```

**This creates connections for:**
- "View all logs for this project" links
- Filtering build logs by project
- Project page showing associated logs
- Navigation between related content

### Common Questions

**Q: Can two projects have the same build log number?**  
**A:** Yes! Each project folder is independent. Both `log-cabin/001-planning.md` and `ss-great-britain/001-planning.md` coexist without conflict.

**Q: Do I need to include the project name in the filename?**  
**A:** No. The folder name provides the project context. Just use `001-phase.md` not `project-001-phase.md`.

**Q: What if I want to add a log between 002 and 003?**  
**A:** Use decimals: `002.5-intermediate-phase.md` or renumber all subsequent files. Renumbering is cleaner but more work.

**Q: Can I skip numbers?**  
**A:** Technically yes, but don't. Sequential numbering (001, 002, 003) is clearest.

### URL Structure Generated

Jekyll creates URLs from the folder structure:

```
File: _builds/ss-great-britain/001-planning-research.md
URL:  /builds/ss-great-britain/001-planning-research/

File: _builds/log-cabin/001-project-planning.md  
URL:  /builds/log-cabin/001-project-planning/
```

These URLs are completely unique even though both use number 001.

---

## File Naming Conventions

### Consistency is Key

**Projects:** `project-name.md` (lowercase, hyphens)
```
german-sail-boat.md
ancient-forest.md
ss-great-britain.md
```

**Build Logs:** `_builds/project-name/###-phase.md` (folder structure)
```
_builds/ss-great-britain/001-planning.md
_builds/ss-great-britain/002-hull-construction.md
_builds/log-cabin/001-project-planning.md
```
See **[_builds/README.md](_builds/README.md)** for complete build log organization guide.

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
assets/images/projects/ss-great-britain/
assets/images/builds/ss-great-britain/
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

## Feedback & Contact Forms

### Enabling Feedback CTAs on Pages

The site uses a privacy-focused feedback system that directs visitors to a contact form instead of embedding third-party commenting systems.

#### How to Enable Feedback CTAs

Add `comments: true` to the front matter of any project or build log page:

```yaml
---
layout: project
title: "Log Cabin in the Woods"
date: 2024-04-10
comments: true  # This enables the feedback CTA
categories: dioramas
tags: [scratch-build, landscaping]
---
```

**What happens:**
- A subtle call-to-action appears at the bottom of the page
- For projects: "Enjoyed this project? Have questions or suggestions? I'd love to hear from you."
- For build logs: "Questions about this build step? Send me a message — I'm happy to help!"
- Links direct visitors to `/feedback/` page

#### Customizing CTA Text

CTAs are defined in layout templates:
- **Project pages:** `_layouts/project.html` (`.project-feedback` section)
- **Build logs:** `_layouts/build.html` (`.build-feedback` section)

Edit these templates to change wording or styling.

#### Styling

Feedback CTAs use these CSS classes in `assets/css/main.css`:
- `.build-feedback` / `.project-feedback` - Container styling
- Green left border and light gray background for subtle emphasis
- Responsive design included

**Example customization:**

```css
.project-feedback {
  background-color: #e8f5e9;  /* Light green background */
  border-left: 4px solid #2e7d32;  /* Darker green border */
  padding: 1.5rem;
}
```

### The Feedback Form

The main contact form is at `/feedback/` (`feedback.md` in root directory).

**Key features:**
- Uses Formspree for form handling (https://formspree.io)
- No tracking scripts or third-party embeds
- Honeypot spam protection built-in
- Mobile-responsive design
- Direct email notification to site owner

**For detailed setup and configuration, see:** [FEEDBACK-FORM-GUIDE.md](FEEDBACK-FORM-GUIDE.md)

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
- [ ] Use `scripts/new-build-log.ps1` or create manually in `_builds/project-name/###-title.md`
- [ ] Follow build log template structure (see _builds/TEMPLATE-build-log.md)
- [ ] Add progress photos to `assets/images/builds/project-name/`
- [ ] Link to project page using `project:` front matter field
- [ ] Reference techniques used
- [ ] Builds.md automatically lists new logs (no manual update needed)
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
