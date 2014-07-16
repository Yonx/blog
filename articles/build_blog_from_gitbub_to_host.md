
## 怎么依托github创建自己的静态博客

---

github不仅是一个优秀的代码共享管理平台，还支持markdown语法，因此可以很方便的来写技术文章。
如果还有一个vps，那直接将github上的的.md文档同步过去，然后转成.html文件挂在webservice下面，以后直接在github上提交，
自动同步为vps上的文章，太方便了。

下面就是方法，简单分为三步: 


---

#### 1. vps上启动nginx服务

其实只是需要一个支持静态文件的webserver，还可以用apache uwsgi甚至python -m SimpleHTTPServer

```
$ yum install pcre pcre-devel
$ yum install zlib zlib-devel
$ wget http://nginx.org/download/nginx-1.6.0.tar.gz
$ tar -xvf nginx-1.6.0.tar.gz
$ cd nginx-1.6.0
$ ./configure
$ make
$ make install
```
* nginx 依赖 pcre zlib, 所以需要安装对应的库；
* nginx 安装后默认路径是/usr/local/nginx/，可以在./configure --prefix=/install/path/your/like/来修改

```
$ vim /usr/local/nginx/conf/nginx.conf
```

将如下location配置添加到server配置中

```C
    location ~ ^/blog/ {
        root /home/xuamao/;   // 文件根路径
        index README.html;    // 默认的index文件
        expires 1d;           // 失效时间，静态文件变化很少，因此可以设置较长
    }
```

* 这里设定了我们访问的url路径必须是/blog/*.html, 而文件存放的根路径是/home/xuamao/


#### 2. 从github同步数据并生成html
* 假定你已经有了一个github账户，并且已经有了一个blog的仓库，如果这都没有，你就看个热闹吧

```
$ easy_install markdown   // python-markdown，用于将.md文件转为.html
$ easy_install xhtml2pdf  // 用于将.html转为.pbd, 可选
$ cd /home/xuamao/
$ git clone git@github.com:Yonx/blog.git
```
* 此时，github的blog仓库已经同步到/home/xuamao/目录下

```
crontab -e
```
设置如下cron周期任务
```c
*/1 * * * * cd /home/xuamao/ && git pull && make html -C /home/xuamao/blog/
```

* 这里是每分钟执行一次, 先将github上的最新数据pull下来，然后将.md 转为 .html
* make的过程看Makefile


#### 3. 设置样式表

前两步只是数据流通了，在github上看会有默认的css来控制展现格式，但是到你主机的.md生成的.html没有任何样式，只是原生的html，因此需要设置自己的样式表

markdown生成html的样式表已经有好多，可以找自己喜欢的来用，当然如果喜欢，可以自己做一份自己的。我懒，所以直接拿来。

顺便说句，一个技术人员如果不觉得baidu难用，技术能力是可疑的！


```
cd /home/xuamao/blog/
git clone https://github.com/jasonm23/markdown-css-themes.git
```

* 这样，blog文件夹下就有一个markdown-css-themes文件夹，里面有多个样式表可以选择使用。感谢原作者。
* 使用什么样式，直接定义在header.html中，然后header.html content footer.html的顺序来生成最终的.html页面，具体看Makefile
* 有了header.html和footer.html，其实还可以做好多东西，可以用JS来控制动态的展现或者添加页面内控制的动作等


---

至此，数据流就已经通了，给你的vps绑定个域名，直接在github上写文章就可以准实时同步展示在你的网站上了。



