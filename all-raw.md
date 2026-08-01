---
layout: none
permalink: /all-raw.md
---
# Akash Kulgod - All Writings (plain text)

{% for post in site.posts %}
## {{ post.title }}
{{ post.date | date: "%B %d, %Y" }}{% if post.categories.size > 0 %} · {{ post.categories | join: ", " }}{% endif %}

{{ post.content | strip_html }}

---

{% endfor %}
