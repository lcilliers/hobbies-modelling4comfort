# Voice & Tone Audit - Overly Formal Language to Remove
**Date:** January 4, 2026  
**Purpose:** Identify and fix remnants of professional/perfectionistic language that doesn't match authentic beginner journey

---

## The Problem

While we've updated builds.md and techniques.md to authentic voice, many pages still have:
- Overly formal, professional-sounding language
- Claims of perfection or mastery
- Structured tutorial-style presentation
- "Comprehensive" and "meticulous" descriptions
- Language suggesting expert status
- Over-the-top promotional tone

This doesn't match your reality: retirement journey from zero, learning as you go, imperfect results, doing it for yourself not to impress.

---

## Page-by-Page Analysis

### 1. index.md (Homepage)

#### PROBLEMS FOUND:

❌ **Line 12-13:** "This is about my journey into the world of diorama modeling, scale models, and miniature craftsmanship."
- "Craftsmanship" sounds too professional

❌ **Line 18:** "With the help of Co-Pilot using Claude Sonnet 4.5 I present you with my passion..."
- "I present you with" is overly formal
- Sounds like professional presentation

❌ **Line 36:** "Browse through my models and diorama builds and see the creative process unfold."
- "Creative process unfold" sounds polished/promotional

#### RECOMMEND KEEPING:
✅ "What I am showing is from the real world - it is not necessarily the best, or the only way. Attempts, flaws, and errors are all included. I am a novice, and it shows."
- This is perfect - honest and real

#### PROPOSED FIXES:

```markdown
## Welcome

I started building models just a few years ago in retirement, and this site is where I document what I'm learning along the way. Projects here are actively worked on—you'll see work in progress, experiments, and plenty of trial and error.

<div class="feature-image">
  <img src="{{ '/assets/images/models4comfort_deco.jpeg' | relative_url }}" alt="Model Building">
</div>

## About This Site

Built with help from GitHub Copilot using Claude Sonnet 4.5, this is where I keep track of my modeling experiments. It started with accidentally building a kit meant for my grandson, and spiraled into a whole new retirement focus that brings me a lot of joy.

Here's what you'll find:

- **[Projects]({{ '/projects/' | relative_url }})**: What I've built, both finished and still working on
- **[Build Logs]({{ '/builds/' | relative_url }})**: Documenting the actual build process with all the mistakes and adjustments
- **[Techniques]({{ '/techniques/' | relative_url }})**: Methods I've stumbled upon and things I'm still figuring out
- **[About]({{ '/about/' | relative_url }})**: Why I started this journey and what keeps me going

**Reality check:** What you see here isn't necessarily the best way or the only way. Attempts, flaws, and errors are all included. I'm a novice, and it shows. The journey itself is my joy and the learning never stops.

## Recent Projects

Here's what I've been working on—scratch builds are my focus since I love problem-solving and figuring things out as I go.
```

---

### 2. about.md

#### PROBLEMS FOUND:

❌ **Line 15:** "This site documents my passion for creating miniature worlds"
- Too poetic/promotional

❌ **Line 73-75:** "I have always struggled with attention to detail, and doing things to perfection."
- Good honesty BUT then contradicted by later claims

❌ **Line 89:** "By documenting them online, I create a permanent record of the process"
- Sounds too formal/archival

❌ **Line 93:** "The modeling community is incredibly generous with knowledge."
- Generic community statement

❌ **Line 99:** "Public documentation creates gentle accountability."
- Corporate-speak

❌ **Technical Side section:** Way too technical/formal - lists tools like you're running a professional operation

#### WHAT'S GOOD:
✅ "In many respects, my journey to modelling is unlike other modelers: I did not start young..."
✅ "It all started with trying to solve a problem I created for my grandson"
✅ "I am improving every time"

#### PROPOSED MAJOR REVISION:

