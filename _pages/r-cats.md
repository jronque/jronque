---
layout: single
title: r-cats
permalink: /r-cats/
---

<!-- Map and flatten -->
{% assign recipes_cats =  site.recipes | map: 'categories' | join: ',' | join: ',' | split: ',' | uniq | sort %}
<h2>Cats raw: {{ recipes_cats | join: "," | prepend: "[" | append: "]" }}</h2>

{% assign recipes_tags =  site.recipes | map: 'tags' | join: ',' | join: ',' | split: ',' | uniq | sort %}
<h2>Tags raw: {{ recipes_tags | join: "," | prepend: "[" | append: "]" }}</h2>

{% assign combo = recipes_cats | concat: recipes_tags | uniq | sort %}
<h2>Combo: {{ combo | join: "," | prepend: "[" | append: "]" }}</h2>

All recipes in alphabetical order

{% assign doclist = site.recipes | sort: 'title'  %}
<ol>
{% for item in doclist %}
    <li><a href="{{ item.url }}" alt="{{ item.title }}">{{ item.title }}</a></li>
{% endfor %}
</ol>
