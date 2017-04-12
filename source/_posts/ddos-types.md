---
title: DDoS Types
date: 2016-05-12 18:27:12
tags:
 - DDoS
 - network security
---

网上DDoS攻击类型的说明七零八落，没有一个成体系的类型划分。DDoS攻击，目的都是毁掉“可用性”，那第一考量维度应该就是毁掉的“可用性资源”是什么。其次，攻击发起的位置，也就是协议层次，很重要，这决定了，我们在什么样的位置可以更好的发现对应类型的攻击。任何一个DDoS攻击，一定要能说明白这两个问题，才能说“看到了”这个攻击。

因此，做个表格，从如下两个维度来给常见的DDoS一个合适的位置
* 协议层次: 各种不同网络层级的不同协议
* 耗费的资源: 带宽，CPU，还是连接，甚或是特定应用的特定弱点？


|  LayerProto \ Resources | Bindwidth | CPU | Session/Connection | Application Specified Weakness |
| ---------------------   |:----------:|----:|---:|--------:|
| GRE                     | GRE_Flood | GRE_Flood | | |
| ICMP                    | Ping_Flood; Smurf_Attack | | | Ping_of_Death |
| UDP                     | AMP_Flood; UDP_Plain; Fraggle_Attack | UDP_Plain; Small_Package_Flood | | |
| TCP                     | SYN_Flood; ACK_Flood | ACK_Flood | SYN_Flood; Slow_Read_Attack; | Teardrop_Attack |
| DNS                     | DNS_Flood; RSD_Attack| DNS_Flood; RSD_Attack | | |
| HTTP                    | | CC_Flood; SSL_Flood | Slowloris; RUDY | CC_Flood; SSL_Flood  |
| VoIP                    | | | | INVITE_of_Death |


一句话注释：
* AMP_Flood: 反射放大，DNS/NTP/CharGen等等，伪造源IP为受害者IP，发送请求流量到反射节点，响应流量就涌向受害者IP，响应包大小远大于请求包大小，是为“放大”
* SYN_Flood: 半连接状态，受害者协议栈需要保存大量状态信息，同时，很多会带有payload，顺道消耗带宽
* UDP_Plain: 大量UDP包瞬间发往目的IP，阻塞目的链路，包一般很大，当前存在两组攻击者，一组喜欢填充500字节左右，一组喜欢填充1k以上，也有超过1500的，会导致产生0端口Fregment碎片
* Small_Package_Flood: 类似UDP_Plain, 不过包一般很小，基本都在50字节以下
* ACK_Flood: TCP版本的UDP_Plain, 包大小分布非常相似，但是，除了耗费带宽外，还耗费TCP协议栈针对ack包的的查表操作
* DNS_Flood: 伪造大量DNS请求包，发送给DNS cache 服务器或者DNS权威，以期拖垮DNS服务
* RSD_Attack: 目的类似DNS_Flood，不过攻击手法是伪造大量随机子域名，响应都是NXDOMAIN，因此就算请求到cache服务器，也可以穿透cache服务器的TTL，间接攻击到权威服务器
* CC_Flood: HTTP Flood的别称，具有业务针对性，基本都是找受害者的http响应中最耗费性能的那个链接，比如计算密集的，或者数据库查询比较重的，以此来拖垮服务器
* SSL_Flood: SSL协议协商对计算要求较高，因此大量的SSL连接请求，可以直接将SSL接入服务器CPU耗尽
* GRE_Flood: GRE是封包协议，大量GRE包，一方面可以消耗带宽，一方面可以耗费解包CPU资源
* Ping_Flood: 大量的ping，硬干
* Slowloris: 大量HTTP长连接，GET请求但是永远不发送\r\n结束，耗尽服务端连接池
* RUDY: 类似Slowloris, 不过是通过设置一个超大的content-length header来构造一个永不停止的POST请求，进而耗费目标服务的连接池
* Ping_of_Death: ping的畸形包或者超大包，目标系统重组的时候会由overflow引起的crash
* Smurf_Attack: 伪造源IP为要攻击的目标IP，给广播地址发ping，所有的echo就涌向了受害者IP
* Fraggle_Attack: UDP版本的Smurf, 使用UDP的端口7（echo）和端口19(CharGEN)
* Slow_Read_Attack: 和受害者建立长连接，把TCP receive buffer设置的很小，慢慢读，耗费受害者连接池
* Teardrop_Attack: 利用某些操作系统IP碎片重组的bug来使目标系统crash
* INVITE_of_Death: 构造SIP INVITE畸形请求包来使目标系统crash


上面的分类，是站在“看到攻击”的角度。如果站在“防御攻击”的角度，那下一个DDoS攻击精细化的分类维度应该是“攻击路径”: 是脚本直接发包？还是借助proxy？还是借助反射点？还是通过服务穿透？还是利用Bot？确定了攻击路径，才能找到最合适的防御位置。



