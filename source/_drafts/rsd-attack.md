---
title: RSD 随机子域名攻击 
date: 2017-03-25 17:58:01
tags:
 - RSD
 - DDoS
---

RSD, random sub domain [attack]， 也可称为 PRSD， P for Pseudo，因为所谓的随机数生成算法是“伪随机”。

# 攻击原理 

假定我们想攻击example.com，让其不能正常提供服务，我们可以构造大量的虚假子域名请求，比如:

```sh
aaaaaaa.example.com
aaaaaab.example.com
...
aaaaaaz.example.com
aaaaaba.example.com
...
zzzzzzz.example.com
```

这些FQDN都是构造出来的，真实业务不存在的域名，因此接收到这些请求的公共DNS服务器, 例如 114.114.114.114，会根据请求开始递归请求过程，将上述请求转到 example.com 的权威NS服务器, 例如 ns.example.com。

以上伪造的子域名模式是［a-z］7个字母的定长组合，一共有 26 ** 7 = 8031810176个，想象一下，这么多伪造请求如果在10分钟内发出去，可能发生的事情：

* 公共DNS服务器 114.114.114.114 缓存可能被撑爆，可能无法处理正常请求
* 114.114.114.114 到 ns.example.com 的路由线路中间某节点带宽被占满
* ns.example.com 处理不了如此多的请求，导致无法处理正常请求
* 甚或，到达example.com 的流量只有20G，但是所在IDC认为流量太大，强制将example.com下线来自保（没开玩笑）

这些可能只要满足一个，就有相当大部分或者所有人，在一定时间内都无法正常访问 example.com，攻击成功。

上面伪造请求我用了连续字符串空间的子域名来说明，实际攻击中会用各种随机算法来生成定长／变长的，字母／数字／混合的各种子域名来进行攻击，所以被称为 RSD 。


{% note default %}

另：DNS 请求是基于 UDP 的，UDP 没法验证来源，也就是说 DNS 的请求是可以伪造来源的，如果攻击者伪造子域名请求的来源 IP 为 ns.example.com 的 IP 或者同 IDC 的 IP 会如何？

{% endnote %}


# 攻击现状 


# 实时检测方法


# 防御方法



