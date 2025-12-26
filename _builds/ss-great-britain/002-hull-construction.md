---
layout: build
title: "SS Great Britain - Hull Construction"
date: 2022-02-10
project: /projects/ss-great-britain/
project_name: "SS Great Britain"
build_number: "#002"
step: 2
previous_step: /builds/ss-great-britain/001-planning-research/
previous_step_title: "Planning & Research"
next_step: /builds/ss-great-britain/003-decking/
next_step_title: "Decking"
categories: [ships, construction]
tags: [hull, iron-plating, assembly]
excerpt: "Hull construction phase - assembling the iron hull and adding structural details."
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

Getting started with the actual build commenced with calculating the base measurements. I got most of the key measurements from the [Wikipedia article on SS Great Britain](https://en.wikipedia.org/wiki/SS_Great_Britain).  Most of the detail measurements were gathered from other pictures and calculated based on the length of the ship in the picture.  

## Dimensions and Scale

**Scale: 1:300** (calculated from actual model measurements)

| Measurement              | Real Ship (ft) | Model (cm) | Model (mm) |
|--------------------------|---------------:|-----------:|-----------:|
| Length (w/o bowsprit)    | 322.00         | 33.00      | 330.00     |
| Beam (width)             | 50.50          | 5.50       | 55.00      |
| Chimney height           | 8.00           | 6.50       | 65.00      |
| Main sail height (deck)  | -              | 18.00      | 180.00     |
| Bulkhead to bulkhead     | 25.00          | 2.57       | 25.70      |
| Height (deck to keel)    | 32.50          | 3.34       | 33.40      |
| Propeller diameter       | 15.50          | 1.59       | 15.90      |

## The hull framework

Initially I searched the internet to see if I can find a plastic hull, similar to the Gorch Fock that I built, but this turned out to be fruitless.  I really wanted to present the hull with material that will celebrate the significance that this was the first intercontinental steel hull ship.

<div style="float: left; max-width: 30%; margin-right: 20px;">
  <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-001.jpg' | relative_url }}" alt="drafting the hull" style="width: 100%;">
  <div class="caption" style="font-style: italic; font-size: 0.9em; text-align: center; margin-top: 5px;">Derived from the guides, the first hull layout</div>
</div>
<div style="text-align: left; padding-top: 10px;">
With the length and the beam, I then proceeded to draft the deck and the hull framework.  Personally, I have a big shortccoming, in that I never learnt to do proper drawings, and just had to resort to trial and error, pen and paper, and cutting the forms out of paper to visually confirm the layout.  Not ideal, but it was a good starting point.

Using a paper model I attempted to visualise the taper of the hull, and proceded to use a mixture of pinewood and balsawood to form the deck and main ridge.  The ribs were added to prepare for forming the metal sheeting over the ribs. The ribs did not work well, and I replaced it by forming the hull in processive sheets of balsawood.

</div>

<div class="image-row-3">
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-011.jpg' | relative_url }}" alt="main ridge">
    <div class="caption">first parts of the deck frame</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-006.jpg' | relative_url }}" alt="ribs for the hull">
    <div class="caption">ribs added to form the tapering</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-013.jpg' | relative_url }}" alt="tapering with layers">
    <div class="caption">replacing ribs with balsawood layers</div>
  </div>
</div>

The core of the hull was filled with sawdust and glue, ready for the steel hull.  Beer cans turned out to have just the right thickness of steel to proceed with the forming of the outer skin. Strips of beer cans were then glued in place with superglue. 

<div class="image-row-3">
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-014.jpg' | relative_url }}" alt="filling the hull">
    <div class="caption">hull filed with sawdust and glue and beer cans used for the skin.</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-016.jpg' | relative_url }}" alt="glueing the hull">
    <div class="caption">glueing the sheets of beer cans</div>
  </div>
  <div>
    <img src="{{ 'assets/images/builds/ss-great-britain/ss-great-britain-build-017.jpg' | relative_url }}" alt="outer skin of hull">
    <div class="caption">finished skin</div>
  </div>
</div>

<div class="clear"></div>

## SS Great Britain Build Logs

{% assign project_logs = site.builds | where: 'project', 'ss-great-britain' | sort: 'date' %}

{% for log in project_logs %}
- **[{{ log.title }}]({{ log.url | relative_url }})**  
  *{{ log.date | date: "%B %d, %Y" }}* - {{ log.excerpt }}
{% endfor %}


---