```markdown
## The Story Behind Models4Comfort

I discovered I enjoy building models quite recently—in 2020. It happened alongside searching for things to keep me focused in retirement after a very busy working career. I only started photographing my build steps in 2022 during the SS Great Britain build. By December 2025 I'd simply run out of physical shelf space and some models had found new homes, so I started organizing everything into this website—a digital show cabinet of what I've attempted.

20 years ago, the name 4Comfort was crafted into the family company. Since then I've had several focuses using the 4Comfort name, most notably Gardens4Comfort.uk. Models4Comfort followed naturally. In essence, building models gives me great joy and comfort. I do it for myself. It's not about competing, showing at exhibitions, running a business, or becoming a guru. This is for my benefit and enjoyment—but you're welcome to share the experience and maybe be inspired.

Each model I build has a story. It preserves a memory, brings an event to life, tackles a technical challenge, or recreates a scene close to my heart.

### Why Models?

When I discovered in 2020 that building models is something I can do indoors at odd hours (especially in winter), it surfaced as something to add to my retirement activities. My main passion is gardening, but that doesn't keep me occupied when it's dark and miserable outside.

My interest in building models is very specific. Although I build occasional kits, they're not my focus. I love problem-solving, reusing materials, and discovering new ways of doing things. My main focus is scratch building—creating most components from scratch and, where possible, from recycled materials.

My projects came about from different angles:

- **Kit building** - Some kits were meant for others to build (Gorch Fock ship, historic Ford car, Simon's Coffee Shop, Cathy's Flower House) and I ended up building them. Some were gifts (Bookshop Memories).
- **Commissions** - A few requested builds (SS Great Britain, dollhouse bunks, Caravaning)
- **Technical challenge** - Most models provide challenges, but some were selected specifically to explore skills (Henrhyd Falls, Cabin in the Woods, Bamboo River Lookout)
- **Passion for plants** - Many feature plants, trees, flowers, nature scenes (Plant Displays, English Country Garden, Traditional Cottage)
- **Restorations** - A few restorations with plans for more (hand-carved Spitfire)

Each project is a chance to learn something new, try a different method, or push what I think I can do.

---

## My Background with Building Things

### Childhood

I watched my older brother build fixed-line balsa wood petrol-driven model planes, but I can't remember building any myself—I simply wasn't good enough for it. I do remember making kites with tissue paper and bamboo.

### Working Life

My studies, career, and work focus were a million miles from hands-on craft work. I did develop a keen interest in DIY projects around the house over time, built up a good tool selection, and consider myself reasonably handy. But I've always struggled with attention to detail and doing things to perfection.

### How This Started

My journey to modeling is probably unlike most modelers: I didn't start young, didn't build up skills with simple kits like aircraft or cars, and didn't see myself as creative or having a flair for art. It started with trying to solve a problem I created for my grandson (buying him a model way beyond his skill level), and with anxiety about what I'd do in winter months when retired and unable to garden.

### What Happened

In the past 5 years I've discovered a different side of myself. I *can* pay attention to detail. I see color in a completely new way. I am creative (who knew?). I love working with all sorts of materials. And I'm improving every time I try something. I'm looking forward to the remaining years.

The [Build Logs]({{ '/builds/' | relative_url }}) document some of these projects, and I'm getting better at the logging process.  
The [Techniques]({{ '/techniques/' | relative_url }}) section captures what I'm discovering—methods, experiments, evolution of skills—for others to learn from or adapt.

---

## Why Put This Online?

### Personal Record

Projects take months or years. Documenting online creates a record I can look back on—photos of stages that would otherwise be lost, notes about what worked (or didn't), and a timeline showing how things improve. A digital collection is also more convenient than a dusty shelf at the back of a room. This is mainly for my own benefit, but you're welcome to browse.

### Sharing What I Learn

I research and discover things constantly by looking at what others share. This site is my way of giving back—sharing what I've learned so others might benefit, avoid my mistakes, or feel inspired to try something new. It also keeps friends and family informed about what I'm up to.

### Keeping Me Accountable

Public documentation creates accountability. I need to think through what I'm doing, remember to photograph it, and keep going. When progress is visible, it motivates me to put more thought into the work.

---

## The Technical Side (How This Site Works)

If you're curious, this site was built using:

- **Jekyll** - Generates static pages (fast and secure)
- **GitHub Pages** - Free hosting with version control
- **Markdown** - Simple way to write content
- **Custom CSS/JavaScript** - Responsive design and image galleries
- **ImageMagick** - Photo optimization

Everything is [open source on GitHub](https://github.com/lcilliers/hobbies-modelling4comfort) if you want to peek at how it works.

---

## Get in Touch

While formal contact isn't set up, you can:

- **Watch the [GitHub repository](https://github.com/lcilliers/hobbies-modelling4comfort)** for updates
- **Reference this work** if you find something useful

### Sharing & Attribution

All content here is shared freely. If you use these techniques or reference this work:

- Attribution is appreciated but not required
- Share your own results—I'd love to see what others create
- Adapt and improve—take these methods further

---

## Thanks for Visiting

Whether you're a fellow modeler, curious about the hobby, or just browsing, thanks for taking an interest. Hope you find something here that inspires, informs, or simply entertains.

---

*This site is a living document, updated as projects progress and new things are learned. Last updated: January 2026*
```

