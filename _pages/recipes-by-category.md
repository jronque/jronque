---
layout: collection
title: Recipes by cat
permalink: /recipes-by-cat/
---

{% include group-by-array collection=site.recipes field='categories' %}

<ul>
  {% for cat in group_names %}
    {% assign posts = group_items[forloop.index0] %}

    <li>
      <h2>{{ cat }}</h2>
      <ul>
        {% for post in posts %}
        <li>
          <a href='{{ site.baseurl }}{{ post.url }}'>{{ post.title }}</a>
        </li>
        {% endfor %}
      </ul>
    </li>
  {% endfor %}
</ul>