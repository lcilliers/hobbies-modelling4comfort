# Front Matter Guide

## What is Front Matter?

Front matter is metadata at the top of a markdown file, enclosed between `---` markers. Jekyll uses this to configure how the page is built and displayed.

```yaml
---
layout: post
title: "My Page Title"
date: 2025-12-03
---
```

## Required Fields

### layout
**Purpose:** Determines which HTML template is used to render the page

**Common values:**
- `post` - For blog posts and build logs (uses `_layouts/post.html`)
- `project` - For project landing pages (uses `_layouts/project.html`)
- `build` - For build log entries (uses `_layouts/build.html`)
- `default` - Basic page layout (uses `_layouts/default.html`)

**Example:**
```yaml
layout: post
```

**Implications:**
- Different layouts have different structures and styling
- Build logs should use `post` or `build` layout
- Project pages should use `project` layout
- The layout file controls what sections appear (header, footer, comments, etc.)

### title
**Purpose:** The page title displayed in browser tabs and as the main heading

**Format:** String in quotes

**Example:**
```yaml
title: "SS Great Britain - Build Log #001: Planning & Research"
```

**Implications:**
- Shows in browser title bar/tab
- Used in navigation and lists
- Important for SEO
- Can include special characters and emojis

**Best practices:**
- Be descriptive and specific
- Include project name and log number for build logs
- Keep under 60 characters for SEO

### date
**Purpose:** Sets the publication date for the post

**Format:** `YYYY-MM-DD` or `YYYY-MM-DD HH:MM:SS`

**Example:**
```yaml
date: 2021-12-25
date: 2021-12-25 14:30:00
```

**Implications:**
- Controls sort order in build log listings (newest first)
- Can affect URL structure (depending on permalink settings)
- Used in "Recent Posts" lists
- Future dates can hide posts until that date

**Best practices:**
- Use actual build date for chronological accuracy
- Update when making major revisions
- Consistent format across all posts

## Optional Custom Fields

### project
**Purpose:** Links this build log to a specific project

**Format:** The project slug (filename without `.md`)

**Example:**
```yaml
project: ss-great-britain
```

**Implications:**
- Must match the filename in `_projects/` folder (e.g., `_projects/ss-great-britain.md`)
- Used to filter build logs by project
- Enables "All logs for this project" links
- Creates relationship between build logs and project pages

**How to use:**
1. Create project file: `_projects/my-project.md`
2. In build log, set: `project: my-project`
3. Jekyll can now link them together

### build_number
**Purpose:** Sequential number for this build log entry

**Format:** Number or string

**Example:**
```yaml
build_number: 1
build_number: "#001"
build_number: "001"
```

**Implications:**
- Helps organize build logs in sequence
- Can be displayed as "Build Log #1", "Log 001", etc.
- Used for "Previous/Next" navigation
- Useful for filtering and sorting

**Best practices:**
- Start at 1 for each new project
- Use consistent format within a project
- Increment sequentially

### categories
**Purpose:** Broad classification of the post

**Format:** Array (list) of category names

**Example:**
```yaml
categories: [ships, planning]
categories: [terrain, buildings]
categories: [vehicles, weathering]
```

**Implications:**
- Creates category archive pages (e.g., `/categories/ships/`)
- Can be used in URL structure
- Groups related content
- Typically used for broad topics

**Common categories:**
- `ships`, `vehicles`, `buildings`, `terrain`, `figures`
- `planning`, `construction`, `painting`, `weathering`, `completion`
- `scratch-build`, `kit-bash`, `diorama`

### tags
**Purpose:** Specific keywords describing the content

**Format:** Array (list) of tag names

**Example:**
```yaml
tags: [research, planning, kit-review, scratch build, reference-materials]
tags: [hull construction, metalwork, rigging, steam-era]
tags: [weathering, rust effects, metal finish]
```

**Implications:**
- Creates tag archive pages
- More granular than categories
- Used for search and filtering
- Can have many tags per post

**Best practices:**
- Use lowercase with hyphens (kebab-case)
- 5-10 tags per post
- Be specific and descriptive
- Use consistent tag names across posts

**Example tags by type:**
- Techniques: `weathering`, `dry-brushing`, `airbrushing`, `scratch-building`
- Materials: `photo-etch`, `brass`, `resin`, `plastic-kit`
- Subjects: `ships`, `trains`, `aircraft`, `buildings`, `figures`
- Stages: `planning`, `assembly`, `painting`, `finishing`

### excerpt
**Purpose:** Short summary/description of the post

**Format:** String in quotes

**Example:**
```yaml
excerpt: "Starting the ambitious SS Great Britain project with extensive research, reference gathering, and planning the build approach."
```

**Implications:**
- Shown in post listings and previews
- Used in social media shares
- Important for SEO (meta description)
- Gives readers a preview before clicking

**Best practices:**
- 150-160 characters ideal
- Summarize the main point
- Entice readers to click
- Include key information

## Standard Jekyll Fields

### permalink
**Purpose:** Custom URL for the page

**Example:**
```yaml
permalink: /builds/ss-great-britain/001-planning/
```

**Implications:**
- Overrides default URL structure
- Use for clean, memorable URLs
- Must be unique across site

### published
**Purpose:** Control whether post is visible

**Format:** Boolean (`true` or `false`)

**Example:**
```yaml
published: false
```

**Implications:**
- `false` = draft, won't appear on site
- `true` = published (default if omitted)
- Useful for work-in-progress posts

