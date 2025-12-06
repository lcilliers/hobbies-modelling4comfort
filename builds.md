---
layout: default
title: Build Logs
permalink: /builds/
published: true  
date: 2025-12-01
---

**[{{title}}]**

Follow along with my diorama projects as they develop from concept to completion. Each build log documents the process, challenges, solutions, and lessons learned along the way.

## What Are Build Logs?

Build logs are detailed progress updates that chronicle the construction of each diorama project. They include:

- **Step-by-step progress** with photos
- **Techniques used** and lessons learned
- **Materials and tools** for each stage
- **Problem-solving** and creative decisions
- **Timeline updates** showing real-world build schedules

---

## Latest Build Updates (Last 10)

{% assign recent_logs = site.builds | sort: 'date' | reverse | limit: 10 %}
{% if recent_logs.size > 0 %}
{% for log in recent_logs %}
**[{{ log.title }}]({{ log.url | relative_url }})**  
*{{ log.date | date: "%B %d, %Y" }}* - {{ log.excerpt }}

{% endfor %}
{% else %}
*No build logs published yet. Check back soon!*
{% endif %}

---

## Build Logs by Project

{% assign projects = site.builds | map: 'project' | uniq | sort %}
{% for project_slug in projects %}
{% assign project_logs = site.builds | where: 'project', project_slug | sort: 'date' %}
{% if project_logs.size > 0 %}

### {{ project_logs.first.project | replace: '-', ' ' | capitalize }}

{% for log in project_logs %}
- **[{{ log.title }}]({{ log.url | relative_url }})**  
  *{{ log.date | date: "%B %d, %Y" }}* - {{ log.excerpt }}
{% endfor %}

{% endif %}
{% endfor %}

---

## What to Expect in Build Logs

### Format

Each build log follows a consistent structure:

1. **Current Stage** - What phase of the build we're in
2. **Work Completed** - What was accomplished since last update
3. **Photo Gallery** - Progress photos with captions
4. **Techniques Used** - Methods and skills applied
5. **Challenges & Solutions** - Problems encountered and how they were solved
6. **Materials & Tools** - What was needed for this stage
7. **Next Steps** - What's coming in the next update
8. **Time Investment** - Approximate hours spent

### Update Frequency

Build logs are posted as projects progress:

- **Major updates** - Significant milestones completed
- **Technique spotlights** - When using interesting new methods
- **Problem-solving** - When overcoming noteworthy challenges
- **Phase completions** - End of hull, rigging, painting, etc.

---

## Subscribe to Updates

Want to be notified when new build logs are posted?

- **Watch the GitHub repository** for new commits
- **Check the site regularly** - new updates typically weekly during active builds
- **Follow the [Projects page]({{ '/projects/' | relative_url }})** to see overall progress

---

## Build Log Template

Planning to document your own projects? Here's the structure I use:

```markdown
---
layout: post
title: "Project Name - Build Log #001"
date: YYYY-MM-DD
project: project-slug
tags: [relevant, tags]
---

## Current Build Stage
Brief overview of current phase

## Work Completed Since Last Update
- Bullet points of accomplishments
- Each major task completed
- Progress highlights

## Photo Gallery
[Images of work completed]

## Techniques Used
- Technique 1: Description
- Technique 2: Description

## Challenges & Solutions
**Challenge:** Description of problem
**Solution:** How it was resolved

## Materials & Tools Used
- Materials list
- Tools required

## Next Steps
- Upcoming tasks
- Goals for next update

## Time Investment
Approximately X hours
```

---

## Tips for Following Build Logs

1. **Start from Build Log #001** for each project to understand the full context
2. **Check the project page** for overall information and status
3. **Explore linked techniques** for detailed how-to guides
4. **Leave comments** (once enabled) to ask questions or share your own experiences

---

## Your Own Build Logs?

Inspired to document your own projects? Here are some tips:

- **Take photos constantly** - You can't go back and photograph earlier stages
- **Write as you go** - Don't wait until the project is done
- **Be honest about mistakes** - They're valuable learning opportunities
- **Note your timing** - Helps others plan similar projects
- **Share your sources** - Help others find the same materials

---

## Related Pages

- **[Projects Gallery]({{ '/projects/' | relative_url }})** - View all diorama projects
- **[Techniques]({{ '/techniques/' | relative_url }})** - Detailed how-to guides
- **[About]({{ '/about/' | relative_url }})** - Learn about this site and my modeling journey

---

*Build logs coming soon! The German Sail Boat series will be the first to be published as the project progresses.*
