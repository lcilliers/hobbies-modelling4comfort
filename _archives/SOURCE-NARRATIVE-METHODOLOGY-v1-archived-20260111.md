# Source-Narrative Methodology Guide
## Creating Comprehensive Project Pages with Integrated Storytelling

### Overview

The Source-Narrative methodology is an approach to documenting modeling projects that combines comprehensive narrative storytelling with strategic image placement. Instead of fragmented build log entries, this creates a single, cohesive project page that tells the complete story from concept to completion.

**Key Principle**: Write the story first, then integrate images where they naturally enhance the narrative.

**Critical Requirement**: All content must be validated to ensure authenticity and accuracy.

---

## Content Validation Framework

### Classification System

All content should be classified using the three-tier validation system:

#### 1. ✅ ALL CONTENT VALIDATED
**Definition**: All information verified from actual project files, data, or personal documentation.

**Characteristics:**
- Project specifications (scale, dates, dimensions) verified against actual work
- Build narrative reflects authentic personal experience and memories
- Image paths verified to exist in asset folders
- Technical details match actual techniques used
- Timeline matches actual build progression
- No assumed or placeholder content

**Example**: log-cabin project page and all 4 build logs - 130-140 hours documented with real photos, authentic challenges, verified timeline.

#### 2. ⚠️ PARTIALLY VALIDATED
**Definition**: Mix of verified data and unverified/placeholder content.

**Characteristics:**
- Some sections fully validated, others need review
- May contain AI-organized content requiring human verification
- Placeholder sections present but clearly marked
- Template boilerplate mixed with actual content

**Use when:**
- Project page completed but some sections need expansion
- AI has organized content but human hasn't verified all sections
- Transitioning from template to actual content

**Required action**: Mark unvalidated sections with `[AI-CHECK]` or `[NEEDS MORE]`

#### 3. ❌ NOT VALIDATED
**Definition**: Template, placeholder, or AI-generated content not yet verified by human.

**Characteristics:**
- Template boilerplate not yet replaced with actual content
- AI-generated content awaiting human review
- Assumed content not verified against actual data
- Future/planning content not based on completed work
- Generic descriptions not specific to actual project

**Use when:**
- Creating initial project structure
- Planning future projects
- AI has generated draft content for review

**Required action**: Set `published: false` or clearly mark as draft/template

### Human Review Workflow

**Critical Principle**: All AI-generated or AI-organized content MUST go through human validation before publication.

#### Workflow Steps:

1. **Human Authors Source Material**
   - Write raw narrative in plain language
   - This is the SOURCE OF TRUTH
   - Include all remembered details, dates, dimensions, challenges
   - Mark sections with validation status

2. **AI Reads and Questions**
   - AI reads narrative and identifies gaps
   - AI asks clarifying questions
   - AI notes areas needing more detail

3. **Human Expands Content**
   - Human adds more details based on AI prompts
   - Human clarifies ambiguities
   - Human provides missing information

4. **AI Structures Content**
   - AI organizes into proper markdown format
   - AI adds chapter structure and transitions
   - AI marks all AI-generated additions with `[AI-CHECK]`

5. **Human Reviews and Approves** ← CRITICAL VALIDATION STEP
   - Human reviews ALL content, especially `[AI-CHECK]` sections
   - Human verifies AI didn't misinterpret or assume anything
   - Human validates all technical details, dates, dimensions
   - Human approves or requests revisions

6. **AI Applies Approved Content**
   - AI creates final project page with validated content only
   - AI removes validation markers from approved sections
   - AI deploys to website

### Validation Markers

Use these markers in source files to track validation status:

**`[AI-CHECK]`** - AI added this content
```markdown
[AI-CHECK] The cabin structure took approximately 40-45 hours to complete.
```
*Use when*: AI inferred information, added transitions, or structured content
*Action needed*: Human must verify accuracy before publication

