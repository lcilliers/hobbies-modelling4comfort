# Proposed Workspace Hierarchy
**Date:** 2026-01-01  
**Purpose:** Clear, concise, consistent organization without conflicts

---

## Design Principles

1. **Jekyll Compliance** - Preserve Jekyll/GitHub Pages required structure
2. **Clear Separation** - Documentation, scripts, working files, and site content clearly separated
3. **Underscore Convention** - Use `_folder` for Jekyll/system folders, no underscore for user content
4. **Flat Where Possible** - Avoid unnecessary nesting depth
5. **Intuitive Naming** - Folder names immediately convey purpose
6. **Archival Policy** - Clear rules for what goes in archives and when

---

## Proposed Hierarchy

```
\\ukwsdev07\e$\Models4Comfort\
│
├─── 📄 SITE CONTENT (Jekyll Pages - MUST stay in root)
│    ├── index.md
│    ├── about.md
│    ├── projects.md
│    ├── builds.md
│    ├── techniques.md
│    ├── feedback.md
│    └── credits-privacy.md
│
├─── ⚙️ JEKYLL CONFIG (MUST stay in root)
│    ├── _config.yml
│    ├── Gemfile
│    └── .gitignore
│
├─── 📂 JEKYLL FOLDERS (MUST stay in root, underscore convention)
│    ├── _includes/          # Jekyll partials
│    ├── _layouts/           # Jekyll layouts
│    ├── _projects/          # Project collection pages
│    ├── _techniques/        # Techniques collection pages
│    └── _builds/            # Build log collection
│         ├── README.md
│         ├── TEMPLATE-build-log.md
│         └── [project-folders]/
│
├─── 🎨 SITE RESOURCES (MUST stay in root for Jekyll)
│    ├── assets/
│    │    ├── images/
│    │    │    └── README.md
│    │    ├── css/
│    │    └── js/
│    ├── backgrounds/
│    │    └── README.md
│    └── scenary/
│
├─── 📚 DOCUMENTATION (NEW - Organized by purpose)
│    ├── README.md                    # MAIN workspace documentation (stay in root)
│    └── docs/
│         ├── README.md               # Documentation index
│         ├── guides/
│         │    ├── PUBLISHING-GUIDE.md
│         │    ├── SITE-EDITING-GUIDE.md
│         │    ├── IMAGEMAGICK-GUIDE.md
│         │    ├── IMAGE-LAYOUT-GUIDE.md
│         │    ├── FRONT-MATTER-GUIDE.md
│         │    ├── FEEDBACK-FORM-GUIDE.md
│         │    ├── COMMENTS-SETUP.md
│         │    └── GITHUB-PAGES-FIX.md
│         ├── methodology/
│         │    └── SOURCE-NARRATIVE-METHODOLOGY.md
│         └── reference/
│              ├── NAMING-CONVENTION-ANALYSIS.md
│              ├── IMAGE-NAMING-INCONSISTENCIES.md
│              ├── IMAGE-USAGE-ANALYSIS.md
│              └── CONFLICT-AUDIT-DAFFODIL.md
│
├─── 🔧 SCRIPTS (Organized by purpose)
│    └── scripts/
│         ├── README.md               # Script documentation
│         ├── imagemagick-optimize.ps1
│         ├── new-build-log.ps1
│         ├── copy-project-images.ps1
│         ├── combine-images-pairs.ps1
│         ├── download-background.ps1
│         ├── rename-project-images.ps1
│         └── plant-displays/
│              ├── README.md
│              ├── analyze-source-structure.ps1
│              ├── extract-markdown-image-refs.ps1
│              ├── hash-source-files.ps1
│              ├── hash-site-files.ps1
│              ├── build-site-source-hash-map.ps1
│              ├── generate-dry-run-FINAL.ps1
│              ├── validate-csv-completeness.ps1
│              ├── validate-site-files.ps1
│              ├── rename-site-files.ps1
│              ├── rename-files-by-plant.ps1
│              ├── rename-images.ps1
│              ├── rename-site-by-hash.ps1
│              ├── rename-site-by-sequence.ps1
│              ├── rename-site-correct.ps1
│              ├── rename-site-cross-ref.ps1
│              ├── rollback-site-renames.ps1
│              ├── update-markdown-by-plant.ps1
│              └── analyze-conflicts.ps1
│
├─── 📝 PROJECT WORKING FILES (NEW - Active project work)
│    │   **Note**: Implemented as `projects-working/` for clearer distinction from `_projects/`
│    │
│    ├── source-narratives/
│    │    ├── README.md
│    │    ├── bamboo-river-lookout-SOURCE-NARRATIVE.md
│    │    ├── bookshop-memories-SOURCE-NARRATIVE.md
│    │    ├── caravaning-SOURCE-NARRATIVE.md
│    │    ├── english-country-garden-SOURCE-NARRATIVE.md
│    │    ├── log-cabin-SOURCE-NARRATIVE.md
│    │    ├── log-cabin-SOURCE-NARRATIVE-ORGANIZED.md
│    │    ├── traditional-english-cottage-SOURCE-NARRATIVE.md
│    │    └── traditional-english-cottage-SOURCE-NARRATIVE-ORGANIZED.md
│    ├── projects/
│    │    ├── traditional-english-cottage/
│    │    │    ├── README.md
│    │    │    ├── SOURCE-STRUCTURE-ANALYSIS-TEC.md
│    │    │    ├── TEC-PREPARATION-SUMMARY.md
│    │    │    ├── TEC-PHOTO-INVENTORY.csv
│    │    │    └── traditional-english-cottage-IMAGE-PLAN.md
│    │    └── plant-displays/
│    │         ├── README.md (move PLANT-DISPLAYS-README.md here)
│    │         ├── SOURCE-STRUCTURE-ANALYSIS.csv
│    │         ├── SOURCE-STRUCTURE-ANALYSIS-BACKUP.csv
│    │         ├── MARKDOWN-IMAGE-REFERENCES.csv
│    │         ├── MARKDOWN-IMAGE-REFERENCES-BACKUP.csv
│    │         ├── MARKDOWN-UPDATES.csv
│    │         ├── RENAME-INVENTORY.csv
│    │         ├── SOURCE-FILE-HASHES.csv
│    │         └── SITE-FILE-HASHES.csv
│    └── working/
│         └── temp_photo_inventory.txt (if still needed, else delete)
│
├─── 📦 ARCHIVES (Consolidated - underscore convention)
│    └── _archives/
│         ├── README.md               # Archival policy documentation
│         ├── sessions/
│         │    ├── 2025-11-30-initial-setup.md
│         │    ├── 2025-12-01-new-pages.md
│         │    ├── 2025-12-02-build-log-implementation.md
│         │    ├── SESSION-LOG-2025-12-12-15.md
│         │    ├── SESSION-LOG-2025-12-29.md
│         │    └── SESSION-LOG-2025-12-29-FINAL.md
│         ├── audits/
│         │    ├── SCRIPT-AUDIT-2025-12-29.md (incomplete)
│         │    ├── SCRIPT-AUDIT-COMPLETE-2025-12-29.md (KEEP ACCESSIBLE)
│         │    ├── DOCUMENTATION-AUDIT.md
│         │    └── DOCUMENTATION-INVENTORY-COMPLETE.md (KEEP ACCESSIBLE)
│         ├── backups/
│         │    ├── log-cabin-SOURCE-NARRATIVE-BACKUP-20251215-070402.md
│         │    ├── log-cabin-BACKUP-20251215-101316.md
│         │    ├── log-cabin-clean.md
│         │    └── log-cabin-NEW.md
│         └── projects/
│              └── english-country-garden-OLD/
│                   ├── 001-planning-research.md
│                   ├── 002-base-construction.md
│                   ├── 003-cottage-building.md
│                   └── 004-scenery-planting.md
│
├─── 🗑️ DEPRECATED (Underscore convention)
│    └── _deprecated/
│         ├── README.md               # List of deprecated items with reasons
│         ├── optimize-images.ps1
│         ├── PROJECT-README.md
│         ├── generate-dry-run-csvs.ps1
│         ├── generate-dry-run-csvs-v2.ps1
│         ├── generate-markdown-updates.ps1
│         └── generate-markdown-updates-v2.ps1
│
└─── 🧪 EXPERIMENTAL (Framework alternatives - keep for reference)
     ├── eleventy/
     │    └── README.md
     ├── hugo/
     │    ├── README.md
     │    └── archetypes/
     └── simple-html/
          └── README.md
```

