---
title: pymongo find操作的limit限制对返回的cursor.count() 默认不生效
date: 2017-04-27 19:47:33
tags:
 - pymongo
 - mongo
---

我们有一个web服务的mongo连接池，对每一个mongo find查询，我们会在日志中记录查询条件及其返回数据的count，从后可以方便的后续定位问题。
最开始使用的count方法是

```python
result = monger.find(cond);
count  = result.count()
```

出问题了，mongo后台记录了很多command: count慢查日志，在有这些慢查的时候，mongo库性能急剧下降，几乎不可用。


排查代码如下：

```python
    print "0x00 len(list(mongor.table.find(cond))) COUNT: ", len(list(mongor.table.find(cond)))
    for i, v in enumerate(mongor.table.find(cond, fields=["types"])):
        print "\t", i, v
    print
    print "0x01 mongor.table.find(cond, limit=1).count() COUNT: ", mongor.table.find(cond, limit=1).count()
    for i, v in enumerate(mongor.table.find(cond, fields=["types"], limit=1)):
        print "\t", i, v
    print
    print "0x02 mongor.table.find(cond).limit(1).count() COUNT: ", mongor.table.find(cond).limit(1).count()
    for i, v in enumerate(mongor.table.find(cond, fields=["types"]).limit(1)):
        print "\t", i, v
    print
    print "0x03 mongor.table.find(cond, limit=1).count(True) COUNT: ", mongor.table.find(cond, limit=1).count(True)
    print
    print "0x04 mongor.table.find(cond).limit(1).count(True) COUNT: ", mongor.table.find(cond).limit(1).count(True)
```

执行结果如下：
```sh
0x00 len(list(mongor.table.find(cond))) COUNT:  2
    0 {u'_id': ObjectId('58fcb2c52d616749494d9cb9'), u'types': u'udp@attack@simple_flood_target'}
    1 {u'_id': ObjectId('58fcb0ef2d616749494d98df'), u'types': u'udp@attack@simple_flood_target'}

0x01 mongor.table.find(cond, limit=1).count() COUNT:  2
    0 {u'_id': ObjectId('58fcb2c52d616749494d9cb9'), u'types': u'udp@attack@simple_flood_target'}

0x02 mongor.table.find(cond).limit(1).count() COUNT:  2
    0 {u'_id': ObjectId('58fcb2c52d616749494d9cb9'), u'types': u'udp@attack@simple_flood_target'}

0x03 mongor.table.find(cond, limit=1).count(True) COUNT:  1

0x04 mongor.table.find(cond).limit(1).count(True) COUNT:  1
```

可以看到
* 0x00 的情况，就是针对结果集数据进行在业务层自己算count，一共两条数据
* 0x01 的情况，limit在find内，对cursor的count不起作用，尽管最终输出一条结果，但是count仍然是2条
* 0x02 的情况，limit在find外，结果同0x01, limit对count不起作用
* 0x03 & 0x04, 不管limit在哪，count的时候，执行加上True参数，limit条件就可以起作用了, True参数对应的是applySkipLimit, 是否考虑skip和limit的影响，默认为False，具体参见 [文档 cursor.count](https://docs.mongodb.com/manual/reference/method/cursor.count/)

因此，我们之前的查询，尽管find的时候设置了limit，但是由于cursor.count(default: False)的存在，仍然相当于把cursor对应的满足条件的所有数据都遍历一遍。假定一个查询条件，库中满足的结果有很多很多，那这个count就带来了慢查，拖慢了整个mongo库。

总结：
* 尽管count提供了applySkipLimit参数，但是默认为False为败笔，因为count在limit之后，这个默认和前后顺序关系逻辑不一致
* 如果结果注定是要返回的，最好就直接对结果集算count，不要用curosr.count()，省一次command: count操作