**`[COMPLETE]`** - Human has validated this section
```markdown
[COMPLETE]
I started the log cabin project on January 20, 2024, inspired by 
Cathy's flower house kit which taught me miniature plant making.
```
*Use when*: Content is 100% verified and accurate
*Action needed*: None - ready for publication

**`[NEEDS MORE]`** - Content exists but needs expansion
```markdown
[NEEDS MORE]
I built the chimney from small stones, but need to add details 
about the mortar mixture and assembly technique.
```
*Use when*: Basic content present but lacks sufficient detail
*Action needed*: Human adds more information

**`[TODO]`** - Section not yet written
```markdown
[TODO] Add section about weathering techniques used on cabin exterior
```
*Use when*: Placeholder for future content
*Action needed*: Human writes this section

### Content Provenance Tracking

Every source file should include a provenance header:

```markdown
<!--
═══════════════════════════════════════════════════════════════
PROJECT NAME - SOURCE NARRATIVE
═══════════════════════════════════════════════════════════════

PURPOSE: This file contains YOUR raw narrative about the project
in your own words. This is the SOURCE OF TRUTH.

CONTENT PROVENANCE:
All content below is YOUR authentic experience and memories.
Created: YYYY-MM-DD
Last Updated: YYYY-MM-DD
Validation Status: [COMPLETE / NEEDS MORE / TODO]

═══════════════════════════════════════════════════════════════
-->
```

**Why This Matters:**
- Distinguishes human-authored from AI-organized content
- Tracks when content was created/updated
- Provides validation status at a glance
- Ensures authenticity of published content

### Validation Checklist

Before publishing any project page, verify:

**Technical Accuracy:**
- [ ] Scale verified (matches actual project)
- [ ] Dates verified (start/completion match actual timeline)
- [ ] Dimensions verified (measurements match actual diorama)
- [ ] Materials listed are actually used
- [ ] Techniques described are actually employed
- [ ] Time estimates are realistic and verified

**Narrative Authenticity:**
- [ ] All experiences described are personal/actual
- [ ] No assumed or invented details
- [ ] Challenges described actually occurred
- [ ] Learning moments are genuine
- [ ] No generic template text remains

**Image Validation:**
- [ ] All image paths verified to exist
- [ ] Image captions describe actual photos
- [ ] Gallery images are from actual project
- [ ] No placeholder image references

**AI-Generated Content Review:**
- [ ] All `[AI-CHECK]` markers reviewed
- [ ] AI-generated transitions verified for accuracy
- [ ] AI-organized structure approved by human
- [ ] No AI assumptions or inventions present

**Publication Readiness:**
- [ ] All `[TODO]` sections completed or removed
- [ ] All `[NEEDS MORE]` sections expanded
- [ ] Content marked `[COMPLETE]`
- [ ] Validation markers removed from final version
- [ ] Front matter `published:` set appropriately

---

## Why Source-Narrative?

### Advantages Over Traditional Build Logs

**For Readers**:
- Complete story in one place
- Natural reading flow without jumping between entries
- Better context for understanding decisions and challenges
- More engaging and immersive experience
- Professional portfolio-quality presentation

**For Authors**:
- Easier to write comprehensive retrospective
- Better organization of thoughts and timeline
- Single file to maintain and update
- Clearer vision of overall project arc
- Freedom to structure story optimally

**For Projects**:
- Better showcases finished work
- Highlights key techniques and innovations
- Documents full decision-making process
- Preserves learning moments and challenges
- Creates reference material for future work

### When to Use Source-Narrative

**Ideal For**:
- ✅ Completed projects ready for documentation
- ✅ Projects with strong storytelling potential
- ✅ When all images and content are available
- ✅ Portfolio or showcase presentations
- ✅ Complex projects with many phases
- ✅ Retrospective documentation

**Better to Use Build Logs For**:
- 📝 Projects currently in progress
- 📝 Real-time updates as work happens
- 📝 Learning documentation during process
- 📝 Projects that might pause/resume
- 📝 Collaborative projects

---

## The Workflow