### image
**Purpose:** Featured image for the post

**Example:**
```yaml
image: /assets/images/builds/ss-great-britain/featured.jpg
```

**Implications:**
- Used in social media shares
- Can appear in post listings
- Important for visual appeal

### author
**Purpose:** Post author name

**Example:**
```yaml
author: Models4Comfort
```

**Implications:**
- Shows author byline
- Can link to author pages
- Useful for multi-author sites

## Complete Example

### Build Log Front Matter
```yaml
---
layout: post
title: "SS Great Britain - Build Log #003: Deck Construction"
date: 2022-03-15
project: ss-great-britain
build_number: 3
categories: [ships, construction]
tags: [deck-planking, wood-work, detail-parts, photo-etch]
excerpt: "Installing wooden deck planking and adding photo-etched detail parts to the SS Great Britain model."
image: /assets/images/builds/ss-great-britain/deck-progress.jpg
---
```

### Project Page Front Matter
```yaml
---
layout: project
title: "SS Great Britain"
status: in-progress
difficulty: advanced
scale: "1:150"
category: ships
start_date: 2021-12-25
tags: [iron-hulled-ship, steam-sail, brunel, historical-vessel]
excerpt: "Building a detailed model of Brunel's revolutionary SS Great Britain, the first ocean-going iron-hulled ship."
featured_image: /assets/images/projects/ss-great-britain/hero-shot.jpg
---
```

## How Jekyll Uses Front Matter

1. **Page Generation:**
   - Selects layout template
   - Injects title, date, content into template
   - Generates final HTML page

2. **Collections:**
   - Groups posts by category/tag
   - Creates archive pages
   - Builds navigation links

3. **Filtering:**
   - Show all posts with `project: ss-great-britain`
   - List all posts in `ships` category
   - Find posts tagged with `weathering`

4. **Sorting:**
   - Order posts by date (newest first)
   - Sequence build logs by build_number

5. **Conditionals:**
   - Show/hide elements based on front matter
   - "If project is set, show project link"
   - "If status is 'completed', show completion date"

## Accessing Front Matter in Templates

In your layout files (`_layouts/*.html`), you can access front matter:

```liquid
{{ page.title }}
{{ page.date | date: "%B %d, %Y" }}
{{ page.excerpt }}
{{ page.project }}

{% if page.build_number %}
  Build Log #{{ page.build_number }}
{% endif %}

{% for tag in page.tags %}
  <span class="tag">{{ tag }}</span>
{% endfor %}
```

## Tips & Best Practices

### Consistency
- Use same field names across all posts
- Standardize date formats
- Keep categories/tags consistent (avoid `ship` vs `ships`)

### Required Minimum
Every post should have:
```yaml
layout: post
title: "Your Title"
date: YYYY-MM-DD
```

### Build Logs Should Include
```yaml
layout: post
title: "Project Name - Build Log #XXX: Phase"
date: YYYY-MM-DD
project: project-slug
build_number: X
categories: [type, stage]
tags: [techniques, materials, specific-topics]
excerpt: "Brief description"
```

### Project Pages Should Include
```yaml
layout: project
title: "Project Name"
status: planning|in-progress|completed
difficulty: beginner|intermediate|advanced
scale: "1:XX"
category: ships|vehicles|buildings|terrain
excerpt: "Project description"
```

## Common Mistakes to Avoid

1. **Missing quotes around titles with colons:**
   ```yaml
   title: My Title: With Colon  # ❌ Breaks YAML
   title: "My Title: With Colon"  # ✅ Correct
   ```

2. **Wrong date format:**
   ```yaml
   date: 12/25/2021  # ❌ Wrong
   date: 2021-12-25  # ✅ Correct
   ```

3. **Mismatched project slugs:**
   ```yaml
   # In build log:
   project: ss-great-britain
   # But project file is: _projects/ss_great_britain.md  # ❌ Won't link
   # Should be: _projects/ss-great-britain.md  # ✅ Matches
   ```

4. **Inconsistent tags:**
   ```yaml
   # Post 1: tags: [scratch build]
   # Post 2: tags: [scratch-build]  # Creates two separate tags!
   # Use: tags: [scratch-build]  # Consistent across all posts
   ```

5. **Missing layout:**
   ```yaml
   # Front matter without layout won't render properly
   layout: post  # Always include!
   ```

## Resources

- **Jekyll Documentation:** https://jekyllrb.com/docs/front-matter/
- **YAML Syntax:** https://yaml.org/spec/1.2.2/
- **Liquid Templating:** https://shopify.github.io/liquid/
- **Your Layouts:** Check `_layouts/` folder to see available options
- **Your Current Posts:** Look at existing files in `_builds/` for examples

## Quick Reference

| Field | Required? | Type | Purpose |
|-------|-----------|------|---------|
| `layout` | Yes | String | Template to use |
| `title` | Yes | String | Page title |
| `date` | Yes | Date | Publication date |
| `project` | Optional | String | Link to project |
| `build_number` | Optional | Number/String | Log sequence number |
| `categories` | Optional | Array | Broad classifications |
| `tags` | Optional | Array | Specific keywords |
| `excerpt` | Optional | String | Summary/description |
| `published` | Optional | Boolean | Draft or published |
| `permalink` | Optional | String | Custom URL |
| `image` | Optional | String | Featured image path |

---

**Need more help?** Check the existing build logs in `_builds/ss-great-britain/` for real-world examples!
