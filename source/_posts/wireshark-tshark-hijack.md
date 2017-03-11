---
title: 劫持tshark使其更方便的和我们自有系统交互
date: 2015-03-11 18:52:01
tags:
 - wireshark
 - tshark
 - hijack
---

## 劫持tshark解包接口
---

wireshark是一款伟大的工具，tshark是wireshark的命令行工具，具有丰富的功能。
但是tshark只能将数据包抓取解析并按照既定格式打印出来，没办法做更自由的数据格式，比如把特定数据形成Porotobuf格式，也没法对外交互，比如发送到某个socket等。


So，let‘s make it.


简单说一下环境：

* Centos6
* wireshark-1.10.8 源码


要劫持接口，那就追代码，hark源码的结构可以在其他地方找到更详细的剖析，我们只需要知道以下几个点：

* 各种协议包的解析在wireshark-1.10.8/epan/dissectors/ 下面
* 根据协议解包是个顺序的调用的过程，比如epan/dissectors/packet-ip.c中解析完IP协议，然后调用epan/dissectors/packet-udp.c来解析UDP协议，依次往后，直至没有新协议数据需要解析为止
* 协议包数据解析完是一个proto_tree结构，这棵树的添加构造在epan/proto.c中，上面的dissector都会掉用proto.c中的方法来将解析出来的数据添加到树中
* 注意一个header_field_info结构，内部成员name是展示的名字， abbrev是解析包过程中用到的过滤名字，比如ip.src udp.dstport等，还有一个type标识对应的value应该是什么数据
* proto.c设置数据的时候，会调用5个基本类型的数据设置方法 fvalue_set fvalue_set_sinteger fvalue_set_uinteger fvalue_set_integer64 fvalue_set_floating，代码在epan/ftypes/ftypes.c


数据流收缩的最小的口径就是在ftypes.c中，从这里入手才能最小代码的改动来劫持到所有数据。但是这里的函数获取到的只有value，而我们需要key和value都能一一对应上，因此还需要在调用者proto.c上动点手脚。



---


## 方法1


1. 创建如下文件shark_hijack.h


```C
void hijack_call(field_info *fi)
{
    if(! fi) return;
    const char* finfo_name   = fi->hfinfo->name;
    const char* finfo_abbrev = fi->hfinfo->abbrev;
    int finfo_type = (fi->hfinfo) ? fi->hfinfo->type : FT_NONE;
    switch (finfo_type) {
        // do your work here, you can get setted value like:
        // fvalue_get(&fi->value)
    }
    return;
}


#define fvalue_set(i ...) do{           \
    fvalue_set(i);                      \
    hijack_call(fi);                    \
}while(0)                               \


#define fvalue_set_uinteger(i ...) do{  \
    fvalue_set_uinteger(i);             \
    hijack_call(fi);                    \
}while(0)                               \


#define fvalue_set_sinteger(i ...) do{  \
    fvalue_set_sinteger(i);             \
    hijack_call(fi);                    \
}while(0)                               \


#define fvalue_set_integer64(i ...) do{ \
    fvalue_set_integer64(i);            \
    hijack_call(fi);                    \
}while(0)                               \


#define fvalue_set_floating(i ...) do{  \
    fvalue_set_floating(i);             \
    hijack_call(fi);                    \
}while(0)                               \
```

2. 将上述文件放在epan/ftypes/文件夹下，然后在epan/proto.c原文件最后一行include之后添加，如下行

```C
#include "ftypes/shark_hijack.h"
```

3. 这样，将原始的5个设置方法以宏的形式替换，在原始操作之后，调用hijack_call，将整个field_info指针传递过去，这里我们就能获取到name abbrev value，就可以根据自己的需求做些想做的事情了。这样的完整的样例可以在 https://github.com/xuy1202/xylibs/tree/master/tshark_wrap 看到


---


## 方法2

上面的方法最简单，但是需要在hijack_call中做类型判断，我们可以将修改面扩大一点，但是整体上更简单

1. 将上述shark_hijack.h修改为如下，还是用宏劫持的方式


```C
void shark_id_dispatch_string(int id, const char* val);
void shark_id_dispatch_int32(int id, gint32 val);
void shark_id_dispatch_uint32(int id, guint32 val);
void shark_id_dispatch_uint64(int id, guint64 val);
void shark_id_dispatch_double(int id, double val);


#define fvalue_set(i ...) do{           \
    shark_id_dispatch_string(fi->hfinfo->id, fvalue_set(i)); \
}while(0)                               \


#define fvalue_set_uinteger(i ...) do{  \
    shark_id_dispatch_uint32(fi->hfinfo->id, fvalue_set_uinteger(i)); \
}while(0)                               \


#define fvalue_set_sinteger(i ...) do{  \
    shark_id_dispatch_int32(fi->hfinfo->id, fvalue_set_sinteger(i)); \
}while(0)                               \


#define fvalue_set_integer64(i ...) do{ \
    shark_id_dispatch_uint64(fi->hfinfo->id, fvalue_set_integer64(i)); \
}while(0)                               \


#define fvalue_set_floating(i ...) do{  \
    shark_id_dispatch_double(fi->hfinfo->id, fvalue_set_floating(i)); \
}while(0)                               \
```


2. 原始的fvalue_set等5个函数返回类型为void，我们要修改为接受value的类型，并将valuereturn出来，比如修改fvalue_set为如下

```C
gpointer                                                              // 将void换成接受的value的类型
fvalue_set(fvalue_t *fv, gpointer value, gboolean already_copied)
{
    g_assert(fv->ftype->set_value);
    fv->ftype->set_value(fv, value, already_copied);
    return value;                                                      // 这里是修改的return
}
```

3. 这样，我们就将value直接分类型转给了我们自己声明的shark_id_dispatch_string等5个方法, 我们可以在另外一个动态库中实现这5个方法，然后修改Makefile链接起来，这样以后只需要修改我们自己的so就能达到修改逻辑的目的

4. tricky的地方注意到了么，我们没有name，没有abbrev，而只有一个fi->hfinfo->id。这个id其实是thark编译的时候根据各个解包器生成的固定的id，如果在proto.c的proto_register_field_init函数return之前添加一行


```C
printf("proto_register_field_init: %d->%s\n", hfinfo->id, hfinfo->abbrev);
```


编译执行开始，总能看到id和abbrev的固定映射关系，比如：



```
proto_register_field_init: 20587->dns.id
proto_register_field_init: 20588->dns.qry.type
proto_register_field_init: 20589->dns.qry.class
proto_register_field_init: 20590->dns.qry.class
proto_register_field_init: 20591->dns.qry.qu
```


因此，这样的映射表只需要知道，然后就完全可以根据id来做自己的逻辑了。


---


Wish you happy, go nuts!





