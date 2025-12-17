# Deployment Setup for GitHub Pages

This folder contains GitHub Actions workflows for automated deployment.

## Available Workflows

### 1. Jekyll (jekyll.yml) - RECOMMENDED FOR BEGINNERS
- **Activation**: Rename to use (already active if using Jekyll)
- **Setup**: No additional configuration needed
- **Built-in**: GitHub Pages natively supports Jekyll

### 2. Hugo (hugo.yml)
- **Activation**: Use if you choose Hugo
- **Setup**: May need to install Hugo theme first
- **Performance**: Fastest build times

### 3. Eleventy (eleventy.yml)
- **Activation**: Use if you choose 11ty
- **Setup**: Requires npm dependencies
- **Flexibility**: Most flexible modern option

## Activation Instructions

### Step 1: Choose Your Static Site Generator

You only need ONE workflow active. The easiest path:

**Option A: Jekyll (Recommended)**
- No additional setup required
- Works out of the box with GitHub Pages
- Keep `jekyll.yml`, delete or disable others

**Option B: Hugo**
- More complex but faster
- Delete or rename `jekyll.yml` and `eleventy.yml`
- Keep only `hugo.yml`

**Option C: Eleventy**
- Modern JavaScript-based
- Delete or rename `jekyll.yml` and `hugo.yml`
- Keep only `eleventy.yml`

### Step 2: Enable GitHub Pages

1. Go to your repository on GitHub
2. Settings → Pages
3. Source: Select "GitHub Actions"
4. Save

### Step 3: Configure Repository Content

Based on your choice:

**If using Jekyll:**
- Work in the root directory
- Edit `_config.yml` to customize
- Add content to `_projects/`, `_builds/`, `_techniques/`
- Push to main branch

**If using Hugo:**
- Work in the `hugo/` directory
- Edit `hugo/config.toml` to customize
- Add content to `hugo/content/`
- Push to main branch

**If using Eleventy:**
- Work in the `eleventy/` directory
- Edit `eleventy/.eleventy.js` to customize
- Add content to `eleventy/src/`
- Push to main branch

## Workflow Triggers

All workflows trigger on:
- Push to `main` branch
- Manual dispatch (Actions tab → Run workflow)

## Testing Your Deployment

After pushing to main:

1. Go to Actions tab in your repository
2. Watch the workflow run
3. Once complete (green checkmark), visit your site:
   - `https://modelling4comfort.uk/`

## Troubleshooting

### Build Fails

**Jekyll:**
- Check `Gemfile` dependencies
- Verify `_config.yml` syntax
- Check Ruby version compatibility

**Hugo:**
- Verify Hugo version in workflow
- Check `config.toml` syntax
- Ensure theme is properly installed

**Eleventy:**
- Check `package.json` dependencies
- Verify `.eleventy.js` configuration
- Ensure Node version compatibility

### Site Not Displaying

1. Check Pages settings (Settings → Pages)
2. Verify source is set to "GitHub Actions"
3. Check workflow completed successfully
4. Clear browser cache

### Wrong Content Showing

- Ensure correct workflow is active
- Check `baseURL` in configuration
- Verify content is in correct directory

## My Recommendation for Beginners

**Start with Jekyll:**
1. It works immediately with GitHub Pages
2. No build tools to install locally
3. Simple configuration
4. Great documentation

Once you're comfortable, you can always switch to Hugo or Eleventy later!

## Local Development

**Jekyll:**
```bash
bundle install
bundle exec jekyll serve
```

**Hugo:**
```bash
cd hugo
hugo server -D
```

**Eleventy:**
```bash
cd eleventy
npm install
npm start
```

## Need Help?

1. Check the workflow run logs in Actions tab
2. Review configuration files for syntax errors
3. Consult the official documentation:
   - Jekyll: https://jekyllrb.com/docs/
   - Hugo: https://gohugo.io/documentation/
   - Eleventy: https://www.11ty.dev/docs/
