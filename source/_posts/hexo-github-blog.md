---
title: 使用[hexo + github + next]来构建个人博客
date: 2017-03-11 22:48:50
tags:
 - hexo
 - github
---


博客已经过时许久，不过我年纪渐长，记性渐差，还是需要个这么个东西来记录。
之前blog是在自己的vps，不过时不时被gfw干掉，操作不便，学习了下当今潮流，发现hexo+github+next半天就可以搞定，而且足够满足我的需求，于是搞起。

* hexo；一个基于node的静态博客生成发布引擎，简单来说，就是用户只用写markdown的文稿，后续生成页面、渲染、发布的过程都由hexo来搞定的
* github：实际是github的page，静态博客的载体，hexo会将内容发布到用户自己github的page，然后通过page来查看。如果有自己的域名，也可以cname到自己的github的page，这样就能通过自己的域名来访问。
* next：只是依赖hexo框架的一个主题样式，比较漂亮，而且还提供根据markdown的标题自动生成outline等辅助功能。


### hexo的环境配置
直接贴脚本

```sh
mkdir your.dir
cd your.dir

npm install hexo-cli --save
npm install hexo --save

hexo init

npm install hexo-generator-index --save
npm install hexo-generator-archive --save
npm install hexo-generator-category --save
npm install hexo-generator-tag --save
npm install hexo-server --save
npm install hexo-deployer-git --save
npm install hexo-deployer-heroku --save
npm install hexo-deployer-rsync --save
npm install hexo-deployer-openshift --save
npm install hexo-renderer-marked@0.2 --save
npm install hexo-renderer-stylus@0.2 --save
npm install hexo-generator-feed@1 --save
npm install hexo-generator-sitemap@1 --save
npm install hexo-util --save
npm install hexo-generator-searchdb --save

git clone https://github.com/iissnan/hexo-theme-next themes/next

cd themes/next
npm install
npm install -g bower
npm install -g grunt-cli
cd -
```

此时，如果所有安装都没有意外，执行 hexo server 就可以启动http服务器在本机4000端口，有一个默认的hello world的主页面

### 省略github的配置以及github page的部署过程
### 省略自己域名 到 github page的映射过程

### hexo 配置
两个配置文件：
1, yourdir/_config.yml: 这个是hexo的配置文件，包括使用哪个主题，这里我们使用next，就需要在该配置中设置。同时，还需要在这里配置要同步到的github page的地址。
2, yourdir/themes/next/_config.yml: 这个是主题相关的配置，包括页面布局，第三方评论统计接口等等，看看就明白了
3, 我的配置参见：https://github.com/xuy1202/blog

注意：
    hexo deploy 的时候，是从source文件夹生成为public，然后上传到github。而自己的域名绑定到xxx.github.io的时候，xxx.github.io下面第一级必须有一个CNAME文件对应为自己的域名。所以，必须将对应的CNAME文件放到source一份，这样才能保证每次deploy之后，从自己域名转到github的访问是正确的。