### Phase 1: Write Raw Narrative

**Objective**: Capture the complete project story without worrying about structure.

#### Steps:
1. **Free-Write the Story**
   - Start from the very beginning (initial concept, inspiration)
   - Write chronologically through completion
   - Include all memorable moments, challenges, breakthroughs
   - Don't worry about length or polish
   - Focus on capturing everything while memory is fresh

2. **Include Key Elements**:
   - **Inspiration**: What sparked the project?
   - **Planning**: How did you approach it?
   - **Challenges**: What went wrong?
   - **Solutions**: How did you solve problems?
   - **Techniques**: What methods did you use?
   - **Timeline**: When did things happen?
   - **Materials**: What did you build with?
   - **Learning**: What did you discover?
   - **Results**: How did it turn out?

3. **Don't Self-Edit Yet**
   - Write everything that comes to mind
   - Redundancy is fine at this stage
   - Keep writing until story feels complete
   - Save as `project-name-SOURCE-NARRATIVE.md`

#### Example Structure:
```markdown
# Log Cabin Project - Raw Narrative

I got the idea for this cabin after completing Cathy's flower house. 
That project taught me how to make miniature plants, and I was excited 
to try making trees and natural vegetation...

[Continue with full story, unstructured]
```

---

### Phase 2: Organize into Chapters

**Objective**: Structure the narrative into logical, chronological sections.

#### Steps:
1. **Read Through Narrative**
   - Identify natural break points
   - Look for phase transitions
   - Note timeline progression

2. **Define Chapters**
   - Aim for 6-10 chapters typically
   - Each chapter = distinct phase or focus
   - Clear timeline for each chapter
   - Logical progression from one to next

3. **Common Chapter Structure**:
   ```
   Chapter 1: Concept and Planning
   Chapter 2: Foundation/Base Construction
   Chapter 3: Main Structure Building
   Chapter 4: Secondary Structures/Details
   Chapter 5: Specialized Work (plants, weathering, etc.)
   Chapter 6: Scenery and Environment
   Chapter 7: Final Details and Refinement
   Chapter 8: Weathering and Finishing
   Chapter 9: Photography and Completion
   ```

4. **Reorganize Content**
   - Move text into appropriate chapters
   - Cut redundancy
   - Smooth transitions between chapters
   - Add chapter headings with dates
   - Save as `project-name-SOURCE-NARRATIVE-ORGANIZED.md`

#### Example:
```markdown
# Log Cabin - Organized Narrative

## Chapter 1: Concept and Planning
**Timeline: January 20-27, 2024**

Cathy's flower house kit introduced me to the skill of making small 
plants, and I love plants. I was all fired up to make some trees...

[Content for this phase]

## Chapter 2: Foundation and Base Construction
**Timeline: January 28 - February 3, 2024**

With the concept finalized, I began construction of the base...

[Content for this phase]
```

---

### Phase 3: Add Image Markers

**Objective**: Plan where images should appear in the narrative.

#### Steps:
1. **Read Through Each Chapter**
   - Identify moments that need visual support
   - Note where process steps should be shown
   - Mark good locations for before/after comparisons

2. **Add Image Markers**
   - Use format: `[IMAGE: descriptive-filename]`
   - Be specific about what image should show
   - Use consistent naming convention
   - Consider flow and pacing

3. **Naming Convention**:
   ```
   project-build1-001.jpg  (Chapter 1, image 1)
   project-build1-002.jpg  (Chapter 1, image 2)
   project-build2-001.jpg  (Chapter 2, image 1)
   ...
   project-gallery-001.jpg (Final gallery image 1)
   ```

4. **Types of Images**:
   - **Process Images**: Show work in progress (inline in chapters)
   - **Result Images**: Show completed phases (end of chapters)
   - **Detail Images**: Highlight specific techniques or features
   - **Gallery Images**: Final showcase images (separate gallery array)

