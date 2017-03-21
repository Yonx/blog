---
title: PDNS系统设计实现总结（on going）
date: 2017-03-13 21:45:40
tags:
 - PDNS 
 - DNS 
---

# 数据采集点的区别

数据分析的前提是要懂数据，懂数据的前提就是要知道数据从哪来，是什么样子的，从而可以知道对于得到的数据，那些能做，哪些不能做。不同的采集点，采集到的数据不一样，量有大小的区别，覆盖范围有区别，可以提取出来的特征不一样，因此对于既定的分析目标，可能一个采集点的数据可以轻而易举的完成，而另外一个采集点可能做起来会非常费力，甚或天然的就无法做到。

![](/2017/03/13/pdns-process-notes/pdns.frame.png)
> 由于懒，我直接抠我在FloCon2017上的talk的PPT的一页来说明。

上图是一个最简单的DNS请求的全路径。一个用户在运营商提供的一个子网内，通过运营商提供的NAT IP发起DNS请求到一个OpenResolver／RecursiveServer，OpenResolver/RecursiveServer 负责完整的递归查询，将最终的IP返回给用户

## authority server 边界

## open resolver 之上

## open resolver 之下

## 路由器边界


# 基本架构／数据流

## 接入

## PDNS system

## cross-access system

## real-time data query system

## real-time analysis system


# 接入点处理

## 应对超大量数据

## 数据分割

## disposable domain

## 去重

## “阶梯”采样


# 实时分析处理

## 归一化及数据预处理

## 域名请求量统计

## spike 判定

## domain profile

## client profile

## DNS server profile

## 特征选择

## 随机程度的度量：熵？


# 其他

## 日志系统

## 打点统计

## 分发缓存






