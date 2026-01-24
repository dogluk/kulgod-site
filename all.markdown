---
layout: page
title: all writings
permalink: /all/
---

A complete collection of all writings, auto-compiled.

---

{% for post in site.posts %}
## {{ post.title }}

*{{ post.date | date: "%B %d, %Y" }}*{% if post.categories.size > 0 %} · {{ post.categories | join: ", " }}{% endif %}

{{ post.content }}

---

{% endfor %}