#### Example:
```markdown
## Chapter 1: Concept and Planning
**Timeline: January 20-27, 2024**

I began by creating the foundation from extruded polystyrene foam.

[IMAGE: log-cabin-build1-001.jpg - Initial styrofoam cliff and base]
*Caption: Starting with the foundation - extruded polystyrene shaped 
into rocky cliff face*

After shaping, I tested different cabin placements to find the best 
composition.

[IMAGE: log-cabin-build1-002.jpg - Testing cabin placement layouts]
```

---

### Phase 4: Validate Images

**Objective**: Ensure all needed images exist and are properly organized.

#### Steps:
1. **Extract Image Markers**
   - Search for all `[IMAGE: ...]` markers
   - Create list of needed images
   - Note which chapter each belongs to

2. **Check Existing Images**
   - List all available project images
   - Match filenames to markers
   - Identify missing images
   - Note images that need renaming

3. **Organize Image Files**:
   ```
   assets/images/projects/project-name/
   ├── project-name-build1-001.jpg
   ├── project-name-build1-002.jpg
   ├── project-name-build2-001.jpg
   ├── ...
   └── project-name-gallery-001.jpg
   ```

4. **Validation Checklist**:
   - [ ] All markers have corresponding files
   - [ ] Filenames follow naming convention
   - [ ] Images are in correct folder
   - [ ] Image quality is acceptable
   - [ ] Gallery images are separate from process images
   - [ ] No duplicate or unused images

#### PowerShell Validation Example:
```powershell
# Get all image markers from narrative
$content = Get-Content "project-SOURCE-NARRATIVE-ORGANIZED.md"
$markers = $content | Select-String -Pattern '\[IMAGE: (.+?)\]' -AllMatches

# List required images
$markers.Matches | ForEach-Object {
    $_.Groups[1].Value
}

# Check if files exist
$imagePath = "assets\images\projects\project-name\"
$markers.Matches | ForEach-Object {
    $filename = $_.Groups[1].Value
    if (Test-Path "$imagePath$filename") {
        Write-Host "✓ $filename" -ForegroundColor Green
    } else {
        Write-Host "✗ $filename MISSING" -ForegroundColor Red
    }
}
```

---

### Phase 5: Convert to Jekyll Markdown

**Objective**: Transform organized narrative with image markers into final Jekyll markdown.

#### Steps:

1. **Set Up Front Matter**

Create comprehensive metadata at top of file:

```yaml
---
layout: project
title: "Project Name - Brief Description"
date: YYYY-MM-DD
categories: [category1, category2]
tags: [tag1, tag2, tag3]
scale: "1:35"
featured_image: /assets/images/projects/project-name/featured-image.jpg
gallery:
  - /assets/images/projects/project-name/project-name-gallery-001.jpg
  - /assets/images/projects/project-name/project-name-gallery-002.jpg
  - /assets/images/projects/project-name/project-name-gallery-003.jpg
---
```

**Front Matter Fields**:
- `layout: project` - Uses project template (auto-generates gallery)
- `title` - Full project name and brief description
- `date` - Project completion or start date (YYYY-MM-DD)
- `categories` - High-level categories (e.g., [Architectural, Nature])
- `tags` - Specific keywords (e.g., [scratch-build, woodland, cabin])
- `scale` - Model scale (e.g., "1:35" or "1:50")
- `featured_image` - Main hero image (absolute path)
- `gallery` - Array of final showcase images (absolute paths)

2. **Convert Image Markers to Markdown**

Replace each marker with proper markdown syntax:

**Before**:
```markdown
[IMAGE: project-build1-001.jpg - Caption text here]
```

**After**:
```markdown
![Caption text here](/assets/images/projects/project-name/project-build1-001.jpg)
*Caption with additional context or description*
```

**Path Format Rules**:
- ✅ Always use absolute paths from site root
- ✅ Start with `/assets/images/...`
- ✅ Include full filename with extension
- ❌ Never use relative paths like `../images/...`
- ❌ Don't use Liquid template syntax in content

