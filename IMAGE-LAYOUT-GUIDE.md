# Image Layout Guide for Build Logs

This guide shows how to use different image layouts in your build log markdown files.

## Default Centered Image (Current Behavior)

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

**Need help?** Refer to this guide when adding photos to your build logs. All layouts are already set up in the CSS and ready to use!
