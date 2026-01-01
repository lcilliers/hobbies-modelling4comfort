# Feedback Form Guide

**Privacy-Focused Contact System for Modelling4Comfort**

A comprehensive guide to understanding, configuring, and maintaining the site's feedback form system using Formspree.

---

## Table of Contents

1. [Overview](#overview)
2. [Why This Approach](#why-this-approach)
3. [How It Works](#how-it-works)
4. [Formspree Setup](#formspree-setup)
5. [Form Configuration](#form-configuration)
6. [Enabling Feedback CTAs](#enabling-feedback-ctas)
7. [Customization Guide](#customization-guide)
8. [Troubleshooting](#troubleshooting)
9. [Privacy & Security](#privacy--security)
10. [Alternative Options](#alternative-options)

---

## Overview

The Modelling4Comfort site uses a **privacy-first feedback system** that replaces traditional commenting platforms (Disqus, Giscus, Utterances) with a simple contact form.

**What users see:**
- Subtle call-to-action (CTA) at the bottom of project and build log pages
- Link to dedicated `/feedback/` contact form
- Simple form with name, email, subject, and message fields

**What you get:**
- Direct email notifications for each submission
- No third-party tracking or data collection
- Spam protection via honeypot field
- Dashboard to view all submissions at Formspree.io

---

## Why This Approach

### Advantages Over Traditional Commenting Systems

**Privacy Benefits:**
- ✓ No third-party tracking scripts (Disqus, Facebook, Google)
- ✓ No visitor data harvesting
- ✓ No cookies or persistent identifiers
- ✓ Visitors don't need accounts to reach out

**Technical Benefits:**
- ✓ Works perfectly with static GitHub Pages sites
- ✓ No database or server-side code required
- ✓ Fast page load (no external scripts)
- ✓ No JavaScript required for basic functionality

**Content Benefits:**
- ✓ Direct private communication instead of public comments
- ✓ More thoughtful, detailed messages
- ✓ Personal connection with site visitors
- ✓ No spam or troll comments to moderate

**Maintenance Benefits:**
- ✓ Free tier handles 50 submissions/month
- ✓ No comment moderation needed
- ✓ Simple setup and configuration
- ✓ Owned by Formspree (reliable service since 2013)

### Trade-offs

**What you lose:**
- Public discussion threads on project pages
- Community engagement via comments
- SEO benefits from user-generated content
- Instant visitor-to-visitor interaction

**Best for:**
- Personal portfolio sites
- Hobby documentation sites
- Projects where quality > quantity of feedback
- Privacy-conscious creators

---

## How It Works

### The User Journey

1. **Visitor reads a project page** (e.g., Log Cabin in the Woods)
2. **Sees subtle CTA** at bottom: "Questions or suggestions? I'd love to hear from you"
3. **Clicks link** → navigates to `/feedback/`
4. **Fills out form** with name, email, subject, message
5. **Submits form** → Formspree processes submission
6. **You receive email** with their message and reply-to address
7. **You reply directly** via your email client

### Technical Flow

```
[Project Page with comments: true]
         ↓
[Jekyll renders _layouts/project.html]
         ↓
[Includes {% include comments.html %}]
         ↓
[Displays CTA linking to /feedback/]
         ↓
[feedback.md renders with default layout]
         ↓
[Form submits to https://formspree.io/f/mwpggoqz]
         ↓
[Formspree validates & forwards to your email]
```

### File Structure

```
Models4Comfort/
├── feedback.md                    # Contact form page
├── _includes/
│   └── comments.html              # CTA include (replaces old comment embeds)
├── _layouts/
│   ├── build.html                 # Build log template (includes CTA)
│   └── project.html               # Project template (includes CTA)
├── assets/css/
│   └── main.css                   # CTA styling (.build-feedback, .project-feedback)
└── _projects/
    ├── log-cabin.md               # comments: true enables CTA
    └── ss-great-britain.md        # comments: true enables CTA
```

---

## Formspree Setup

### Initial Setup (One-Time)

**Step 1: Create Formspree Account**
1. Go to https://formspree.io
2. Sign up with your email (or GitHub account)
3. Verify your email address

**Step 2: Create a New Form**
1. Click "New Form" in dashboard
2. Name it (e.g., "Modelling4Comfort Contact Form")
3. Note your form endpoint: `https://formspree.io/f/YOUR_FORM_ID`

**Current Configuration:**
- Form ID: `mwpggoqz`
- Endpoint: `https://formspree.io/f/mwpggoqz`
- Form URL: Used in `feedback.md` action attribute

**Step 3: Verify Email Address**
1. Submit a test form from your live site
2. Formspree sends verification email to you
3. Click verification link
4. Future submissions will forward to your email

### Free Tier Limits

Formspree free plan includes:
- **50 submissions/month** (more than enough for hobby sites)
- **Unlimited forms**
- **Email notifications**
- **Spam filtering**
- **Submission dashboard**
- **AJAX support**

**If you exceed 50/month:**
- Upgrade to paid plan ($10/month for 1,000 submissions)
- Or create a new free form and rotate monthly
- Or use alternative service (see [Alternative Options](#alternative-options))

### Dashboard Features

Access at https://formspree.io/forms/mwpggoqz/submissions

**What you can see:**
- All form submissions (even if email delivery failed)
- Submission timestamps
- Name, email, subject, message content
- Export submissions as CSV
- Spam/ham classification

**What you can configure:**
- Custom email notifications
- Auto-responder messages
- reCAPTCHA integration
- Webhook endpoints
- Email templates

---

## Form Configuration

### Current Form Code

Location: `feedback.md` in root directory

```html
<form action="https://formspree.io/f/mwpggoqz" method="POST" class="feedback-form">
  
  <!-- Name field -->
  <div class="form-group">
    <label for="name">Your Name</label>
    <input type="text" name="name" id="name" required>
  </div>
  
  <!-- Email field (with special _replyto name) -->
  <div class="form-group">
    <label for="email">Your Email</label>
    <input type="email" name="_replyto" id="email" required>
  </div>
  
  <!-- Subject field (with special _subject name) -->
  <div class="form-group">
    <label for="subject">Subject</label>
    <input type="text" name="_subject" id="subject" placeholder="e.g., Question about Log Cabin project">
  </div>
  
  <!-- Message field -->
  <div class="form-group">
    <label for="message">Message</label>
    <textarea name="message" id="message" rows="8" required></textarea>
  </div>
  
  <!-- Honeypot spam protection (hidden field) -->
  <input type="text" name="_gotcha" style="display:none">
  
  <button type="submit" class="submit-button">Send Message</button>
</form>
```

### Special Formspree Field Names

Formspree recognizes certain field names for special handling:

| Field Name | Purpose | Example |
|------------|---------|---------|
| `_replyto` | Sets reply-to email address | User's email |
| `_subject` | Email subject line | "Question about Log Cabin project" |
| `_cc` | CC email addresses | `colleague@example.com` |
| `_gotcha` | Honeypot spam trap (must be hidden) | Empty field |
| `_next` | Redirect URL after submission | `/thank-you/` |
| Any other | Included in email body | `name`, `message`, `phone` |

### Adding More Fields

**Example: Add phone number (optional)**

```html
<div class="form-group">
  <label for="phone">Phone Number (optional)</label>
  <input type="tel" name="phone" id="phone">
</div>
```

**Example: Add dropdown for inquiry type**

```html
<div class="form-group">
  <label for="inquiry-type">Inquiry Type</label>
  <select name="inquiry_type" id="inquiry-type" required>
    <option value="">Select one...</option>
    <option value="question">Question about a project</option>
    <option value="suggestion">Suggestion</option>
    <option value="collaboration">Collaboration opportunity</option>
    <option value="other">Other</option>
  </select>
</div>
```

### Spam Protection

**Current Protection: Honeypot Field**

```html
<input type="text" name="_gotcha" style="display:none">
```

- Hidden from users (CSS `display:none`)
- Bots auto-fill all fields (including hidden ones)
- Formspree rejects submissions with `_gotcha` filled

**Additional Protection: reCAPTCHA (Optional)**

Enable in Formspree dashboard:
1. Go to form settings
2. Enable reCAPTCHA
3. Get Google reCAPTCHA keys
4. Add keys to Formspree settings

**Trade-off:**
- ✓ Better spam protection
- ✗ Google tracking added
- ✗ Extra friction for users

---

## Enabling Feedback CTAs

### How to Enable on Pages

Add `comments: true` to front matter of any project or build log:

**Example: Enable on project page**

```yaml
---
layout: project
title: "Log Cabin in the Woods"
date: 2024-04-10
comments: true        # ← This line enables the CTA
scale: "1:35"
status: completed
gallery:
  - /assets/images/projects/log-cabin/gallery-001.jpg
---
```

**Example: Enable on build log**

```yaml
---
layout: build
title: "Log Cabin - Step 1: Foundation"
date: 2024-04-15
comments: true        # ← This line enables the CTA
project: /projects/log-cabin/
step: 1
---
```

### Where CTAs Appear

**Project Pages (`_layouts/project.html`):**
- After main content
- After gallery section
- Before closing `</article>` tag

**Build Log Pages (`_layouts/build.html`):**
- After main content
- After materials/tools sections
- Before navigation footer

### CTA Text

**Current Text:**

**Projects:**
> Enjoyed this project? Have questions or suggestions? I'd love to hear from you.

**Build Logs:**
> Questions about this build step? Send me a message — I'm happy to help!

**To customize:** Edit `_includes/comments.html`

---

## Customization Guide

### Changing CTA Text

**File:** `_includes/comments.html`

```html
<section class="feedback-cta">
  <p>Your custom message here. <a href="{{ '/feedback' | relative_url }}">Link text</a>.</p>
</section>
```

### Changing CTA Styling

**File:** `assets/css/main.css`

**Current styles:**

```css
.build-feedback,
.project-feedback {
  margin: 2rem 0;
  padding: 1rem 1.5rem;
  background-color: #f9f9f9;
  border-left: 4px solid #4CAF50;
  border-radius: 4px;
  font-size: 0.95rem;
}
```

**Example: Make CTA more prominent**

```css
.build-feedback,
.project-feedback {
  margin: 2rem 0;
  padding: 1.5rem 2rem;
  background: linear-gradient(135deg, #e8f5e9 0%, #f1f8f4 100%);
  border: 2px solid #4CAF50;
  border-radius: 8px;
  text-align: center;
  box-shadow: 0 2px 8px rgba(76, 175, 80, 0.1);
}

.build-feedback a,
.project-feedback a {
  display: inline-block;
  margin-top: 0.5rem;
  padding: 0.75rem 2rem;
  background-color: #4CAF50;
  color: white;
  font-weight: 600;
  border-radius: 4px;
  text-decoration: none;
  transition: background-color 0.2s;
}

.build-feedback a:hover,
.project-feedback a:hover {
  background-color: #45a049;
  text-decoration: none;
}
```

### Changing Form Styling

**File:** `feedback.md` (styles in `<style>` block)

**Current form width:** `max-width: 600px`

**Example: Wider form**

```css
.feedback-form {
  max-width: 800px;
  margin: 2rem auto;
}
```

**Example: Different color scheme**

```css
.form-group input:focus,
.form-group textarea:focus {
  border-color: #2196F3;  /* Blue instead of green */
  box-shadow: 0 0 0 2px rgba(33, 150, 243, 0.1);
}

.submit-button {
  background-color: #2196F3;
}

.submit-button:hover {
  background-color: #1976D2;
}
```

### Adding Thank You Page

**Step 1: Create thank-you page**

File: `thank-you.md`

```markdown
---
layout: default
title: Thank You
permalink: /thank-you/
---

# Thank You!

Your message has been sent successfully. I'll get back to you soon!

[← Return to Homepage](/)
```

**Step 2: Add redirect to form**

In `feedback.md`, add hidden field:

```html
<input type="hidden" name="_next" value="https://modelling4comfort.uk/thank-you/">
```

### Changing Notification Email

**Option 1: In Formspree Dashboard**
1. Go to https://formspree.io/forms/mwpggoqz/settings
2. Change "Email" field
3. Verify new email address

**Option 2: Create New Form**
1. Create new form with different email
2. Update `feedback.md` with new form ID
3. Commit and push

---

## Troubleshooting

### Form Submissions Not Arriving

**Check 1: Email Verification**
- Go to https://formspree.io/forms/mwpggoqz/submissions
- If submissions appear there but not in email, verification needed
- Check spam folder for Formspree verification email
- Click verification link

**Check 2: Spam Folder**
- Formspree emails may be marked as spam initially
- Add `no-reply@formspree.io` to contacts
- Mark as "Not Spam" to train filter

**Check 3: Email Settings**
- Log into Formspree dashboard
- Check notification email address is correct
- Try changing notification email and re-verifying

**Check 4: Form Submission Limit**
- Free tier: 50 submissions/month
- Check dashboard for quota usage
- Upgrade plan if needed

### CTA Not Appearing

**Check 1: Front Matter**
```yaml
comments: true  # Must be exactly this (lowercase, no quotes)
```

**Check 2: Layout**
- Project pages must use `layout: project`
- Build logs must use `layout: build`
- Other layouts need manual CTA inclusion

**Check 3: Cache**
- Clear browser cache
- Wait 2-3 minutes after pushing for rebuild
- Try incognito/private window

**Check 4: Template**
Verify `_layouts/project.html` includes:

```liquid
{% if page.comments %}
  {% include comments.html %}
{% endif %}
```

### Form Not Submitting

**Check 1: Form Action URL**
```html
<form action="https://formspree.io/f/mwpggoqz" method="POST">
```
Must be exact URL (no trailing slash, correct form ID)

**Check 2: Required Fields**
- Ensure required fields have values
- Check browser console for validation errors

**Check 3: JavaScript Conflicts**
- Form works without JavaScript
- Check browser console for errors
- Try disabling browser extensions

**Check 4: CORS Issues**
- Formspree handles CORS automatically
- Ensure form submits with `method="POST"`

### Spam Submissions

**Solution 1: Enable reCAPTCHA**
- Add in Formspree dashboard
- Trade-off: Google tracking added

**Solution 2: Add More Honeypot Fields**
```html
<input type="text" name="_gotcha" style="display:none">
<input type="email" name="email_confirm" style="display:none">
```

**Solution 3: Custom Validation**
Add timestamp field to detect instant submissions:

```html
<input type="hidden" name="submission_time" id="submission-time">
<script>
  document.getElementById('submission-time').value = Date.now();
</script>
```

---

## Privacy & Security

### What Data Is Collected

**By Formspree:**
- Submitter's name (from form)
- Submitter's email (from form)
- Message content (from form)
- Submission timestamp
- IP address (for spam detection)
- User agent (for spam detection)

**Not Collected:**
- Tracking cookies
- Browsing history
- Third-party advertising data
- Social media connections

### Data Storage

- Stored on Formspree servers (AWS, US-based)
- Retained indefinitely (free tier)
- Exportable via dashboard CSV download
- Deletable via dashboard (individual submissions)

### GDPR Compliance

**Your Responsibilities:**
- Add privacy policy mentioning Formspree usage
- Inform visitors their data is processed by third party
- Provide contact method for data deletion requests

**Example Privacy Policy Addition:**

> **Contact Form:** When you submit our contact form, your name, email, and message are processed by Formspree Inc. to deliver your message to us. See [Formspree's Privacy Policy](https://formspree.io/legal/privacy-policy/).

**Current Privacy Page:** `credits-privacy.md` (should be updated)

### Email Security

**Best Practices:**
- Use dedicated email for site contact (not personal)
- Consider alias: `contact@modelling4comfort.uk`
- Set up email forwarding if using alias
- Monitor Formspree dashboard for suspicious patterns

**Avoid:**
- Displaying email address directly on site (scraping risk)
- Using `mailto:` links (spam target)
- Auto-forwarding to multiple addresses (privacy leak)

---

## Alternative Options

If Formspree doesn't meet your needs, consider these alternatives:

### 1. Netlify Forms
**Best for:** Sites hosted on Netlify
- Similar to Formspree
- Free tier: 100 submissions/month
- Built-in spam filtering
- **Requires:** Hosting on Netlify (not GitHub Pages)

### 2. Getform
**Best for:** More submissions needed
- Free tier: 50 submissions/month
- Paid: $9/month for 10,000 submissions
- Similar feature set to Formspree
- **Website:** https://getform.io

### 3. FormSubmit
**Best for:** Completely free option
- Unlimited submissions (with ads in emails)
- No registration required
- Less features than Formspree
- **Website:** https://formsubmit.co

### 4. Basin
**Best for:** Privacy-focused
- Open-source alternative
- Self-hostable
- More technical setup
- **Website:** https://usebasin.com

### 5. Return to Commenting Systems

**Giscus (GitHub Discussions):**
- Public comment threads
- Requires GitHub account
- Privacy concerns (GitHub tracking)

**Utterances (GitHub Issues):**
- Lightweight
- Requires GitHub account
- Limited formatting

**Best for:** Community discussion, public engagement

---

## Maintenance Checklist

### Monthly
- [ ] Check Formspree dashboard for submissions
- [ ] Verify email notifications working
- [ ] Review spam folder for false positives
- [ ] Check free tier quota usage

### Quarterly
- [ ] Test form submission from live site
- [ ] Review CTA text for clarity
- [ ] Check analytics for feedback page visits
- [ ] Update privacy policy if needed

### Annually
- [ ] Review Formspree pricing/features
- [ ] Consider alternative services if needed
- [ ] Archive old submissions (CSV export)
- [ ] Update this documentation

---

## Quick Reference

### Enable CTA on Page
```yaml
comments: true
```

### Form Endpoint
```
https://formspree.io/f/mwpggoqz
```

### Dashboard URL
```
https://formspree.io/forms/mwpggoqz/submissions
```

### Key Files
- `feedback.md` - Contact form page
- `_includes/comments.html` - CTA template
- `_layouts/project.html` - Project template
- `_layouts/build.html` - Build log template
- `assets/css/main.css` - CTA styling

### Key CSS Classes
- `.feedback-form` - Form container
- `.build-feedback` - Build log CTA
- `.project-feedback` - Project CTA
- `.form-group` - Form field wrapper

---

## Resources

- **Formspree Documentation:** https://help.formspree.io/
- **Formspree Privacy Policy:** https://formspree.io/legal/privacy-policy/
- **HTML Form Guide:** https://developer.mozilla.org/en-US/docs/Learn/Forms
- **GDPR Compliance:** https://gdpr.eu/
- **Email Best Practices:** https://www.emailonacid.com/blog/article/email-development/

---

*Last Updated: December 17, 2025*
*Version: 1.0*
*Formspree Form ID: mwpggoqz*