3. **Format Chapter Headings**

```markdown
## Chapter 1: Concept and Planning
**Timeline: January 20-27, 2024**

[Chapter content...]

## Chapter 2: Foundation Construction  
**Timeline: January 28 - February 3, 2024**

[Chapter content...]
```

4. **Add Introduction and Conclusion**

```markdown
---
layout: project
[... front matter ...]
---

[Brief project introduction - 2-3 paragraphs overview]

## Chapter 1: Concept and Planning
[Chapters...]

## Completion and Reflection

[Final thoughts, lessons learned, future plans]

**Completion Date:** April 10, 2024
```

5. **Ensure Pure Markdown**

**Critical**: Do NOT mix HTML tags with markdown
- ❌ No `<div>`, `<section>`, `<figure>` tags
- ❌ No `<style>` blocks (use external CSS)
- ❌ No `<span>` or `<p>` tags
- ✅ Use pure markdown syntax only
- ✅ Use Kramdown extensions if needed: `{: .class-name}`

**Why**: Jekyll's Kramdown processor doesn't handle mixed HTML/markdown well

#### Complete Example:

```markdown
---
layout: project
title: "Log Cabin in the Woods - Scratch-Built Wilderness Diorama"
date: 2024-04-10
categories: [Architectural, Nature]
tags: [scratch-build, cabin, woodland, diorama, 1-35-scale]
scale: "1:35"
featured_image: /assets/images/projects/log-cabin/log-cabin-gallery-001.jpg
gallery:
  - /assets/images/projects/log-cabin/log-cabin-gallery-001.jpg
  - /assets/images/projects/log-cabin/log-cabin-gallery-002.jpg
  - /assets/images/projects/log-cabin/log-cabin-gallery-003.jpg
---

A detailed scratch-built log cabin diorama set deep in the woods, featuring 
handcrafted cabin structure with individual logs, stone chimney, and timber 
roof. The woodland environment uses real plant materials, natural moss and 
lichen, and carefully prepared vegetation to create an authentic forest setting.

## Chapter 1: Concept and Planning
**Timeline: January 20-27, 2024**

Cathy's flower house kit introduced me to the skill of making small plants, 
and I love plants. I was all fired up to make some trees and explore natural 
vegetation techniques.

![Initial foundation work](/assets/images/projects/log-cabin/log-cabin-build1-001.jpg)
*Starting with the foundation - extruded polystyrene shaped into rocky cliff face*

After creating the base terrain, I tested different cabin placements to find 
the optimal composition.

![Testing layouts](/assets/images/projects/log-cabin/log-cabin-build1-002.jpg)
*Testing various cabin positions to find the best visual balance*

[Continue with rest of content...]
```

---

### Phase 6: Deploy and Verify

**Objective**: Publish to GitHub Pages and verify everything works correctly.

#### Deployment Steps:

1. **Pre-Deployment Checklist**:
   - [ ] Front matter complete and correct
   - [ ] All image paths are absolute (`/assets/images/...`)
   - [ ] Gallery array has absolute paths
   - [ ] No HTML tags in markdown
   - [ ] Chapter headings properly formatted
   - [ ] All images exist in correct folder
   - [ ] File saved as `../../_projects/project-name.md`

2. **Git Workflow**:
   ```powershell
   # Navigate to repository
   cd path\to\Models4Comfort
   
   # Add new project file
   git add ../../_projects/project-name.md
   
   # Add all project images
   git add assets/images/projects/project-name/
   
   # Commit with descriptive message
   git commit -m "Add project-name with complete narrative and images"
   
   # Push to GitHub
   git push
   ```

3. **Wait for Build**:
   - GitHub Pages rebuild takes 1-3 minutes
   - Check Actions tab for build status
   - Look for green checkmark

4. **Verification Steps**:

**Check Project Page**:
- Navigate to: `https://username.github.io/repo/projects/project-name/`
- ✓ Page loads without errors
- ✓ Title and metadata display correctly
- ✓ All inline images appear
- ✓ Images are appropriately sized (not too large)
- ✓ Captions display under images
- ✓ Chapter headings render properly

