---
layout: build
title: "SS Great Britain - Sails & Rigging"
date: 2022-04-15
project: /projects/ss-great-britain/
project_name: "SS Great Britain"
build_number: "#004"
step: 4
previous_step: /builds/ss-great-britain/003-decking/
previous_step_title: "Decking"
next_step: /builds/ss-great-britain/005-decoration/
next_step_title: "Decoration"
categories: [ships, rigging]
tags: [sails, rigging, masts, detail-work]
excerpt: "Complex rigging work including six masts, sails, and associated lines and details."
build_log_menu:
  - number: "#001"
    title: "Planning & Research"
    url: /builds/ss-great-britain/001-planning-research/
  - number: "#002"
    title: "Hull Construction"
    url: /builds/ss-great-britain/002-hull-construction/
  - number: "#003"
    title: "Decking"
    url: /builds/ss-great-britain/003-decking/
  - number: "#004"
    title: "Sails & Rigging"
    url: /builds/ss-great-britain/004-sails-and-rigging/
  - number: "#005"
    title: "Decoration"
    url: /builds/ss-great-britain/005-decoration/
---

With the masts up, and the and all the rope eyelits on the deck and the masts, the sails and rigging had to be figured out.  Without the example of the Gorch Fock around I would have not figured it out.  Sail cloth is sourced and the layout and measurements of all the sails cut out of paper, 15 in total. Without a sowing machine, the seams of the sails were all glued in with cloth material glue.

## Sails and rigging

<div class="image-row-3">
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-028.jpg' | relative_url }}" alt="templates of sails">
    <div class="caption">templates of all the different sails designed and shaped and pinned to cloth</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-029.jpg' | relative_url }}" alt="transfer of cutting lines">
    <div class="caption">the cutting lines are transferred to the sail cloth with carbon paper</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-038.jpg' | relative_url }}" alt="first sails">
    <div class="caption">starting at the front, the first sails go up</div>
  </div>
</div>

The rope ladders were knotted individually. Research helped to uncover the design of a handy tool to keep the rope tight and allow for tying all the knots.

<div class="image-row-3">
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-041.jpg' | relative_url }}" alt="rope ladder tool">
    <div class="caption">5 or 6 ropes are tied together and then kept apart with the nails to provide even spaces for the ladder effect. </div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-040.jpg' | relative_url }}" alt="rope ladders">
    <div class="caption">the rope ladders are then installed from the eyelids on deck to the top.</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-036.jpg' | relative_url }}" alt="remaining sails">
    <div class="caption">the remainder of the sails go up</div>
  </div>
</div>

Installing the sails, rigging and tackle were a sigificant challenge. I bought and made several tools to help, including dressmaking scissors, crochet needles, sail cloth, green cotton string for the tackle and white cotton string for the ropes. The pullies was particularly difficult to manufacture due to its small size and drilling the 1 mm holes, get the rope trough it and tying to pullies to the masts presented much practice in miniature work under magnifiers.  Patience and endurance were discovered in places where I did not think it existed.

Finalinally the completed ship was ready for final decoration and completion.

## SS Great Britain Build Logs

{% assign project_logs = site.builds | where: 'project', 'ss-great-britain' | sort: 'date' %}

{% for log in project_logs %}
- **[{{ log.title }}]({{ log.url | relative_url }})**  
  *{{ log.date | date: "%B %d, %Y" }}* - {{ log.excerpt }}
{% endfor %}



