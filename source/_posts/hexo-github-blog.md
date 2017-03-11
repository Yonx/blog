---
title: using [hexo + next + github page] to build a blog
date: 2017-03-11 22:48:50
tags:
 - hexo
 - next
 - github
 - blog
---

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