**Check Gallery**:
- Scroll to bottom of page
- ✓ Gallery section appears (auto-generated by template)
- ✓ All gallery images display
- ✓ Images in grid layout
- ✓ No duplicate gallery sections
- ✓ Images link/expand properly

**Check Listings**:
- Navigate to projects index: `https://username.github.io/repo/projects/`
- ✓ Project appears in list
- ✓ Featured image displays
- ✓ Excerpt/description shows correctly
- ✓ Link to project works

**Check Mobile**:
- View page on mobile device or narrow browser
- ✓ Images scale down appropriately
- ✓ Text is readable
- ✓ Layout doesn't break
- ✓ Gallery grid adjusts for small screen

5. **Common Issues and Fixes**:

**Issue**: Images too large
- **Solution**: Add CSS to `assets/css/main.css`:
  ```css
  .page-content img {
    max-width: 600px;
    height: auto;
    display: block;
    margin: 1rem auto;
  }
  ```

**Issue**: Gallery not appearing
- **Check**: Gallery paths in front matter are absolute
- **Check**: No stray HTML tags breaking template
- **Check**: Front matter `gallery:` array is properly formatted

**Issue**: Duplicate galleries
- **Cause**: Manual gallery section in markdown
- **Solution**: Remove manual gallery - template handles it automatically

**Issue**: Text layout broken
- **Cause**: HTML tags mixed with markdown
- **Solution**: Remove all HTML tags, use pure markdown

**Issue**: CSS not applying
- **Cause**: Inline `<style>` blocks stripped by Jekyll
- **Solution**: Move all CSS to external stylesheet

---

## Best Practices

### Content Writing

**Narrative Voice**:
- Write in first person for authenticity
- Be conversational but informative
- Share your thought process and decision-making
- Don't hide mistakes - they're valuable learning moments
- Balance technical detail with storytelling

**Image Captions**:
- Caption explains what's shown
- Italicized text below adds context or technique notes
- Keep captions concise (one sentence)
- Use context text for longer explanations

**Chapter Length**:
- Aim for 300-500 words per chapter
- Include 3-5 images per chapter typically
- Don't force equal length - natural breaks matter more
- Some chapters may be longer if phase was complex

### Image Strategy

**Selection**:
- Choose images that show progress, not repetition
- Include key decision points and milestones
- Show techniques and methods clearly
- Balance wide shots and detail shots
- Quality over quantity

**Organization**:
- Consistent naming: `project-phase-number.jpg`
- Number sequentially within each phase
- Separate gallery images from process images
- Keep original high-res versions as backup

**Sizing**:
- Process images: 600-800px wide typical
- Gallery images: 1200-1600px wide for detail
- Compress appropriately (balance quality/file size)
- Use consistent aspect ratios where possible

### Technical

**Front Matter**:
- Always include `layout: project`
- Use absolute paths in gallery array
- Date format: `YYYY-MM-DD`
- Tags: lowercase, hyphenated
- Categories: Title Case

**Paths**:
- Inline images: `/assets/images/projects/name/file.jpg`
- Gallery images: same format in front matter array
- Never use relative paths (`../` or `./`)
- Always include leading slash

**Markdown**:
- No HTML tags in content
- Use `##` for chapter headings
- Use `**text**` for bold (timeline, labels)
- Use `*text*` for italic (captions)
- Use `>` for blockquotes (optional for important notes)

**CSS**:
- No inline styles
- All CSS in `assets/css/main.css`
- Use clear section comments
- Include responsive breakpoints

---

## Template Behavior

### Project Layout (`_layouts/project.html`)

The project template automatically provides:

**Gallery Generation**:
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

**Key Points**:
- Reads `gallery:` array from front matter
- Applies `relative_url` filter to each path
- Auto-generates gallery section at page bottom
- Only appears if `gallery:` array exists
- **Never create manual gallery section**

