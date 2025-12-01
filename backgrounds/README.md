# Background Images for Green Screen Replacement

This folder stores background images used for green screen replacement in diorama photography.

## Quick Start

### 1. Find Free Background Images

**Recommended Sites:**
- **Unsplash** - https://unsplash.com/s/photos/seabird-sky-clouds
- **Pexels** - https://www.pexels.com/search/ocean%20sky%20clouds/
- **Pixabay** - https://pixabay.com/images/search/seagull%20sky/

**Search Terms:**
- "seabird flying blue sky"
- "ocean sky clouds"
- "seagull maritime scene"
- "blue sky white clouds bird"
- "coastal sky seabird"

### 2. Download Using Script

```powershell
# Download from direct image URL
.\scripts\download-background.ps1 -Url "https://images.unsplash.com/photo-xxxxx" -OutputPath "ocean-sky.jpg"
```

### 3. Or Download Manually

1. Right-click image on website
2. "Save Image As..."
3. Save to this `backgrounds` folder
4. Use descriptive names like `ocean-sunset.jpg`, `cloudy-sky-seagull.jpg`

## AI-Generated Backgrounds

### Microsoft Bing Image Creator (Free)
URL: https://www.bing.com/images/create

**Recommended Prompts:**
```
Blue sky with white fluffy clouds and a seabird flying overhead, realistic photography, 
wide angle, ocean atmosphere, professional maritime photography, 4K resolution
```

```
Seagull soaring through cloudy blue sky, realistic ocean scene, 
atmospheric perspective, natural lighting, photorealistic
```

```
Maritime sky background with cumulus clouds and flying seabird, 
professional photography style, high detail, coastal atmosphere
```

### Leonardo.AI
URL: https://leonardo.ai
- Free tier available
- Great for photorealistic backgrounds

### Playground AI
URL: https://playgroundai.com
- Free generation
- Multiple style options

## Using Backgrounds with Your Photos

Once you have a background image, use it like this:

```powershell
# Replace green screen with ocean background
.\scripts\imagemagick-optimize.ps1 `
    -SourceFolder "\\LSUK-SYNRACK\HomeMedia\hobbies\model building\German-sail-boat" `
    -ReplaceGreenScreen `
    -BackgroundImage "backgrounds\ocean-sky-seagull.jpg" `
    -GreenTolerance 15
```

## Tips for Choosing Backgrounds

### For Maritime/Nautical Dioramas:
- Ocean horizons with clouds
- Coastal skies
- Seabirds in flight
- Sunset/sunrise over water
- Storm clouds over sea

### For Forest/Nature Dioramas:
- Blurred forest backgrounds
- Dappled sunlight through trees
- Mountain landscapes
- Garden bokeh

### For Urban Dioramas:
- Blurred city streets
- Building facades
- Urban sky with buildings

### Technical Considerations:
- **Resolution**: At least 1920x1920 or higher
- **Perspective**: Match the angle of your diorama photo
- **Lighting**: Should match the lighting on your model
- **Focus**: Slightly blurred backgrounds work better (natural depth of field)
- **Color Temperature**: Warm (sunset) vs cool (overcast) should match your scene

## Recommended Image Dimensions

For best results, use backgrounds that are:
- **Minimum**: 1920 x 1920 pixels
- **Optimal**: 2560 x 1920 pixels or larger
- **Aspect Ratio**: Wide/landscape format works best

Larger images give you flexibility to crop and compose.

## Example Collection Structure

Organize your backgrounds by theme:

```
backgrounds/
├── maritime/
│   ├── ocean-sky-seagull.jpg
│   ├── coastal-sunset.jpg
│   └── stormy-sea.jpg
├── nature/
│   ├── forest-blur.jpg
│   ├── mountain-landscape.jpg
│   └── garden-bokeh.jpg
└── urban/
    ├── city-street-blur.jpg
    └── building-backdrop.jpg
```

## Free Resources

### Stock Photo Sites (100% Free):
1. **Unsplash** - High quality, no attribution required
2. **Pexels** - Free to use, great collection
3. **Pixabay** - Free images and vectors
4. **Burst by Shopify** - Free stock photos
5. **StockSnap** - Large collection of free photos

### Creative Commons Search:
- https://search.creativecommons.org/

### License Info:
When using stock photos, check the license:
- ✅ CC0 / Public Domain - Use freely, no attribution
- ✅ Unsplash License - Use freely, attribution appreciated
- ⚠️ CC BY - Requires attribution
- ❌ Rights Managed - May require payment

## Next Steps

1. Browse recommended sites above
2. Download 3-5 backgrounds for different scenes
3. Save to this folder with descriptive names
4. Test with your diorama photos using the green screen script
5. Build a collection of favorites for future projects
