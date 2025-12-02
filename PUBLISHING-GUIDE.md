# Quick Publishing Guide

## 🚀 Publish Your Changes (3 Simple Steps)

Every time you edit your website files, follow these steps to make them live:

### Step 1: Stage Your Changes
```powershell
git add .
```

### Step 2: Commit with a Description
```powershell
git commit -m "Describe what you changed"
```

### Step 3: Push to GitHub
```powershell
git push
```

**Or use the one-liner:**
```powershell
git add . && git commit -m "Update builds and about" && git push
```

---

## ⏱️ Wait 2-3 Minutes

GitHub Actions automatically builds and deploys your site.

**Check deployment status:**
- https://github.com/lcilliers/hobbies-modelling4comfort/actions
- Look for green checkmark ✅ = success
- Red X ❌ = error (check the logs)

**View your live site:**
- https://lcilliers.github.io/hobbies-modelling4comfort/

---

## 📝 Common Tasks

### Add/Edit a Project

1. **Edit existing project:**
   - Open `_projects/german-sail-boat.md` (or create new file)
   - Edit content, add images to gallery
   - Save file

2. **Optimize and add images:**
   ```powershell
   .\scripts\imagemagick-optimize.ps1 -SourceFolder "\\LSUK-SYNRACK\HomeMedia\hobbies\model building\[project-name]"
   ```

3. **Copy images to website:**
   ```powershell
   Copy-Item "source\web-optimized\*.jpg" -Destination "assets\images\projects\[project-name]\"
   ```

4. **Publish:**
   ```powershell
   git add . && git commit -m "Add [project-name] project" && git push
   ```

### Edit Home Page

1. Open `index.md`
2. Make your changes
3. Save and publish:
   ```powershell
   git add . && git commit -m "Update home page" && git push
   ```

### Edit Projects Gallery

1. Open `projects.md`
2. Make your changes
3. Save and publish:
   ```powershell
   git add . && git commit -m "Update projects gallery" && git push
   ```

---

## 🎨 Image Optimization

### Optimize Photos for Web

**Basic usage:**
```powershell
.\scripts\imagemagick-optimize.ps1 -SourceFolder "\\LSUK-SYNRACK\HomeMedia\hobbies\model building\German-sail-boat"
```

**Custom quality:**
```powershell
.\scripts\imagemagick-optimize.ps1 -SourceFolder "path\to\images" -MaxWidth 1920 -JpegQuality 90
```

**Green screen replacement:**
```powershell
.\scripts\imagemagick-optimize.ps1 -SourceFolder "path\to\images" -ReplaceGreenScreen -BackgroundImage "backgrounds\ocean.jpg" -GreenTolerance 15
```

**Output:** Creates `web-optimized` subfolder with optimized images

---

## 🔍 Check Status

### View what changed:
```powershell
git status
```

### View recent commits:
```powershell
git log --oneline -5
```

### View current branch:
```powershell
git branch
```

---

## ❌ Undo Changes

### Discard changes before committing:
```powershell
git restore filename.md
```

### Undo last commit (keep changes):
```powershell
git reset --soft HEAD~1
```

### Undo last commit (discard changes):
```powershell
git reset --hard HEAD~1
```

---

## 📂 File Locations

### Content Files
- **Home page:** `index.md`
- **Projects gallery:** `projects.md`
- **Individual projects:** `_projects/project-name.md`
- **Build logs:** `_builds/log-name.md`
- **Techniques:** `_techniques/technique-name.md`

### Images
- **Project images:** `assets/images/projects/project-name/`
- **Background images:** `backgrounds/`

### Configuration
- **Site settings:** `_config.yml`
- **Styles:** `assets/css/main.css`
- **Scripts:** `assets/js/main.js`

---

## 🆘 Troubleshooting

### Images not showing?
- Check paths start with `assets/images/...` (no leading slash)
- Use `{{ 'path' | relative_url }}` in Liquid templates
- Verify images are in correct folder

### Links not working?
- Use `{{ '/path/' | relative_url }}` for internal links
- Don't use absolute URLs like `/projects/`

### Build failing?
- Check GitHub Actions logs for errors
- Verify YAML front matter is valid (no tabs, proper indentation)
- Check for missing closing tags or brackets

### Need to refresh the site?
- Hard refresh: `Ctrl + Shift + R` (Windows) or `Cmd + Shift + R` (Mac)
- Clear browser cache if changes don't appear

---

## 📚 Quick Reference

### Git Commands
| Command | What it does |
|---------|--------------|
| `git status` | Show changed files |
| `git add .` | Stage all changes |
| `git commit -m "message"` | Save changes with description |
| `git push` | Upload to GitHub |
| `git pull` | Download latest from GitHub |
| `git log` | View commit history |

### Image Scripts
| Script | Purpose |
|--------|---------|
| `imagemagick-optimize.ps1` | Resize, compress, convert images (includes HEIC) |
| `optimize-images.ps1` | Basic optimization (Windows .NET, HEIC limited) |
| `copy-project-images.ps1` | Copy images from source to website structure |
| `download-background.ps1` | Download background images from URL |

---

## 🎯 Daily Workflow Example

**Scenario: Adding photos to German Sail Boat project**

1. **Optimize new photos:**
   ```powershell
   .\scripts\imagemagick-optimize.ps1 -SourceFolder "\\LSUK-SYNRACK\HomeMedia\hobbies\model building\German-sail-boat"
   ```

2. **Copy to website:**
   ```powershell
   Copy-Item "\\LSUK-SYNRACK\HomeMedia\hobbies\model building\German-sail-boat\web-optimized\*.jpg" -Destination "assets\images\projects\german-sail-boat\"
   ```

3. **Edit project file:**
   - Open `_projects\german-sail-boat.md`
   - Add new image paths to `gallery:` section
   - Update build progress

4. **Publish:**
   ```powershell
   git add . && git commit -m "Add new German sail boat photos" && git push
   ```

5. **Wait 2-3 minutes and check:**
   - https://lcilliers.github.io/hobbies-modelling4comfort/projects/german-sail-boat/

---

## ✅ That's It!

**Remember:** Every change you make becomes live after:
1. `git add .`
2. `git commit -m "description"`
3. `git push`
4. Wait 2-3 minutes

**Your site:** https://lcilliers.github.io/hobbies-modelling4comfort/
