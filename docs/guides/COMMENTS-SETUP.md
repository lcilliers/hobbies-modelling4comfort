# Comment System Setup

This site supports GitHub-based commenting through Utterances or Giscus.

## Why GitHub-Based Comments?

✅ **Free and Open Source**
✅ **No Ads**
✅ **GitHub Account Required** (reduces spam)
✅ **Markdown Support**
✅ **No Database Required**
✅ **Privacy Friendly**

## Option 1: Utterances (Simpler, Recommended)

### Setup Steps

1. **Install the Utterances GitHub App**
   - Go to: https://github.com/apps/utterances
   - Click "Install"
   - Select "Only select repositories"
   - Choose: `lcilliers/hobbies-modelling4comfort`
   - Click "Install"

2. **Configuration (Already Done)**
   - The site is pre-configured to use Utterances
   - Comments appear as GitHub Issues
   - Each page gets its own issue

3. **Enable in Your Site**
   
   **For Jekyll** (already configured in `_config.yml`):
   ```yaml
   comments:
     provider: "utterances"
     utterances:
       repo: "lcilliers/hobbies-modelling4comfort"
       issue-term: "pathname"
       theme: "github-light"
   ```

4. **Test It**
   - Visit any page with `comments: true` in front matter
   - Leave a test comment
   - Check Issues tab in your repository

### Customization

Change the theme in `_config.yml`:
- `github-light` (default)
- `github-dark`
- `github-dark-orange`
- `icy-dark`
- `dark-blue`
- `photon-dark`

## Option 2: Giscus (More Features)

Giscus uses GitHub Discussions instead of Issues, providing more features.

### Setup Steps

1. **Enable Discussions**
   - Go to your repository: https://github.com/lcilliers/hobbies-modelling4comfort
   - Settings → General
   - Scroll to "Features"
   - Check "Discussions"
   - Save

2. **Install Giscus App**
   - Go to: https://github.com/apps/giscus
   - Click "Install"
   - Select your repository
   - Install

3. **Get Configuration Values**
   - Visit: https://giscus.app
   - Enter your repository: `lcilliers/hobbies-modelling4comfort`
   - Choose "Announcements" category (or create a new one)
   - Copy the generated values

4. **Update Your Site Configuration**

   **For Jekyll**, update `_config.yml`:
   ```yaml
   comments:
     provider: "giscus"
     giscus:
       repo: "lcilliers/hobbies-modelling4comfort"
       repo_id: "YOUR_REPO_ID"  # From giscus.app
       category: "Announcements"
       category_id: "YOUR_CATEGORY_ID"  # From giscus.app
   ```

5. **Update Comments Template**
   - Edit `_includes/comments.html`
   - Uncomment the Giscus section
   - Comment out the Utterances section

## Comparison

| Feature | Utterances | Giscus |
|---------|-----------|--------|
| Backend | GitHub Issues | GitHub Discussions |
| Setup Complexity | Simple | Medium |
| Reactions | ❌ | ✅ |
| Reply Threading | Limited | ✅ |
| Comment Sorting | ❌ | ✅ |
| Upvoting | ❌ | ✅ |

## My Recommendation

**Start with Utterances:**
- Simpler setup
- Works immediately
- Perfect for hobby sites
- Easy to migrate to Giscus later

**Use Giscus if you want:**
- Better discussion features
- Reactions and upvoting
- Threaded replies
- Comment sorting options

## Testing Comments Locally

Comments won't work on localhost. To test:

1. Push your site to GitHub
2. Enable GitHub Pages
3. Visit the live site
4. Leave a test comment

## Moderation

### View Comments
- **Utterances**: Check Issues tab
- **Giscus**: Check Discussions tab

### Moderate Comments
- Edit, delete, or lock as needed
- Close issues/discussions to disable comments on specific pages
- Block users if necessary

### Disable Comments on Specific Pages

In the page's front matter:
```yaml
---
title: My Page
comments: false  # Disables comments
---
```

## Privacy Considerations

- Comments require a GitHub account
- Commenters' GitHub profiles are visible
- Comments are public (stored in your repository)
- You control the data (it's in your repo)

## Alternative Comment Systems (Not Recommended for Free Hobby Sites)

- **Disqus**: Has ads on free tier
- **Commento**: Requires self-hosting or paid plan
- **Facebook Comments**: Privacy concerns
- **Hyvor Talk**: Paid service

## Troubleshooting

### Comments Not Appearing

1. Check that the app is installed on your repository
2. Verify repository is public
3. Ensure `comments: true` in page front matter
4. Check browser console for errors
5. Confirm you're on the live site (not localhost)

### Wrong Repository in Comments

Update the `repo` value in your configuration file.

### Theme Not Matching Site

Change the `theme` value in your configuration to match your site's design.

## Next Steps

1. ✅ Install Utterances app on your repository
2. ✅ Configuration is already complete
3. ✅ Push your site to GitHub
4. ✅ Enable GitHub Pages
5. ✅ Test comments on your live site

Comments are now ready to use! 🎉
