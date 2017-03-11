---
title: hexo github blog
date: 2017-03-11 22:48:50
tags:
 - hexo
 - github
 - blog
---

直接贴脚本

```sh
mkdir hexo

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

两个配置文件：
1, yourdir/_config.yml: 这个是hexo的配置文件，包括使用哪个主题，这里我们使用next，就需要在该配置中设置
2, themes/next/_config.yml: 这个是主题相关的配置，包括页面布局，第三方评论统计接口等等，看看就明白了～


