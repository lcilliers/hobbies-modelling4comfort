# Source Narratives

This folder contains comprehensive source narratives for diorama projects. Source narratives document the complete creative journey from initial concept through final completion, following the [SOURCE-NARRATIVE-METHODOLOGY](../docs/methodology/SOURCE-NARRATIVE-METHODOLOGY.md).

## 📂 Current Narratives

### Active/In-Progress Projects

#### Traditional English Cottage
- **[traditional-english-cottage-SOURCE-NARRATIVE.md](traditional-english-cottage-SOURCE-NARRATIVE.md)** - Raw narrative with Architecture.txt content
- **[traditional-english-cottage-SOURCE-NARRATIVE-ORGANIZED.md](traditional-english-cottage-SOURCE-NARRATIVE-ORGANIZED.md)** - 6-chapter organized structure

**Status**: In-progress  
**Working Files**: See `../traditional-english-cottage/` for preparation files, inventory, and image plan

#### Log Cabin
- **[log-cabin-SOURCE-NARRATIVE.md](log-cabin-SOURCE-NARRATIVE.md)** - Current narrative
- **[log-cabin-SOURCE-NARRATIVE-ORGANIZED.md](log-cabin-SOURCE-NARRATIVE-ORGANIZED.md)** - Organized structure

**Status**: Active  
**Note**: Backups available in `../_archives/backups/`

### Completed Projects

#### Bamboo River Lookout
- **[bamboo-river-lookout-SOURCE-NARRATIVE.md](bamboo-river-lookout-SOURCE-NARRATIVE.md)**

#### Bookshop Memories
- **[bookshop-memories-SOURCE-NARRATIVE.md](bookshop-memories-SOURCE-NARRATIVE.md)**

#### Caravaning
- **[caravaning-SOURCE-NARRATIVE.md](caravaning-SOURCE-NARRATIVE.md)**

#### English Country Garden
- **[english-country-garden-SOURCE-NARRATIVE.md](english-country-garden-SOURCE-NARRATIVE.md)**

---

## 📝 About Source Narratives

Source narratives are comprehensive documentation that captures:

- **Creative Process**: Design decisions, inspiration sources, challenges encountered
- **Technical Details**: Construction methods, materials used, techniques applied
- **Timeline**: Project evolution from concept to completion
- **Lessons Learned**: What worked, what didn't, what would be done differently
- **Image Integration**: Strategic placement of 100+ photos throughout narrative

### Why Create Source Narratives?

1. **Memory Preservation**: Capture details that fade with time
2. **Knowledge Sharing**: Help others learn from your experience
3. **Portfolio Building**: Showcase depth of work beyond just photos
4. **Future Reference**: Revisit techniques and decisions for future projects
5. **Content Creation**: Foundation for website build logs and articles

---

## 🎯 Creating a New Source Narrative

Follow the [SOURCE-NARRATIVE-METHODOLOGY](../docs/methodology/SOURCE-NARRATIVE-METHODOLOGY.md) which provides:

- **Validation Framework**: Content provenance markers ([COMPLETE], [NEEDS MORE], [TODO], [AI-CHECK])
- **Structure Guidelines**: How to organize narrative by project phases
- **Image Integration**: Strategic image marker placement
- **Quality Standards**: Ensuring authenticity and completeness

### Quick Start Process:

1. **Gather Source Materials**
   - Project notes, sketches, research
   - Original photo files (all formats including HEIC)
   - Any written documentation from during build

2. **Create Structure**
   - Analyze source photo folders (see `scripts/plant-displays/analyze-source-structure.ps1` example)
   - Create chapter breakdown based on build phases
   - Map photos to narrative sections

3. **Write Narrative**
   - Start with raw narrative capturing all details
   - Mark sections with provenance tags
   - Create organized version with clear chapters
   - Add image markers throughout

4. **Prepare for Website**
   - Optimize photos (use `scripts/imagemagick-optimize.ps1`)
   - Create photo inventory CSV
   - Transform narrative into build log markdown files
   - Validate and publish

---

## 📂 Related Files

- **Methodology**: `../../docs/methodology/SOURCE-NARRATIVE-METHODOLOGY.md` - Complete process guide
- **Project Working Files**: `../[project-name]/` - Preparation files, inventories, image plans
- **Scripts**: `../../scripts/imagemagick-optimize.ps1` - Image optimization (CRITICAL for photo preparation)
- **Build Logs**: `../../_builds/` - Final published build logs derived from source narratives

---

## 🔍 File Naming Convention

Source narrative files follow this pattern:
```
[project-name]-SOURCE-NARRATIVE.md           # Raw narrative
[project-name]-SOURCE-NARRATIVE-ORGANIZED.md # Organized chapters
```

Where `[project-name]` uses:
- Lowercase letters
- Hyphens to separate words (not spaces or underscores)
- Descriptive project names

Examples:
- ✅ `traditional-english-cottage-SOURCE-NARRATIVE.md`
- ✅ `log-cabin-SOURCE-NARRATIVE.md`
- ✅ `bamboo-river-lookout-SOURCE-NARRATIVE.md`
- ❌ `Traditional_English_Cottage-source-narrative.md`

---

## 📋 Narrative Status Tracking

| Project | Raw Narrative | Organized | Status | Working Files |
|---------|--------------|-----------|--------|---------------|
| Traditional English Cottage | ✅ | ✅ | In-progress | `../traditional-english-cottage/` |
| Log Cabin | ✅ | ✅ | Active | - |
| Bamboo River Lookout | ✅ | - | Complete | - |
| Bookshop Memories | ✅ | - | Complete | - |
| Caravaning | ✅ | - | Complete | - |
| English Country Garden | ✅ | - | Complete | - |

---

**Last Updated**: 2026-01-01  
**Total Narratives**: 8 files (6 projects, 2 have organized versions)
