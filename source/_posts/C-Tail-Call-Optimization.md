---
title: C++ Tail Call Optimization
date: 2017-03-09 23:39:56
tags:
 - C++
 - Tail Call Optimization
 - Tail Call
 - TCO
---

一直没有验证过C++对尾递归的优化，同事讨论起来，写个代码验证下

```C++
#include <iostream>
#include <time.h>
#include <unistd.h>


int tailrecsum(int x, int& running_total)
{
    if(x == 0){
        return running_total;
    }
    usleep(100);
    // GOOD
    running_total += x;
    return tailrecsum(x - 1, running_total);
    // BAAD
    //return x + tailrecsum(x - 1, running_total);
}


int main(void)
{
    int r = 0;
    std::cout << tailrecsum(10        , r) << std::endl;
    std::cout << tailrecsum(100       , r) << std::endl;
    std::cout << tailrecsum(1000      , r) << std::endl;
    std::cout << tailrecsum(10000     , r) << std::endl;
    std::cout << tailrecsum(100000    , r) << std::endl;
    std::cout << tailrecsum(2000000000, r) << std::endl;

    return 0;
}
```

上述代码，GOOD的两行就是尾递归模式，BAAD的一行是普通递归的模式
如果把usleep睡眠屏蔽，直接g++编译，执行立马会 "Segmentation fault: 11"
把usleep放开，会观察到内存持续上升，这就是栈调用占用的内存

但是只要开启了 -O1/2/3 优化模式编译，把usleep屏蔽掉，结果会很快返回（当然，结果是错的，溢出成负数）。把usleep放开，可以观察到内存会恒定不变，此时递归调用不会随着调用过程占用额外的内存。

如果是BAAD的代码，-O1/2/3 编译也是没用的。

结论：
* 编译器能够针对尾递归代码进行执行优化，此时递归调用基本相当于一个循环，前提是要 -O1/2/3 开启编译优化
* 编译器不会把非尾递归的代码优化成尾递归的效果，绿色低碳程序员请多留心，提高自己姿势水平，代码一小行，烧掉一棵树