---

## Key Changes from Current Structure

### ✅ Improvements

1. **Documentation Organization**
   - All guides in `docs/guides/`
   - Methodology in `docs/methodology/`
   - Reference materials in `docs/reference/`
   - Main `README.md` stays in root for GitHub

2. **Scripts Organization**
   - All scripts in `scripts/` folder
   - Plant-displays scripts in subfolder
   - Clear README documentation

3. **Project Working Files**
   - Source narratives grouped in `source-narratives/`
   - Active project files in `projects/[project-name]/`
   - CSVs with their related projects

4. **Consolidated Archives**
   - Single `_archives/` folder (underscore convention)
   - Organized by type: sessions, audits, backups, projects
   - Old `archives/` folder merged in

5. **Deprecated Scripts**
   - Obsolete script versions moved to `_deprecated/`
   - Clear deprecation documentation

### ⚠️ No Changes (Jekyll Requirements)

These MUST stay in root:
- All `.md` site pages (index, about, projects, builds, techniques, feedback, credits-privacy)
- `_config.yml`, `Gemfile`
- `_includes/`, `_layouts/`, `_projects/`, `_techniques/`, `_builds/`
- `assets/`, `backgrounds/`, `scenary/`

---

## Comparison: Current vs Proposed

### Root Directory Files

