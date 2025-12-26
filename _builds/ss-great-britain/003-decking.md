---
layout: build
title: "SS Great Britain - Decking"
date: 2022-03-13
project: /projects/ss-great-britain/
project_name: "SS Great Britain"
build_number: "#003"
step: 3
previous_step: /builds/ss-great-britain/002-hull-construction/
previous_step_title: "Hull Construction"
next_step: /builds/ss-great-britain/004-sails-and-rigging/
next_step_title: "Sails & Rigging"
categories: [ships, construction]
tags: [decking, detail-work]
excerpt: "Deck construction and detailing work including planking, hatches, structural details and masts."
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


With the hull covered with its steel skin, I would turn my attention to the different structures on the deck. I started off by experimenting with crafting the hatches [as illustrated in this reference photo]({{ 'assets/images/builds/ss-great-britain/ss-great-britain-reference-006.jpg' | relative_url }}){:target="_blank"}.

The pinewood deck was planked with thin strips of veneer. The veneer was left over from the previous build.


## preparing the deck

<div class="image-row-3">
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-018.jpg' | relative_url }}" alt="hatch construction">
    <div class="caption">first attempt of hatch making</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-020.jpg' | relative_url }}" alt="rim">
    <div class="caption">fixing the rim in stages around the hull</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-022.jpg' | relative_url }}" alt="clamping the rim">
    <div class="caption">customise the clamping to hold down the rim</div>
  </div>
</div>

I decided to use softer wood to make the remaining hatches for better shaping of the items, and then carved the stairway ports from bayleaf wood found in the garden.  The chimney was made from different sizes of bamboo fitting into each other to represent the bottom rim.  Constructing the top and fitting the two sections of the mast introduced custom bending lots of tiny loops from copper wire.  Just had enough space to fit in the cannons, also carved from scrap wood.

<div class="image-row-3">
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-021.jpg' | relative_url }}" alt="hatches all completed">
    <div class="caption">all the hatches in place and the below deck entrances, all carved from wood out of the garden, is positioned on the deck</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-023.jpg' | relative_url }}" alt="chimney and mainmast">
    <div class="caption">the chimney is made from bamboo sourced in the garden, and the first main mast is dell sticks tapered to the point</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-024.jpg' | relative_url }}" alt="cannons and steering">
    <div class="caption">cannons and steering is positioned at the back</div>
  </div>
</div>

Repeating the process of the first mast, and carefully measuring the proportions of the other masts to the main mast allowed fitting of all the masts in place.  However, first fitting the chimney did result in a grave error.  The chimney should not be in the middle, but between the fourth and fifth mast.  

Multiple small copper and silver wire loops and eyes were made using nails in a piece of wood. The blocks were drilled and the eyes fitted to serve as rope ties for the rigging.

Each mast also had to have multiple eyes fitted for the rigging.  Having the Gorch Fock kit handy helped to size and make the different fittings for the rigging on the deck, masts and tops.  The pullies were made from 3 mm wood strips drilled to fit the lines through. 


<div class="image-row-3">
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-027.jpg' | relative_url }}" alt="masts in place">
    <div class="caption">all six masts in place</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-032.jpg' | relative_url }}" alt="loops and eyes">
    <div class="caption">bending the copper loops and eyes</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-035.jpg' | relative_url }}" alt="eyes in masts">
    <div class="caption">the eyes was fitted in small holes drilled through the masts</div>
  </div>
</div>

Had my first experience of turning the achor chain pulley from wood using a drill. The beer can tin could be used to form the roofs of all the cabins on the deck. It took we a while to work out how to make the railings for the boat. I did not manage to solder it, and finally managed to have small eyes in the wire for the copper posts, and used a bit of super glue to stick it together.

<div class="image-row-3">
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-033.jpg' | relative_url }}" alt="Anchor chain">
    <div class="caption">Anchor chain and bowsprit</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-034.jpg' | relative_url }}" alt="below deck stair cabins">
    <div class="caption">beer can roofs for the below deck stair cabins</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-039.jpg' | relative_url }}" alt="deck railing">
    <div class="caption">deck railings</div>
  </div>
</div>

Many parts of the deck was a first for me to figure out how to approach it, discover or make tools to help with it, trial and error to experiment with different types of material and glue, navigate around my own limitations, and finally to get to something that is directionally right.  Working with a 1:300 scale added to the challenge.

Completing the hull was a major achievement for me.


## SS Great Britain Build Logs

{% assign project_logs = site.builds | where: 'project', 'ss-great-britain' | sort: 'date' %}

{% for log in project_logs %}
- **[{{ log.title }}]({{ log.url | relative_url }})**  
  *{{ log.date | date: "%B %d, %Y" }}* - {{ log.excerpt }}
{% endfor %}
