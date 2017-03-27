---
title: hexo+next主题的markdown示范样例备忘 
date: 2015-01-01 00:00:00

photos:
 - http://wx3.sinaimg.cn/mw690/6c4e11d1ly1fdwwlmkoehj212w1mc12f.jpg
 - http://wx4.sinaimg.cn/mw690/6c4e11d1ly1fdwwlk2kg9j212w1mcgux.jpg
 - http://wx1.sinaimg.cn/mw690/6c4e11d1ly1fdwwlnrrrhj212w1mc7cg.jpg
---
```markdown
link:
 - http://cybatk.com/   <!-- 修改title的链接 -->

photos:
 - http://wx3.sinaimg.cn/mw690/6c4e11d1ly1fdwwlmkoehj212w1mc12f.jpg
 - http://wx4.sinaimg.cn/mw690/6c4e11d1ly1fdwwlk2kg9j212w1mcgux.jpg
 - http://wx1.sinaimg.cn/mw690/6c4e11d1ly1fdwwlnrrrhj212w1mc7cg.jpg
---
```


{% centerquote %}
这篇blog没有干货，所以一上来就得有点趣味
{% endcenterquote %}
```markdown
{% centerquote %}
这篇blog没有干货，所以一上来就得有点趣味
{% endcenterquote %}
```


{% fullimage https://umbrella.cisco.com/blog/wp-content/themes/umbrella-blog/img/default/ArticleImage_11_banner.jpg, alttttttttt, titttttttttttle %}
```markdown
{% fullimage https://umbrella.cisco.com/blog/wp-content/themes/umbrella-blog/img/default/ArticleImage_11_banner.jpg, alttttttttt, titttttttttttle %}
```



{% blockquote @xuy1202 https://hexo.io/docs/tag-plugins.html %}
!!!: hexo tag doc 
{% endblockquote %}

---

{% blockquote David Levithan, Wide Awake %}
Do not just seek happiness for yourself. Seek happiness for all. Through kindness. Through mercy.
{% endblockquote %}

---

{% blockquote Seth Godin http://sethgodin.typepad.com/seths_blog/2009/07/welcome-to-island-marketing.html Welcome to Island Marketing %}
Every interaction is both precious and an opportunity to delight.
{% endblockquote %}

---

{% blockquote %}
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque hendrerit lacus ut purus iaculis feugiat. Sed nec tempor elit, quis aliquam neque. Curabitur sed diam eget dolor fermentum semper at eu lorem.
{% endblockquote %}


Head1
===

This is an H2
---

Head2
===

## sub title

## sub title

> This is a blockquote with two paragraphs. Lorem ipsum dolor sit amet,
> consectetuer adipiscing elit. Aliquam hendrerit mi posuere lectus.
> Vestibulum enim wisi, viverra nec, fringilla in, laoreet vitae, risus.

{% note default %} default {% endnote %}
{% note primary %} primary {% endnote %}
{% note success %} success {% endnote %}
{% note info    %} info    {% endnote %}
{% note warning %} warning {% endnote %}
{% note danger  %} danger  {% endnote %}


```markdown
{% note default %} default {% endnote %}
{% note primary %} primary {% endnote %}
{% note success %} success {% endnote %}
{% note info    %} info    {% endnote %}
{% note warning %} warning {% endnote %}
{% note danger  %} danger  {% endnote %}
```


<!--
![](/images/touxiang.jpg)
{% fullimage /images/touxiang.jpg, alt, title %}
-->



