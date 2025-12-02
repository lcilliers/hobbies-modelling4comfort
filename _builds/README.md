# Build Logs Folder Structure

This folder contains individual build log entries organized by project.

## Folder Organization

```
_builds/
  ├── TEMPLATE-build-log.md          # Copy this for new build logs
  ├── ss-great-britain/
  │   ├── 001-planning-research.md
  │   ├── 002-hull-construction.md
  │   └── ...
  ├── gorch-fock/
  │   ├── 001-kit-review.md
  │   └── ...
  └── [project-name]/
      └── ###-stage-title.md
```

## File Naming Convention

Format: `###-descriptive-title.md`

Examples:
- `001-planning-research.md`
- `002-hull-construction.md`
- `003-deck-assembly.md`
- `010-rigging-begins.md`

**Tips:**
- Use 3-digit numbers (001, 002, not 1, 2)
- Use hyphens, not spaces
- Keep titles short but descriptive
- Numbers ensure proper chronological sorting

## Creating a New Build Log

### Method 1: PowerShell Script (Easiest & Recommended)

Use the `new-build-log.ps1` script to automatically create a new build log:

```powershell
.\scripts\new-build-log.ps1 -ProjectName "project-name" -BuildNumber 2 -Title "stage-description"
```

**Parameters:**
- `-ProjectName` - Project slug (e.g., "ss-great-britain", "gorch-fock")
- `-BuildNumber` - Sequential number (1, 2, 3, etc.)
- `-Title` - Short description with hyphens (e.g., "hull-construction")
- `-Date` - Optional: Date in YYYY-MM-DD format (defaults to today)
- `-OpenInEditor` - Optional: Opens file in VS Code after creation

**Examples:**

```powershell
# Create build log #2 for SS Great Britain
.\scripts\new-build-log.ps1 -ProjectName "ss-great-britain" -BuildNumber 2 -Title "hull-construction"

# Create with specific date and open in editor
.\scripts\new-build-log.ps1 -ProjectName "gorch-fock" -BuildNumber 1 -Title "kit-review" -Date "2025-12-01" -OpenInEditor

# Create first log for new project (folder will be created automatically)
.\scripts\new-build-log.ps1 -ProjectName "new-project" -BuildNumber 1 -Title "planning"
```

**What the script does:**
- ✓ Creates project folder if it doesn't exist
- ✓ Copies template to correct location with proper naming
- ✓ Updates front matter (title, date, project, build_number)
- ✓ Formats build number with leading zeros (001, 002, etc.)
- ✓ Shows next steps for editing and committing

### Method 2: Copy Template Manually

1. Copy `TEMPLATE-build-log.md`
2. Rename to your project folder: `_builds/project-name/###-title.md`
3. Edit the front matter (date, title, project, etc.)
4. Fill in the content sections
5. Add photos to `assets/images/builds/project-name/`
6. Commit and push

### Method 3: GitHub Web Editor

1. Go to your repository on github.com
2. Navigate to `_builds/your-project/`
3. Click "Add file" → "Create new file"
4. Name it: `###-title.md`
5. Copy/paste template content
6. Edit and commit

### Method 3: GitHub.dev (VS Code in Browser)

1. Go to your repo on GitHub
2. Press `.` (period key) - opens VS Code in browser
3. Navigate to `_builds/your-project/`
4. Create new file
5. Edit and commit directly

## Front Matter Requirements

Every build log must have:

```yaml
---
layout: post                          # Always use 'post'
title: "Project - Build Log #XXX"    # Descriptive title
date: YYYY-MM-DD                      # ISO format date
project: project-slug                 # Must match folder name
build_number: XXX                     # Sequential number
categories: [cat1, cat2]              # For filtering
tags: [tag1, tag2, tag3]             # For search
excerpt: "One sentence summary"       # Shows in listings
---
```

**Important:**
- `project:` must match the folder name (e.g., `ss-great-britain`)
- `date:` determines sort order (newer = higher in list)
- `excerpt:` appears in the builds.md listing
- Use consistent tags across logs for the same project

## Adding Photos

### Photo Location

Store build log photos in:
```
assets/images/builds/[project-name]/log-###-photo-name.jpg
```

Example:
```
assets/images/builds/ss-great-britain/log-001-reference-photos.jpg
assets/images/builds/ss-great-britain/log-002-hull-assembly.jpg
```

### In Markdown

```markdown
![Photo description]({{ 'assets/images/builds/project-name/log-###-photo.jpg' | relative_url }})
*Caption explaining the photo*
```

**Always use:**
- Descriptive alt text in `[]`
- The `relative_url` filter
- Captions in italics below image

## How builds.md Works

The `builds.md` page automatically lists all build logs using Liquid:

### Latest 10 Logs
Automatically shows newest 10 across all projects, sorted by date.

### By Project
Automatically groups logs by project folder, newest first within each project.

**You don't need to manually update builds.md!** Just create log files and they appear automatically.

## Publishing Workflow

1. Create/edit build log file
2. Add any photos to assets folder
3. Git add, commit, push:
   ```bash
   git add .
   git commit -m "Add SS Great Britain build log #002"
   git push
   ```
4. Wait 2-3 minutes for GitHub Actions to deploy
5. Check your live site!

## Tips for Writing Build Logs

### Be Consistent
- Follow the template structure
- Use similar sections across logs
- Maintain regular posting schedule

### Be Thorough
- Document problems, not just successes
- Include time estimates
- Note materials and sources
- Add plenty of photos

### Be Helpful
- Write like you're teaching someone
- Explain your reasoning
- Share mistakes and lessons
- Link to technique tutorials

### Be Regular
- Document as you build, not after
- Even small progress is worth logging
- Photos now, can't recreate later
- Keep build momentum visible

## Example Build Log Structure

A good build log has:

1. **Current Stage** - Where you are in the project
2. **Work Completed** - What you did this session
3. **Photos** - Visual documentation
4. **Techniques** - How you did it
5. **Challenges** - Problems and solutions
6. **Materials** - What you used
7. **Next Steps** - What's coming
8. **Time** - How long it took

Not every log needs every section, but aim for consistency.

## Need Help?

- Check `TEMPLATE-build-log.md` for structure
- Look at `ss-great-britain/001-planning-research.md` for example
- See `SITE-EDITING-GUIDE.md` for markdown help
- See `PUBLISHING-GUIDE.md` for git workflow

---

*Happy building and documenting!*