### Path Processing

**How Paths Work**:
1. Front matter: `/assets/images/projects/name/file.jpg`
2. Template applies: `{{ image | relative_url }}`
3. Result: Correct path relative to site base URL

**Why Absolute Paths Matter**:
- Template expects full path from site root
- `relative_url` filter needs complete path
- Relative filenames won't resolve correctly
- Ensures consistency across all pages

---

## Workflow Summary Checklist

### Phase 1: Write
- [ ] Free-write complete project story
- [ ] Include all key elements (inspiration → completion)
- [ ] Don't self-edit yet
- [ ] Save as `project-SOURCE-NARRATIVE.md`

### Phase 2: Organize
- [ ] Define 6-10 logical chapters
- [ ] Move content into chapters
- [ ] Add chapter headings with timelines
- [ ] Cut redundancy, smooth transitions
- [ ] Save as `project-SOURCE-NARRATIVE-ORGANIZED.md`

### Phase 3: Plan Images
- [ ] Read through each chapter
- [ ] Add `[IMAGE: filename]` markers
- [ ] Use consistent naming convention
- [ ] Note gallery images separately

### Phase 4: Validate
- [ ] List all image markers
- [ ] Check files exist
- [ ] Rename/organize as needed
- [ ] Verify image quality
- [ ] Separate gallery from process images

### Phase 5: Convert
- [ ] Create front matter with metadata
- [ ] Set up gallery array (absolute paths)
- [ ] Convert markers to markdown image syntax
- [ ] Ensure pure markdown (no HTML)
- [ ] Add introduction and conclusion
- [ ] Save as `../../_projects/project-name.md`

### Phase 6: Deploy
- [ ] Run pre-deployment checklist
- [ ] Add files to git
- [ ] Commit with descriptive message
- [ ] Push to GitHub
- [ ] Wait for rebuild (1-3 min)
- [ ] Verify project page
- [ ] Verify gallery
- [ ] Verify listings
- [ ] Check mobile view

---

## Example Projects

### Log Cabin in the Woods
- **File**: `../../_projects/log-cabin.md`
- **Stats**: 679 lines, 9 chapters, 42 inline images, 8 gallery images
- **Timeline**: January 20 - April 10, 2024 (81 days)
- **Link**: https://lcilliers.github.io/hobbies-modelling4comfort/projects/log-cabin/

**What Works Well**:
- Clear chronological progression through build phases
- Natural integration of technique explanations
- Good balance of wide shots and detail images
- Effective use of timeline markers
- Authentic narrative voice

---

## Additional Resources

- **[IMAGE-LAYOUT-GUIDE.md](../guides/IMAGE-LAYOUT-GUIDE.md)** - Image sizing and layout techniques
- **[SITE-EDITING-GUIDE.md](../guides/SITE-EDITING-GUIDE.md)** - General site editing workflows
- **[PUBLISHING-GUIDE.md](../guides/PUBLISHING-GUIDE.md)** - Deployment and troubleshooting
- **[IMAGEMAGICK-GUIDE.md](../guides/IMAGEMAGICK-GUIDE.md)** - Image optimization with ImageMagick
- **[Scripts Documentation](../../scripts/README.md)** - PowerShell scripts for image optimization and build log creation
- **Jekyll Documentation** - https://jekyllrb.com/docs/
- **Kramdown Syntax** - https://kramdown.gettalong.org/syntax.html

---

## Conclusion

The Source-Narrative methodology transforms project documentation from fragmented build logs into comprehensive, engaging stories. By writing the narrative first and strategically integrating images, you create portfolio-quality project pages that both inform and inspire.

**Key Takeaways**:
- Story first, structure second
- Images enhance narrative, don't interrupt it
- Pure markdown works best
- Template features simplify gallery creation
- Systematic workflow ensures consistency

Apply this methodology to your next completed project and experience the difference comprehensive narrative makes in showcasing your work.