| Current Location | Proposed Location | Reason |
|-----------------|-------------------|---------|
| **KEEP IN ROOT** | | |
| index.md | ROOT (no change) | Jekyll requirement |
| about.md | ROOT (no change) | Jekyll requirement |
| projects.md | ROOT (no change) | Jekyll requirement |
| builds.md | ROOT (no change) | Jekyll requirement |
| techniques.md | ROOT (no change) | Jekyll requirement |
| feedback.md | ROOT (no change) | Jekyll requirement |
| credits-privacy.md | ROOT (no change) | Jekyll requirement |
| _config.yml | ROOT (no change) | Jekyll requirement |
| Gemfile | ROOT (no change) | Jekyll requirement |
| README.md | ROOT (no change) | GitHub/workspace main doc |
| **MOVE TO docs/** | | |
| PUBLISHING-GUIDE.md | docs/guides/ | Documentation organization |
| SITE-EDITING-GUIDE.md | docs/guides/ | Documentation organization |
| IMAGEMAGICK-GUIDE.md | docs/guides/ | Documentation organization |
| IMAGE-LAYOUT-GUIDE.md | docs/guides/ | Documentation organization |
| FRONT-MATTER-GUIDE.md | docs/guides/ | Documentation organization |
| FEEDBACK-FORM-GUIDE.md | docs/guides/ | Documentation organization |
| COMMENTS-SETUP.md | docs/guides/ | Documentation organization |
| GITHUB-PAGES-FIX.md | docs/guides/ | Documentation organization |
| SOURCE-NARRATIVE-METHODOLOGY.md | docs/methodology/ | Methodology documentation |
| NAMING-CONVENTION-ANALYSIS.md | docs/reference/ | Reference material |
| IMAGE-NAMING-INCONSISTENCIES.md | docs/reference/ | Reference material |
| IMAGE-USAGE-ANALYSIS.md | docs/reference/ | Reference material |
| CONFLICT-AUDIT-DAFFODIL.md | docs/reference/ | Historical troubleshooting |
| **MOVE TO source-narratives/** | | |
| bamboo-river-lookout-SOURCE-NARRATIVE.md | source-narratives/ | Group all source narratives |
| bookshop-memories-SOURCE-NARRATIVE.md | source-narratives/ | Group all source narratives |
| caravaning-SOURCE-NARRATIVE.md | source-narratives/ | Group all source narratives |
| english-country-garden-SOURCE-NARRATIVE.md | source-narratives/ | Group all source narratives |
| log-cabin-SOURCE-NARRATIVE.md | source-narratives/ | Group all source narratives |
| log-cabin-SOURCE-NARRATIVE-ORGANIZED.md | source-narratives/ | Group all source narratives |
| traditional-english-cottage-SOURCE-NARRATIVE.md | source-narratives/ | Group all source narratives |
| traditional-english-cottage-SOURCE-NARRATIVE-ORGANIZED.md | source-narratives/ | Group all source narratives |
| **MOVE TO projects/** | | |
| SOURCE-STRUCTURE-ANALYSIS-TEC.md | projects/traditional-english-cottage/ | TEC project files |
| TEC-PREPARATION-SUMMARY.md | projects/traditional-english-cottage/ | TEC project files |
| TEC-PHOTO-INVENTORY.csv | projects/traditional-english-cottage/ | TEC project files |
| traditional-english-cottage-IMAGE-PLAN.md | projects/traditional-english-cottage/ | TEC project files |
| PLANT-DISPLAYS-README.md | projects/plant-displays/README.md | Rename and relocate |
| SOURCE-STRUCTURE-ANALYSIS.csv | projects/plant-displays/ | Plant displays working files |
| SOURCE-STRUCTURE-ANALYSIS-BACKUP.csv | projects/plant-displays/ | Plant displays working files |
| MARKDOWN-IMAGE-REFERENCES.csv | projects/plant-displays/ | Plant displays working files |
| MARKDOWN-IMAGE-REFERENCES-BACKUP.csv | projects/plant-displays/ | Plant displays working files |
| MARKDOWN-UPDATES.csv | projects/plant-displays/ | Plant displays working files |
| RENAME-INVENTORY.csv | projects/plant-displays/ | Plant displays working files |
| SOURCE-FILE-HASHES.csv | projects/plant-displays/ | Plant displays working files |
| SITE-FILE-HASHES.csv | projects/plant-displays/ | Plant displays working files |
| **MOVE TO _archives/** | | |
| SESSION-LOG-2025-12-12-15.md | _archives/sessions/ | Historical session log |
| SESSION-LOG-2025-12-29.md | _archives/sessions/ | Historical session log |
| SESSION-LOG-2025-12-29-FINAL.md | _archives/sessions/ | Historical session log |
| SCRIPT-AUDIT-2025-12-29.md | _archives/audits/ | Obsolete audit (incomplete) |
| DOCUMENTATION-AUDIT.md | _archives/audits/ | Previous audit |
| log-cabin-SOURCE-NARRATIVE-BACKUP-20251215-070402.md | _archives/backups/ | Dated backup file |
| **KEEP ACCESSIBLE BUT ARCHIVE** | | |
| SCRIPT-AUDIT-COMPLETE-2025-12-29.md | _archives/audits/ | Keep for reference |
| DOCUMENTATION-INVENTORY-COMPLETE.md | _archives/audits/ | Keep for reference |
| **MOVE TO _deprecated/** | | |
| generate-dry-run-csvs.ps1 | _deprecated/ | Obsolete v1 |
| generate-dry-run-csvs-v2.ps1 | _deprecated/ | Obsolete v2 |
| generate-markdown-updates.ps1 | _deprecated/ | Obsolete v1 |
| generate-markdown-updates-v2.ps1 | _deprecated/ | Obsolete v2 |
| **REVIEW AND DELETE** | | |
| temp_photo_inventory.txt | DELETE or working/ | Temporary file |
| 120 | DELETE | Unknown purpose |
| 5 | DELETE | Unknown purpose |

### Root Directory Scripts

| Current Location | Proposed Location | Reason |
|-----------------|-------------------|---------|
| analyze-conflicts.ps1 | scripts/plant-displays/ | Plant displays troubleshooting |
| analyze-source-structure.ps1 | scripts/plant-displays/ | Plant displays workflow |
| build-site-source-hash-map.ps1 | scripts/plant-displays/ | Plant displays workflow |
| extract-markdown-image-refs.ps1 | scripts/plant-displays/ | Plant displays workflow |
| hash-site-files.ps1 | scripts/plant-displays/ | Plant displays workflow |
| hash-source-files.ps1 | scripts/plant-displays/ | Plant displays workflow |
| generate-dry-run-FINAL.ps1 | scripts/plant-displays/ | Plant displays workflow |
| validate-csv-completeness.ps1 | scripts/plant-displays/ | Plant displays workflow |
| validate-site-files.ps1 | scripts/plant-displays/ | Plant displays workflow |
| rename-site-files.ps1 | scripts/plant-displays/ | Plant displays workflow |
| rename-files-by-plant.ps1 | scripts/plant-displays/ | Plant displays workflow |
| rename-images.ps1 | scripts/plant-displays/ | Plant displays workflow |
| rename-site-by-hash.ps1 | scripts/plant-displays/ | Plant displays workflow |
| rename-site-by-sequence.ps1 | scripts/plant-displays/ | Plant displays workflow |
| rename-site-correct.ps1 | scripts/plant-displays/ | Plant displays workflow |
| rename-site-cross-ref.ps1 | scripts/plant-displays/ | Plant displays workflow |
| rollback-site-renames.ps1 | scripts/plant-displays/ | Plant displays workflow |
| update-markdown-by-plant.ps1 | scripts/plant-displays/ | Plant displays workflow |

### Archives Consolidation

| Current Location | Proposed Location | Action |
|-----------------|-------------------|---------|
| archives/english-country-garden-OLD/ | _archives/projects/english-country-garden-OLD/ | Move and merge |
| _archives/* (existing) | _archives/* | Keep, organize by type |

---

## Conflicts Requiring User Decisions

### 🔴 Conflict 1: Active Audit Documents Location

**Issue:** Recent audit documents are valuable reference but clutter root

**Current Files:**
- SCRIPT-AUDIT-COMPLETE-2025-12-29.md (current, valuable)
- DOCUMENTATION-INVENTORY-COMPLETE.md (current, valuable)

**Options:**

**A) Keep in Root**
- Pros: Easy access, highly visible
- Cons: Root clutter continues
- Recommendation: NOT IDEAL

**B) Move to docs/audits/**
- Pros: Organized with other docs, easy to find
- Cons: Creates new top-level docs/ structure
- Recommendation: ⭐ RECOMMENDED

**C) Move to _archives/audits/ but keep accessible**
- Pros: Archived but not forgotten
- Cons: "Archives" implies obsolete
- Recommendation: ACCEPTABLE

**Decision needed:** Where should current audit documents live?

---

### 🔴 Conflict 2: Source Narratives Organization

**Issue:** 10 source narrative files - some complete, some in-progress

**Current Files:**
- bamboo-river-lookout-SOURCE-NARRATIVE.md (complete)
- bookshop-memories-SOURCE-NARRATIVE.md (complete)
- caravaning-SOURCE-NARRATIVE.md (complete)
- english-country-garden-SOURCE-NARRATIVE.md (complete)
- log-cabin-SOURCE-NARRATIVE.md (in-progress?)
- log-cabin-SOURCE-NARRATIVE-ORGANIZED.md (in-progress?)
- traditional-english-cottage-SOURCE-NARRATIVE.md (in-progress)
- traditional-english-cottage-SOURCE-NARRATIVE-ORGANIZED.md (in-progress)

**Options:**

**A) All in source-narratives/ folder**
- Pros: Simple, all together
- Cons: Mix of complete and in-progress
- Recommendation: ⭐ RECOMMENDED if you refer to them regularly

**B) Split by status**
- Complete → _archives/source-narratives/
- In-progress → source-narratives/
- Pros: Clear status
- Cons: Need to move as projects complete
- Recommendation: ACCEPTABLE

**C) Move all to _archives/ (if reference-only)**
- Pros: Clean root
- Cons: Assumes narratives are "done"
- Recommendation: Only if not actively used

**Decision needed:** How to organize source narratives? Are they active working documents or historical records?

---

### 🔴 Conflict 3: Archives Folder Naming

**Issue:** Two archive folders exist: `_archives/` and `archives/`

**Current State:**
- `_archives/` has 7 files (sessions, backups)
- `archives/` has 4 old english-country-garden files

**Options:**

**A) Use `_archives/` (underscore convention)**
- Pros: Consistent with `_builds/`, `_deprecated/`, `_projects/`
- Cons: Need to move archives/ content
- Recommendation: ⭐ RECOMMENDED for consistency

**B) Use `archives/` (no underscore)**
- Pros: Already has content, standard name
- Cons: Breaks underscore convention for system folders
- Recommendation: NOT RECOMMENDED

**C) Keep both**
- Pros: No migration needed
- Cons: Confusing, inconsistent
- Recommendation: ❌ NOT RECOMMENDED

**Decision needed:** Which folder name? (Recommend: `_archives/`)

---

### 🔴 Conflict 4: Plant Displays Project Status

**Issue:** 18 plant-displays scripts + 9 CSVs - is this project complete or ongoing?

**If Complete:**
- Move scripts → scripts/plant-displays/ (organized but indicates "specialized tool")
- Move CSVs → projects/plant-displays/ or _archives/projects/plant-displays/
- Keep README as reference

**If Ongoing:**
- Move scripts → scripts/plant-displays/
- Move CSVs → projects/plant-displays/
- Keep active for future use

**If One-Off (Never Use Again):**
- Move everything → _archives/projects/plant-displays/
- Document as historical project-specific workflow

**Decision needed:** What is the status and future of plant-displays project files?

---

### ⚠️ Conflict 5: Working Files Organization

**Issue:** Where do temporary/working CSVs go during active work?

**Current State:**
- 9 CSVs in root (plant-displays)
- 1 CSV in root (TEC project)
- temp_photo_inventory.txt

**Options:**

**A) projects/[project-name]/ approach**
- Working files live with project
- Pros: Clear project context
- Cons: Need folder per project
- Recommendation: ⭐ RECOMMENDED for multi-file projects

**B) working/ folder in root**
- Temp files go here
- Pros: Clear "in progress" location
- Cons: Files separated from project context
- Recommendation: ACCEPTABLE for single-file temps

**C) Leave in root during active work**
- Move to project folder when complete
- Pros: Easy access
- Cons: Root clutter
- Recommendation: ❌ NOT RECOMMENDED

**Decision needed:** Where do working CSVs live during active projects?

---

### ⚠️ Conflict 6: Experimental Framework Folders

**Issue:** `eleventy/`, `hugo/`, `simple-html/` folders - keep or remove?

**Current State:**
- Each has README
- Not actively used (Jekyll is primary)
- May be future alternatives

**Options:**

**A) Keep in root**
- Pros: Easy access if revisiting
- Cons: Root clutter
- Recommendation: NOT IDEAL

**B) Move to experiments/ or alternatives/**
- Pros: Grouped, out of main workspace
- Cons: New folder
- Recommendation: ⭐ RECOMMENDED if keeping

**C) Delete**
- Pros: Clean workspace
- Cons: Lose reference if needed later
- Recommendation: ACCEPTABLE if not planning to use

**Decision needed:** Keep experimental frameworks? If yes, where?

---

## Migration Action Plan

### Phase 1: Immediate Cleanup (No conflicts)

```powershell
# 1. Create new folder structure
New-Item -ItemType Directory -Path "docs/guides"
New-Item -ItemType Directory -Path "docs/methodology"
New-Item -ItemType Directory -Path "docs/reference"
New-Item -ItemType Directory -Path "source-narratives"
New-Item -ItemType Directory -Path "projects/traditional-english-cottage"
New-Item -ItemType Directory -Path "projects/plant-displays"
New-Item -ItemType Directory -Path "scripts/plant-displays"
New-Item -ItemType Directory -Path "_archives/sessions"
New-Item -ItemType Directory -Path "_archives/audits"
New-Item -ItemType Directory -Path "_archives/backups"
New-Item -ItemType Directory -Path "_archives/projects"

# 2. Move deprecated scripts (clear)
Move-Item generate-dry-run-csvs.ps1 _deprecated/
Move-Item generate-dry-run-csvs-v2.ps1 _deprecated/
Move-Item generate-markdown-updates.ps1 _deprecated/
Move-Item generate-markdown-updates-v2.ps1 _deprecated/

# 3. Move guides (clear)
Move-Item PUBLISHING-GUIDE.md docs/guides/
Move-Item SITE-EDITING-GUIDE.md docs/guides/
Move-Item IMAGEMAGICK-GUIDE.md docs/guides/
Move-Item IMAGE-LAYOUT-GUIDE.md docs/guides/
Move-Item FRONT-MATTER-GUIDE.md docs/guides/
Move-Item FEEDBACK-FORM-GUIDE.md docs/guides/
Move-Item COMMENTS-SETUP.md docs/guides/
Move-Item GITHUB-PAGES-FIX.md docs/guides/

# 4. Move methodology (clear)
Move-Item SOURCE-NARRATIVE-METHODOLOGY.md docs/methodology/

# 5. Move reference materials (clear)
Move-Item NAMING-CONVENTION-ANALYSIS.md docs/reference/
Move-Item IMAGE-NAMING-INCONSISTENCIES.md docs/reference/
Move-Item IMAGE-USAGE-ANALYSIS.md docs/reference/
Move-Item CONFLICT-AUDIT-DAFFODIL.md docs/reference/

# 6. Move session logs (clear)
Move-Item SESSION-LOG-2025-12-12-15.md _archives/sessions/
Move-Item SESSION-LOG-2025-12-29.md _archives/sessions/
Move-Item SESSION-LOG-2025-12-29-FINAL.md _archives/sessions/

# 7. Move backups (clear)
Move-Item log-cabin-SOURCE-NARRATIVE-BACKUP-20251215-070402.md _archives/backups/

# 8. Move obsolete audit (clear)
Move-Item SCRIPT-AUDIT-2025-12-29.md _archives/audits/
```

### Phase 2: Requires User Decisions

**After Decision 1 (Audit docs):**
```powershell
# If docs/audits/
Move-Item SCRIPT-AUDIT-COMPLETE-2025-12-29.md docs/audits/
Move-Item DOCUMENTATION-INVENTORY-COMPLETE.md docs/audits/

# OR if _archives/audits/
Move-Item SCRIPT-AUDIT-COMPLETE-2025-12-29.md _archives/audits/
Move-Item DOCUMENTATION-INVENTORY-COMPLETE.md _archives/audits/
```

**After Decision 2 (Source narratives):**
```powershell
# If all to source-narratives/
Move-Item *-SOURCE-NARRATIVE*.md source-narratives/
```

**After Decision 3 (Archives consolidation):**
```powershell
# Move archives/ content to _archives/
Move-Item archives/english-country-garden-OLD _archives/projects/
Remove-Item archives/  # After empty
```

**After Decision 4 (Plant displays status):**
```powershell
# Move plant-displays scripts
Move-Item analyze-source-structure.ps1 scripts/plant-displays/
Move-Item extract-markdown-image-refs.ps1 scripts/plant-displays/
# ... (all 18 scripts)

# Move plant-displays CSVs to project folder
Move-Item SOURCE-STRUCTURE-ANALYSIS.csv projects/plant-displays/
Move-Item MARKDOWN-IMAGE-REFERENCES.csv projects/plant-displays/
# ... (all 9 CSVs)

# Rename and move README
Move-Item PLANT-DISPLAYS-README.md projects/plant-displays/README.md
```

**After Decision 5 (TEC project files):**
```powershell
# Move TEC files to project folder
Move-Item SOURCE-STRUCTURE-ANALYSIS-TEC.md projects/traditional-english-cottage/
Move-Item TEC-PREPARATION-SUMMARY.md projects/traditional-english-cottage/
Move-Item TEC-PHOTO-INVENTORY.csv projects/traditional-english-cottage/
Move-Item traditional-english-cottage-IMAGE-PLAN.md projects/traditional-english-cottage/
```

---

## Expected Final State

### Root Directory Contents (Clean!)

```
\\ukwsdev07\e$\Models4Comfort\
├── index.md                    # Site pages (7 files)
├── about.md
├── projects.md
├── builds.md
├── techniques.md
├── feedback.md
├── credits-privacy.md
├── _config.yml                 # Jekyll config
├── Gemfile
├── README.md                   # Main workspace doc
├── docs/                       # NEW - Documentation hub
├── source-narratives/          # NEW - Source narratives (if keeping)
├── projects/                   # NEW - Active project working files
├── scripts/                    # Scripts (all moved here)
├── _builds/                    # Jekyll folder
├── _projects/                  # Jekyll folder
├── _techniques/                # Jekyll folder
├── _includes/                  # Jekyll folder
├── _layouts/                   # Jekyll folder
├── _archives/                  # Consolidated archives
├── _deprecated/                # Deprecated items
├── assets/                     # Site resources
├── backgrounds/                # Site resources
├── scenary/                    # Site resources
├── eleventy/                   # (or move/delete per decision)
├── hugo/                       # (or move/delete per decision)
└── simple-html/                # (or move/delete per decision)
```

**Root directory would go from 41+ documentation files to 7 site pages + 1 README = MUCH CLEANER**

---

## Summary of Required Decisions

| # | Decision | Options | Recommendation | Impact |
|---|----------|---------|----------------|---------|
| 1 | Current audit docs location | Root / docs/audits / _archives/audits | docs/audits/ | 2 files |
| 2 | Source narratives organization | source-narratives/ / split / archive | source-narratives/ | 10 files |
| 3 | Archives folder naming | _archives/ / archives/ / both | _archives/ | Consolidation |
| 4 | Plant displays status | Active / Complete / Archive | Active (projects/) | 18+9 files |
| 5 | Working files location | projects/ / working/ / root | projects/[name]/ | CSVs |
| 6 | Experimental frameworks | Keep / Move / Delete | Move or delete | 3 folders |

---

## Benefits of Proposed Hierarchy

1. **Root Clarity** - Only 7 site pages + 1 README + config files + Jekyll folders
2. **Clear Separation** - Docs, scripts, projects, archives clearly divided
3. **Consistent Naming** - `_folder` for system, no underscore for content
4. **Intuitive Navigation** - Folder names immediately convey purpose
5. **Scalable** - Easy to add new projects to projects/ folder
6. **Maintainable** - Clear rules for where files go
7. **Jekyll Compliant** - All Jekyll requirements preserved
8. **No Conflicts** - After decisions, every file has clear home

---

**Ready to implement after 6 user decisions confirmed.**
