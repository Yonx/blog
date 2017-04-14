---
comments: false
---


# 徐洋

---

### 基本信息

性别：男
学历：硕士
工作时间：2010.03
电话：158-<a id="phone_number" onclick="$('#phone_number').html('1059');">XXXX</a>-2679
邮箱：xuy1<a id="email_address_2" onclick="$('#email_address_2').html('202@');">XXXX</a>163.com

<!--
xuy1<a id="email_address_1" onclick="$('#email_address_1').html('202@');">XXXX</a>gmail.com
-->


---

### 工作技能
* 大规模数据异常检测方法及实现，各种流量／业务异常检测，DDoS／Scanner等检测方式方法
* TCP/IP，HTTP，DNS等网络协议，及对应数据的分析处理
* 大规模高并发高性能服务及引擎开发维护，基本的WEB前端技术
* ZMQ/QPID等消息队列，socket通信模型
* MySQL等关系型数据库，MongoDB等NoSQL，memcached等KV存储
* Hadoop/HBase/Storm大数据技术方案
* 工作语言：C／C++／Python with Linux

&emsp;&emsp;网络安全&emsp;数据处理&emsp;数据分析&emsp;实时大规模数据引擎设计与开发&emsp;安全工程
&emsp;&emsp;DDoS&emsp;Scanner&emsp;Threat Intelligence&emsp;ZMQ&emsp;Socket&emsp;IP/TCP/UDP&emsp;DNS&emsp;HTTP
&emsp;&emsp;HDFS&emsp;Hadoop&emsp;Hbase&emsp;MongoDB&emsp;MySQL&emsp;C++&emsp;Python&emsp;Rust&emsp;Linux&emsp;shell 

---


### 工作经验

* 2013.04 － Present&emsp;
&emsp;高级安全工程师&emsp;&emsp;奇虎360 - 云引擎/网络安全研究院
* 2012.10 － 2013.04
&emsp;服务端工程师&emsp;&emsp;&emsp;金山云 - 云盘服务端
* 2010.03 － 2012.10
&emsp;软件工程师&emsp;&emsp;&emsp;&emsp;绿盟科技 - 安全中心


---

### 项目经验

##### 2015.01 － Present&emsp;&emsp;<u>  NetFlow实时检测  </u>&emsp;&emsp;奇虎360 - 网络安全研究院

* 对大网汇集的NetFlow数据做实时异常检测，实时检测DDoS攻击/Scanner等各种异常事件
* 数据量：平均 30w/s, 峰值100w/s
* 可调节数据分布处理框架，动态更新的安全规则引擎，方便的扩展数据源以及调整检测策略
* 针对流量数据的特性，采用多层级数据模型／多触发检测的流程模型，以达到更快／更全的异常检测
* 检测攻击包括诸如SYN flood，AMP Flood，UDP Flood，HTTP Flood，DNS Flood等，日均检出50w次
* 检测扫描包括诸如SYN scan等半开放扫描，以及UDP/HTTP scan，暴力破解等，日均活跃scanner 5w个
* -- Linux、C++、Python、ZMQ、protobuf、HBase、MongoDB、Tornado、Nginx

##### 2015.01 － Present&emsp;&emsp;<u>  DNS数据实时分析  </u>&emsp;&emsp;奇虎360 - 网络安全研究院

* 对收集到的DNS数据进行建模分析，构建profile，实时监控各种异常
* 针对不同的异常模式，建立以FQDN／CLIENT／DNS Server不同角度的profile模型
* 实时监控FQDN Spike／RSD Attack/DNS Reflection Attack／DGA Client／DNS Amplifier等异常
* -- Linux、C++、Python、ZMQ、protobuf、HBase、MongoDB、Tornado、Nginx

##### 2014.07 － Present&emsp;&emsp;<u>  PassiveDNS系统  </u>&emsp;&emsp;奇虎360 - 网络安全研究院

* 实时处理被动采集的DNS数据，分发汇聚处理入库，形成pdns数据系统，提供web／command查询
* 数据量：平均 500w/s, 峰值700w/s
* 实时统计各域名的请求，并区分不同请求类型／不同返回类型／不同数据采集点
* 针对离线数据，完成一个快速域名查询集群，可以根据各种各样的查询条件快速检索出对应的域名
* 针对在线数据，完成一个实时domain2ip/ip2domain处理集群，实现域名和IP的快速互查
* -- Linux、C++、Python、ZMQ、protobuf、HBase、Tornado、Nginx