---

### 3. projects.md Intro

#### PROBLEMS FOUND:

❌ **Line 16:** "Each piece represents hours of careful craftsmanship, attention to detail, and creative problem-solving."
- "Careful craftsmanship" is too formal/professional
- "Attention to detail" contradicts your admission of struggling with this

❌ **Line 20:** "Each project page provides a comprehensive overview of the concept, goals, and final results"
- "Comprehensive" is over-promising
- Too structured/formal

#### PROPOSED FIX:

```markdown
Welcome to my collection of modeling projects—dioramas, scratch builds, and kits. Each one represents hours of experimenting, problem-solving, and figuring things out as I go. I love recycling materials and discovering new ways to use them. From maritime vessels to gardens, English cottages to nature scenes, these miniatures each tell a story.

## How to Explore

Each project page shows what I was trying to achieve, how it turned out, and what I learned along the way. For the messy details of how things actually got built (including mistakes and adjustments), check the [Build Logs]({{ '/builds/' | relative_url }}) section where you'll find step-by-step documentation. The [Techniques]({{ '/techniques/' | relative_url }}) section is growing as I document methods worth sharing from these projects.
```

---

### 4. Individual Project Pages (Example: english-country-garden.md)

#### PROBLEMS FOUND:

❌ **Line 40-41:** "The centerpiece is a historic Victorian cottage with an authentic thatched roof, surrounded by a meticulously detailed 15m × 15m garden"
- "Meticulously detailed" is over-the-top

❌ **Line 55:** "Skill Level: Advanced"
- Claims expertise you don't have

❌ **Line 59:** "Given that this model brought together my love for plants and gardens, and my newly discovered focus on scratch building and miniaturization, it came out as a success that I can be proud of."
- Too formal sentence structure

❌ **Line 63:** "Master techniques for creating realistic miniature flowers"
- "Master" claims expertise

❌ **Throughout:** Language like "meticulously," "comprehensive," "mastery"

#### PROPOSED APPROACH:

Change project descriptions from "what I achieved" to "what I attempted" with honest results:

