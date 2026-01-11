# Modelling4Comfort - Diorama Modeling Website 🎨

A comprehensive website for showcasing diorama modeling projects, build logs, and techniques.

---

## 🛑 MANDATORY: Read Before ANY Task

**FOR AI ASSISTANTS & COLLABORATORS:**

**DO NOT perform any task without first reading the complete workflow documentation.**

### Before Image Optimization or Processing:

**REQUIRED READING (in order):**
1. **`scripts/README.md`** - Complete workflow sections (Steps 1-5)
2. **`docs/guides/IMAGEMAGICK-GUIDE.md`** - Tool usage and parameters
3. **`assets/images/README.md`** - Naming convention rules

**Complete workflow includes:**
- ✅ Step 1: Optimize with imagemagick-optimize.ps1
- ✅ Step 2: Rename to 3-part convention `[prefix]-[category]-[###].jpg`
- ✅ Step 3: Review optimized & renamed images
- ✅ Step 4: Copy to website assets
- ✅ Step 5: Create/update markdown files

**DO NOT:**
- ❌ Skip the renaming step
- ❌ Assume you know the workflow from memory
- ❌ Proceed without reading all three documents above
- ❌ Use partial or incomplete workflows

### Before Creating Content:

**REQUIRED READING:**
1. **`docs/guides/SITE-EDITING-GUIDE.md`** - Content structure and front matter
2. **`docs/methodology/SOURCE-NARRATIVE-METHODOLOGY.md`** - Documentation standards (if creating project docs)

### Before Using Scripts:

**REQUIRED READING:**
1. **`scripts/README.md`** - Full script documentation and examples
2. Specific script section for the tool you're using

### Verification Checklist:

Before starting ANY task, confirm:
- [ ] I have read the complete workflow documentation
- [ ] I understand all steps required
- [ ] I will execute ALL steps in order
- [ ] I will not skip steps or improvise
- [ ] **I will provide feedback listing all documentation files I have read** (with file paths)

**This prevents incomplete workflows and ensures quality standards.**

---

## ⚠️ CRITICAL: Image Naming Convention

**Before adding images, READ THIS:**

The site has **inconsistent image naming** (only 57.6% compliance). Do NOT copy existing patterns without verification.

**Required Reading:**
- **`assets/images/README.md`** - Mandatory 3-part naming standard
- **`docs/reference/IMAGE-NAMING-INCONSISTENCIES.md`** - Full analysis of existing issues

**Standard (ALWAYS use for new images):**
```
Format: [prefix]-[category]-[###].jpg
✅ sr-pln-001.jpg (sea-rescue planning)
✅ log-cabin-gallery-001.jpg
❌ bamboo-river-lookout-figures-001.jpg (wrong: too long)
```

---

## 🚀 Quick Start

This repository uses **Jekyll** for static site generation - works out-of-the-box with GitHub Pages.

See `docs/guides/SITE-EDITING-GUIDE.md` for complete editing documentation.

## 📂 Workspace Organization

```
Models4Comfort/
├── 📄 Site Pages (Jekyll)     # index.md, about.md, projects.md, etc.
├── 📚 docs/                   # All documentation
│   ├── guides/               # How-to guides (8 guides)
│   ├── methodology/          # Development methodologies
│   └── reference/            # Reference materials & analysis
├── 📝 projects-working/      # Active project working files
│   ├── source-narratives/    # Project source narratives
│   ├── traditional-english-cottage/
│   ├── plant-displays/
│   └── working/              # Temporary files
├── 🔧 scripts/                # Automation scripts
│   └── plant-displays/       # Project-specific scripts
├── 📦 _archives/              # Historical records
│   ├── sessions/             # Past session logs
│   ├── audits/               # Historical audits
│   ├── backups/              # File backups
│   └── projects/             # Archived projects
├── 🗑️ _deprecated/            # Deprecated scripts/files
└── 🎨 Site Resources          # assets/, backgrounds/, _builds/, _projects/, etc.
```

## 📚 Documentation Guide

**📖 Primary Guides** (in `docs/guides/`):
- **`SITE-EDITING-GUIDE.md`** - Complete content editing guide
- **`PUBLISHING-GUIDE.md`** - Git workflow and publishing
- **`IMAGEMAGICK-GUIDE.md`** - ⭐ Image processing & optimization (REQUIRED for image work)
- **`IMAGE-LAYOUT-GUIDE.md`** - Image layout options
- **`FRONT-MATTER-GUIDE.md`** - YAML front matter explained
- **`FEEDBACK-FORM-GUIDE.md`** - Feedback form setup
- **`COMMENTS-SETUP.md`** - Setting up GitHub-based comments
- **`GITHUB-PAGES-FIX.md`** - Troubleshooting GitHub Pages

**📐 Methodology** (in `docs/methodology/`):
- **`SOURCE-NARRATIVE-METHODOLOGY.md`** - Creating comprehensive project documentation

**📊 Reference Materials** (in `docs/reference/`):
- **`IMAGE-NAMING-INCONSISTENCIES.md`** - Analysis of naming issues to fix
- **`NAMING-CONVENTION-ANALYSIS.md`** - Naming convention analysis
- **`IMAGE-USAGE-ANALYSIS.md`** - Image usage patterns
- **`CONFLICT-AUDIT-DAFFODIL.md`** - Historical troubleshooting

**🔧 Scripts & Tools**:
- **`scripts/README.md`** - ⭐ Script usage (CRITICAL: Use imagemagick-optimize.ps1 for all image optimization)
- **`scripts/plant-displays/`** - Plant displays project scripts (18 specialized scripts)

**📝 Project Documentation**:
- **`projects-working/source-narratives/README.md`** - Source narrative creation guide
- **`projects-working/plant-displays/README.md`** - Plant Displays Series management
- **`projects-working/traditional-english-cottage/`** - TEC project working files

**🏗️ Site Structure**:
- **`_builds/README.md`** - Build log creation
- **`assets/images/README.md`** - Image organization
- **`.github/workflows/README.md`** - Deployment instructions

**📦 Archives**:
- **`_archives/`** - Historical session logs, audits, and backups

## 🌐 Live Site

Once deployed: https://lcilliers.github.io/hobbies-modelling4comfort/

## 💡 Getting Started

1. Choose your static site generator (Jekyll recommended)
2. Follow the setup instructions in `SITE-EDITING-GUIDE.md`
3. Enable GitHub Pages (Settings → Pages → GitHub Actions)
4. Push your changes and watch it deploy!

## 📝 Sample Content Included

- Sample diorama project
- Example build log
- Winter weathering technique tutorial

Start editing or create your own content!

---

Built with ❤️ for the scale modeling community.