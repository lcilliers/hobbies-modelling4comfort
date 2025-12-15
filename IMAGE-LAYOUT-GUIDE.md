# Image Layout Guide

This guide shows how to use different image layouts in Jekyll markdown files for both build logs and project pages.

## Table of Contents
1. [Source-Narrative Approach (Recommended for Projects)](#source-narrative-approach)
2. [Build Log Image Layouts](#build-log-image-layouts)
3. [Quick Reference](#quick-reference)
4. [Best Practices](#best-practices)

---

## Source-Narrative Approach

**Recommended for:** Comprehensive project pages with integrated storytelling

### Overview

The Source-Narrative methodology uses **pure markdown** with strategically placed images throughout a narrative. This approach works best for completed projects where you're creating a comprehensive story rather than incremental build log entries.

### Key Principles

1. **Pure Markdown Only** - No HTML tags mixed with markdown
2. **Absolute Paths** - Always use `/assets/images/...` format
3. **Template-Generated Gallery** - Don't create manual galleries
4. **Strategic Placement** - Images enhance narrative flow

### Image Syntax for Projects

**Standard Inline Image:**
```markdown
![Caption describing the image](/assets/images/projects/project-name/image-file.jpg)
*Additional context or technique notes in italics below*
```

**Example in Context:**
```markdown
## Chapter 2: Foundation Construction
**Timeline: January 28 - February 3, 2024**

I began by shaping extruded polystyrene foam to create the rocky cliff foundation.

![Rocky cliff foundation](/assets/images/projects/log-cabin/log-cabin-build1-001.jpg)
*Starting with the foundation - extruded polystyrene shaped into rocky cliff face*

After shaping the basic form, I tested different cabin placements to find the optimal composition that would balance the visual weight.

![Testing cabin placement](/assets/images/projects/log-cabin/log-cabin-build1-002.jpg)
*Testing various cabin positions to find the best visual balance*
```

### Path Requirements

**✅ CORRECT - Absolute paths:**
```markdown
![Caption](/assets/images/projects/project-name/filename.jpg)
```

**❌ WRONG - Relative paths:**
```markdown
![Caption](../assets/images/project-name/filename.jpg)
![Caption](./images/filename.jpg)
![Caption](filename.jpg)
```

**❌ WRONG - Liquid template syntax in content:**
```markdown
![Caption]({{ '/assets/images/...' | relative_url }})
```

### Gallery Setup (Front Matter)

The project template automatically generates a gallery from the front matter. **Never create manual gallery sections.**

**Front Matter Example:**
```yaml
---
layout: project
title: "Project Name"
date: 2024-04-10
gallery:
  - /assets/images/projects/project-name/project-name-gallery-001.jpg
  - /assets/images/projects/project-name/project-name-gallery-002.jpg
  - /assets/images/projects/project-name/project-name-gallery-003.jpg
  - /assets/images/projects/project-name/project-name-gallery-004.jpg
---
```

**Critical Requirements:**
- Gallery paths must be **absolute** (`/assets/images/...`)
- Paths start with forward slash `/`
- Full path including filename and extension
- Template applies `relative_url` filter automatically

### Image Sizing

Project pages need CSS for proper image sizing. Add to `assets/css/main.css`:

```css
/* Project Page Images */
.page-content img {
  max-width: 600px;
  height: auto;
  display: block;
  margin: 1rem auto;
  border-radius: 4px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.page-content img + em {
  display: block;
  text-align: center;
  font-size: 0.9rem;
  color: #666;
  margin-top: 0.5rem;
  margin-bottom: 1.5rem;
}

/* Responsive sizing */
@media (max-width: 768px) {
  .page-content img {
    max-width: 100%;
  }
}
```

### Complete Project Page Example

```markdown
---
layout: project
title: "Log Cabin in the Woods - Scratch-Built Wilderness Diorama"
date: 2024-04-10
categories: [Architectural, Nature]
tags: [scratch-build, cabin, woodland, diorama]
scale: "1:35"
featured_image: /assets/images/projects/log-cabin/log-cabin-gallery-001.jpg
gallery:
  - /assets/images/projects/log-cabin/log-cabin-gallery-001.jpg
  - /assets/images/projects/log-cabin/log-cabin-gallery-002.jpg
  - /assets/images/projects/log-cabin/log-cabin-gallery-003.jpg
---

A detailed scratch-built log cabin diorama set deep in the woods, featuring 
handcrafted cabin structure with individual logs, stone chimney, and timber roof.

## Chapter 1: Concept and Planning
**Timeline: January 20-27, 2024**

Cathy's flower house kit introduced me to the skill of making small plants, 
and I love plants. I was all fired up to make some trees.

![Initial foundation](/assets/images/projects/log-cabin/log-cabin-build1-001.jpg)
*Starting with the foundation - extruded polystyrene shaped into rocky cliff*

The foundation set the stage for the entire diorama's composition.

![Testing layouts](/assets/images/projects/log-cabin/log-cabin-build1-002.jpg)
*Testing various cabin positions to find optimal placement*

## Chapter 2: Foundation Construction
**Timeline: January 28 - February 3, 2024**

[Content continues...]

## Completion

The project was completed on April 10, 2024, after 81 days of focused work.

**Completion Date:** April 10, 2024
```

### What NOT to Do

**❌ Don't mix HTML with markdown:**
```markdown
<div class="image-container">
  ![Image](/path/to/image.jpg)
</div>
```

**❌ Don't use inline styles:**
```markdown
<style>
  img { max-width: 600px; }
</style>
```

**❌ Don't create manual gallery sections:**
```markdown
## Gallery

{% for image in page.gallery %}
  <img src="{{ image }}">
{% endfor %}
```

**❌ Don't use HTML figure tags:**
```markdown
<figure>
  <img src="/path/to/image.jpg">
  <figcaption>Caption</figcaption>
</figure>
```

### Why Pure Markdown?

**Jekyll's Kramdown processor doesn't handle mixed HTML/markdown well:**
- HTML tags can break markdown rendering
- Inline styles are stripped during processing
- Template conflicts cause rendering issues
- Pure markdown ensures consistent output

### Image Organization Pattern

**Recommended naming convention:**
```
assets/images/projects/project-name/
├── project-name-build1-001.jpg  (Chapter 1 images)
├── project-name-build1-002.jpg
├── project-name-build2-001.jpg  (Chapter 2 images)
├── project-name-build2-002.jpg
├── project-name-build3-001.jpg  (Chapter 3 images)
...
├── project-name-gallery-001.jpg (Gallery images)
├── project-name-gallery-002.jpg
└── project-name-gallery-003.jpg
```

**Benefits:**
- Easy to locate images by chapter
- Clear distinction between process and gallery images
- Sequential numbering simplifies narrative flow
- Consistent naming across projects

---

## Build Log Image Layouts

**Use this for:** Single photos that should be displayed prominently

```markdown
![Description]({{ 'assets/images/builds/project/photo.jpg' | relative_url }})
*Caption: Description of the photo*
```

**Result:** Image centered, max 800px height, full width up to container

---

## Two Images Side by Side

**Use this for:** Comparing before/after, showing multiple angles, progress comparisons

```html
<div class="image-row-2">
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-002.jpg' | relative_url }}" alt="Hull port side">
    <div class="caption">Port side view showing hull construction</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-003.jpg' | relative_url }}" alt="Hull starboard side">
    <div class="caption">Starboard side view at same stage</div>
  </div>
</div>
```

**Result:** Two images in a row, equal width, gap between them. On mobile, stacks vertically.

---

## Three Images Side by Side

**Use this for:** Multiple detail shots, step-by-step sequences, different angles

```html
<div class="image-row-3">
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-012.jpg' | relative_url }}" alt="Deck forward">
    <div class="caption">Forward deck</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-013.jpg' | relative_url }}" alt="Deck midship">
    <div class="caption">Midship section</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-014.jpg' | relative_url }}" alt="Deck aft">
    <div class="caption">Aft deck detail</div>
  </div>
</div>
```

**Result:** Three images in a row, equal width, smaller gap. On mobile, stacks vertically.

---

## Image Left with Text Wrap

**Use this for:** Detailed explanations with accompanying reference image

```markdown
<img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-reference-001.jpg' | relative_url }}" alt="Historical reference" class="img-left">

This is your text content that will wrap around the image. The image will be on the left side, and the text will flow along the right side. When the text reaches below the bottom of the image, it will automatically expand to full width.

You can write multiple paragraphs, and they will all wrap naturally around the image until you've written enough text to go past the bottom of the image.

This is great for detailed explanations where you want to reference a specific photo or diagram while describing techniques or historical details.

<div class="clear"></div>
```

**Important:** 
- Use `class="img-left"` on the img tag
- Add `<div class="clear"></div>` after the wrapped text to prevent following content from wrapping
- Image max width: 350px

---

## Image Right with Text Wrap

**Use this for:** Same as left-aligned, but image on the right side

```markdown
<img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-reference-002.jpg' | relative_url }}" alt="Kit parts" class="img-right">

This text will flow on the LEFT side of the image. The image will be positioned on the right side of your content area, and text will wrap around it naturally.

This layout works well when you want the visual emphasis on the right side, or when alternating left/right aligned images throughout a longer article for visual variety.

The behavior is identical to left-aligned images, just mirrored.

<div class="clear"></div>
```

**Important:** 
- Use `class="img-right"` on the img tag
- Add `<div class="clear"></div>` after the wrapped text
- Image max width: 350px

---

## Mixing Layouts in One Build Log

You can combine all these layouts in a single build log:

```markdown
## Work Completed

This section has regular centered images showing major progress:

![Overall progress]({{ 'assets/images/builds/project/photo-001.jpg' | relative_url }})
*Caption: Major milestone completed*

## Detailed Technique Explanation

<img src="{{ 'assets/images/builds/project/reference-001.jpg' | relative_url }}" alt="Reference photo" class="img-left">

Here I'm explaining a specific technique. The reference photo is on the left, and I can write detailed instructions that wrap around it. This is perfect for tutorial-style content where you want the reader to reference the image while reading your explanation.

<div class="clear"></div>

## Multiple Angle Views

<div class="image-row-3">
  <div>
    <img src="{{ 'assets/images/builds/project/photo-010.jpg' | relative_url }}" alt="Front view">
    <div class="caption">Front</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/project/photo-011.jpg' | relative_url }}" alt="Side view">
    <div class="caption">Side</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/project/photo-012.jpg' | relative_url }}" alt="Top view">
    <div class="caption">Top</div>
  </div>
</div>

## Before and After Comparison

<div class="image-row-2">
  <div>
    <img src="{{ 'assets/images/builds/project/photo-020.jpg' | relative_url }}" alt="Before">
    <div class="caption">Before weathering</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/project/photo-021.jpg' | relative_url }}" alt="After">
    <div class="caption">After weathering applied</div>
  </div>
</div>
```

---

## Quick Reference

| Layout | Code | Best For |
|--------|------|----------|
| **Centered** | Regular markdown `![alt](url)` | Main photos, hero shots |
| **2 in row** | `<div class="image-row-2">` | Comparisons, before/after |
| **3 in row** | `<div class="image-row-3">` | Detail sequences, multi-angle |
| **Left wrap** | `<img class="img-left">` | Technique explanations, tutorials |
| **Right wrap** | `<img class="img-right">` | Same as left, mirrored |

---

## Responsive Behavior

All layouts are **mobile-friendly**:
- **Centered images**: Scale down naturally
- **Image rows**: Stack vertically on narrow screens
- **Wrapped images**: Become full-width centered on mobile
- **Captions**: Always stay with their images

---

## Tips for Best Results

1. **Image rows work best with similar-sized images** - They'll all be cropped to the same height
2. **Use wrapped images for reference photos** - Great for detailed explanations
3. **Don't forget `<div class="clear"></div>`** after wrapped images
4. **Alternate layouts for visual interest** - Mix centered, rows, and wrapped throughout
5. **Caption consistency** - Use captions for all images in a row
6. **Test on mobile** - Preview how your layouts look on different screen sizes

---

## Common Patterns

### Progress Documentation Pattern
```markdown
![Overview](url)
*Overall progress at this stage*

<div class="image-row-3">
  <div><img src="detail1" alt="Detail 1"><div class="caption">Detail view 1</div></div>
  <div><img src="detail2" alt="Detail 2"><div class="caption">Detail view 2</div></div>
  <div><img src="detail3" alt="Detail 3"><div class="caption">Detail view 3</div></div>
</div>
```

### Technique Tutorial Pattern
```markdown
<img src="reference-photo.jpg" class="img-left">

Explanation of the technique with the reference photo on the left...

<div class="clear"></div>

<div class="image-row-2">
  <div><img src="step1.jpg"><div class="caption">Step 1</div></div>
  <div><img src="step2.jpg"><div class="caption">Step 2</div></div>
</div>
```

### Comparison Pattern
```markdown
<div class="image-row-2">
  <div><img src="option-a.jpg"><div class="caption">Method A result</div></div>
  <div><img src="option-b.jpg"><div class="caption">Method B result</div></div>
</div>

As you can see from the comparison above...
```

---

**Need help?** Refer to this guide when adding photos to your build logs and project pages.

---

## Best Practices

### Choosing Between Approaches

**Use Source-Narrative (Pure Markdown) For:**
- ✅ Comprehensive project pages
- ✅ Completed projects
- ✅ Portfolio-quality presentation
- ✅ Single cohesive narrative
- ✅ When all content/images ready

**Use Build Log Layouts (HTML + Markdown) For:**
- 📝 Incremental build updates
- 📝 Projects in progress
- 📝 Real-time documentation
- 📝 Multiple comparison layouts needed
- 📝 Side-by-side image comparisons

### General Image Guidelines

**File Naming:**
- Use descriptive, consistent names
- Include project name in filename
- Use sequential numbering
- Separate process from gallery images
- Example: `project-name-build1-001.jpg`

**File Organization:**
```
assets/images/
├── projects/
│   └── project-name/
│       ├── project-name-build1-001.jpg
│       ├── project-name-build2-001.jpg
│       └── project-name-gallery-001.jpg
└── builds/
    └── project-name/
        ├── update-001.jpg
        └── update-002.jpg
```

**Image Quality:**
- Inline/process images: 600-800px wide
- Gallery images: 1200-1600px wide
- Compress appropriately (balance quality/size)
- Consistent aspect ratios preferred
- Good lighting and focus

**Caption Strategy:**
- Caption describes what's shown (in brackets or alt text)
- Italic text below provides context/technique
- Keep captions concise (one sentence)
- Use context text for detailed explanations

### CSS Integration

**For Project Pages** - Add to `assets/css/main.css`:
```css
/* Project-specific image sizing */
.page-content img {
  max-width: 600px;
  height: auto;
  display: block;
  margin: 1rem auto;
}

@media (max-width: 768px) {
  .page-content img {
    max-width: 100%;
  }
}
```

**For Build Logs** - Layouts already configured in site CSS:
- `.image-row-2` - Two images side by side
- `.image-row-3` - Three images side by side
- `.img-left` / `.img-right` - Text wrapping

### Troubleshooting

**Images not displaying:**
- ✓ Check path is absolute (`/assets/images/...`)
- ✓ Verify file exists at that location
- ✓ Confirm filename matches exactly (case-sensitive)
- ✓ Check for typos in path

**Images too large:**
- ✓ Add CSS max-width rules
- ✓ Check responsive breakpoints
- ✓ Verify CSS file is loading

**Gallery not appearing:**
- ✓ Check front matter gallery array exists
- ✓ Verify paths are absolute
- ✓ Ensure no manual gallery section in markdown
- ✓ Confirm using `layout: project` in front matter

**Layout broken:**
- ✓ Remove HTML tags from markdown
- ✓ Use pure markdown syntax
- ✓ Check for unclosed HTML tags
- ✓ Verify no inline styles

---

## Additional Resources

- **SOURCE-NARRATIVE-METHODOLOGY.md** - Complete workflow guide
- **SITE-EDITING-GUIDE.md** - General site editing
- **PUBLISHING-GUIDE.md** - Deployment workflows
- **LESSONS-LEARNED.md** - Technical pitfalls and solutions

---

*Last updated: December 15, 2025*