##### 2013.04 － 2014.07&emsp;&emsp;<u> 网盾－上网安全云引擎      </u>&emsp;&emsp;奇虎360 - 核心安全大流程

* 为PC客户端／浏览器／手机提供一个统一的URL黑白鉴定云查接口，保护用户上网安全
* 集成自主黑名单／外部接口／实时规则系统／白名单保护等各类型多层级的数据流程的URL黑白鉴定云服务
* 钓鱼欺诈攻防逻辑升级
* 浏览器照妖镜功能，用户根据需求自主提交网页，从域名／Server IP／网页内容以及关联的多维度做安全鉴定
* 日均请求 250亿＋，且日志作为后端安全数据分析的基础数据，根据各不同产品的不同需求做数据分发
* -- Linux、C++、protobuf、HDFS、Nginx、Storm、Memcached

##### 2013.04 － 2014.07&emsp;&emsp;<u> 综合云引擎服务            </u>&emsp;&emsp;奇虎360 - 核心安全大流程

* 来电秀：手机用户可以设置用户来电profile，并可以举报骚扰用户做后续来电拦截
* 垃圾短信拦截：短信拦截云引擎，根据短信指纹鉴定短信黑白实现提前拦截
* 猜你喜欢：根据用户搜索请求，推荐相关联内容
* 路由器检测：实时集成漏洞信息，判断用户路由器是否有漏洞，是否有可用补丁，并及时通知
* -- Linux、C++、protobuf、HDFS、Nginx、Storm

##### 2012.10 － 2013.04&emsp;&emsp;<u> 企业云盘服务端            </u>&emsp;&emsp;金山云 - 企业云组

* 封装个人云盘原始接口，形成企业云盘后端服务接口，实现个人版和企业版的数据共享和无缝过渡
* 提供企业组织结构管理／权限管理／分享控制等需求功能
* -- Linux、Python、MySQL、Nginx、Uwsgi、Memcached

##### 2011.06 － 2012.10&emsp;&emsp;<u> 招商银行内网流量异常检测  </u>&emsp;&emsp;绿盟科技 - 安全中心

* 分析内网流量数据的属性及整体特征，对流量进行行为建模，找出内网异常流量
* 负责整体系统的设计与分解，确定黑白灰多层次规则匹配模型，设计并实现高速规则匹配引擎
* 实现流量行为 Profile 动态自学习构建，系统可在无监督状态自动生成初始规则
* -- Python、Postgresql;

##### 2010.12 － 2011.12&emsp;&emsp;<u> 银河证券交易异常检测      </u>&emsp;&emsp;绿盟科技 - 安全中心

* 对客户用户登录数据及业务数据进行分析建模，确定异常检测策略以期找出异常行为
* 负责整体功能的设计与分解 设计并实现数据属性、态势、模式多种异常
* 针对数据时间及 IP 维度的多变属性,实现动态调整的规则自学习算法
* -- Python、MongoDB、SQLite

##### 2010.06 － 2012.10&emsp;&emsp;<u> EPS终端防护               </u>&emsp;&emsp;绿盟科技 - 安全中心

* 企业级内网工作终端的统一安全监管
* 产品 Server 端服务开发主程，负责整体性能调优
* 设计并完成软件分发控制、认证管理、资产收集管理等功能
* -- Python、QPID、PHP、Postgresql

##### 2010.06 － 2012.10&emsp;&emsp;<u> SOC                       </u>&emsp;&emsp;绿盟科技 - 安全中心

* 为所有安全设备提供统一管理支持及日志集中分析展示
* 同各类型安全设备数据通信的后台服务的开发及维护;
* 各级安全设备和安全管理运营平台之间数据传输使用的统一接口的详细设计及实现
* -- Python、QPID、PHP、Postgresql


---


### 教育背景
* 2007.09 － 2010.06
&emsp;管理科学与工程 - 硕士&emsp;&emsp;&emsp;&emsp;中国农业科学院 - 信息所
* 2003.09 － 2007.06
&emsp;信息管理与信息系统 - 学士&emsp;&emsp;山东大学 - 管理学院


---

### 其他

* 专利: 用于无线终端访问应用时的注册方法、装置及系统 | 第二发明人(已授权)
* 专利: 一种数据处理方法及装置 | 第一发明人(已授权)
* 专利: 交易数据检测方法、装置及服务器 | 第二发明人(已授权)
* 演讲: Backbone Network DRDoS Attack Monitoring and Analysis  -  Flocon2017, San Diego, CA USA
* 演讲: Backbone Network Security Visibility In Practice       -  BsidesDE2016, Delaware, USA


