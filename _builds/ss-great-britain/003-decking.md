---
layout: post
title: "Ss Great Britain - Build Log : Decking"
date: 2022-03-13
project: ss-great-britain
build_number: #003
categories: [ships, construction]
tags: [decking, detail-work]
excerpt: "Deck construction and detailing work including planking, hatches, structural details and masts."
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
    <div class="caption">fixing the rim to in stages</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-022.jpg' | relative_url }}" alt="outer skin of hull">
    <div class="caption">finished skin</div>
  </div>
</div>

<div class="image-row-3">
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-021.jpg' | relative_url }}" alt="filling the hull">
    <div class="caption">hull filed with sawdust and glue and beer cans used for the skin.</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-023.jpg' | relative_url }}" alt="glueing the hull">
    <div class="caption">glueing the sheets of beer cans</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-024.jpg' | relative_url }}" alt="outer skin of hull">
    <div class="caption">finished skin</div>
  </div>
</div>

<div class="image-row-3">
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-026.jpg' | relative_url }}" alt="filling the hull">
    <div class="caption">hull filed with sawdust and glue and beer cans used for the skin.</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-032.jpg' | relative_url }}" alt="glueing the hull">
    <div class="caption">glueing the sheets of beer cans</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-033.jpg' | relative_url }}" alt="outer skin of hull">
    <div class="caption">finished skin</div>
  </div>
</div>

<div class="image-row-3">
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-034.jpg' | relative_url }}" alt="filling the hull">
    <div class="caption">hull filed with sawdust and glue and beer cans used for the skin.</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-035.jpg' | relative_url }}" alt="glueing the hull">
    <div class="caption">glueing the sheets of beer cans</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-033.jpg' | relative_url }}" alt="outer skin of hull">
    <div class="caption">finished skin</div>
  </div>
</div>


## SS Great Britain Build Logs

{% assign project_logs = site.builds | where: 'project', 'ss-great-britain' | sort: 'date' %}

{% for log in project_logs %}
- **[{{ log.title }}]({{ log.url | relative_url }})**  
  *{{ log.date | date: "%B %d, %Y" }}* - {{ log.excerpt }}
{% endfor %}