```markdown
## Project Inspiration

After the Log Cabin and Cathy's Flower House, I really wanted to practice making realistic miniature flowers. The first attempts in the Log Cabin showed me I had a lot to learn—better techniques and materials needed. As a keen gardener who loves English country gardens, I couldn't think of a better project to experiment with flower-making than building my own miniature garden from scratch.

This project aimed to capture a traditional English cottage garden. The centerpiece is a Victorian cottage with a thatched roof (something different from the Log Cabin's slate roof), surrounded by a 15m × 15m garden at 1:50 scale.

The main focus was learning techniques for making miniature flowers and plants. The garden ended up with over 100 different plants and several trees—each one a learning experience in capturing what makes each plant recognizable at this scale.

## Project Overview

**Build Type:** Scratch build from research and photos  
**Scale:** 1:50 (1m in reality = 2cm in model)  
**Base:** 30cm × 30cm plywood  
**Garden Size (at scale):** 15m × 15m  
**Status:** Completed  
**Timeline:** April - November 2024 (7.5 months)  
**Experience Level at Start:** Still learning scratch building, first serious attempt at botanical modeling  

## Why This Project?

This brought together my love for plants and my new modeling focus. It turned out well enough that I'm genuinely proud of it. More importantly, it gave me confidence to tackle more scratch-building projects. The enjoyment and satisfaction were remarkable. I'll definitely be selecting more projects to explore different materials, skills, and techniques.

## What I Wanted to Learn

- How to create realistic miniature flowers of many varieties
- Thatched roof construction (different from previous slate work)
- Capturing the informal, densely-planted look of cottage gardens
- Building a Victorian cottage with period details from scratch
- Using whatever materials I had available rather than buying specialty items

## How It Turned Out

Not perfect, but much better than I expected when I started. Some flowers worked brilliantly, others less so. The thatched roof was a challenge. The cottage structure itself taught me a lot about working without formal plans. Would I do things differently now? Absolutely. But that's the point—each project teaches you what to try next time.
```

---

## Summary of Changes Needed

### REMOVE THESE WORDS/PHRASES EVERYWHERE:

❌ Craftsmanship  
❌ Meticulous / Meticulously  
❌ Comprehensive  
❌ Master / Mastery  
❌ Professional  
❌ Expertise / Expert  
❌ Perfection / Perfect (unless saying "not perfect")  
❌ "I present you with"  
❌ "Creative process unfolds"  
❌ "Skill Level: Advanced"  
❌ Formal tutorial language

### REPLACE WITH:

✅ "What I tried"  
✅ "What I learned"  
✅ "Not perfect but..."  
✅ "Still learning"  
✅ "This worked reasonably well"  
✅ "Would do differently next time"  
✅ "First serious attempt at..."  
✅ "Turned out better than expected"  
✅ "Experience level at start: [honest assessment]"

---

## Implementation Priority

### Phase 1 (Immediate - Biggest Impact):
1. ✅ index.md - Homepage sets the tone
2. ✅ about.md - Personal story needs authentic voice
3. ✅ projects.md intro - First thing people see

### Phase 2 (Important):
4. Individual project page intros (first 2-3 paragraphs of each)
5. Project "goals" sections (change "master" to "learn")

### Phase 3 (Polish):
6. Full project page language audit
7. Build log introductions
8. Remove any remaining formal/perfectionistic language

---

## Guiding Principles for All Rewrites

1. **First person, conversational:** "I tried" not "One must"
2. **Honest about imperfections:** Lead with limitations
3. **Focus on learning:** "What I learned" not "What I mastered"
4. **Acknowledge better methods exist:** "My way" not "The way"
5. **Real motivations:** "For my own joy" not "To contribute to the community"
6. **Humble about results:** "Turned out reasonably well" not "Meticulously crafted"

---

## Your Call

Do you want me to:

**Option A:** Implement Phase 1 fixes now (index.md, about.md, projects.md intro)  
**Option B:** Show you specific before/after for each page first for approval  
**Option C:** Do full audit of ALL project pages and fix everything at once  

The changes will make the voice consistently authentic without breaking any functionality. Just removing performative language and replacing with honest, humble descriptions that match your actual journey.

---

*Document created: January 4, 2026*  
*Purpose: Strip away professional veneer, restore authentic beginner voice*
