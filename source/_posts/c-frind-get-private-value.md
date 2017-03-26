---
title: c++ 通过 frind 来获取一个类的 private 成员变量
date: 2015-03-16 18:46:38
tags:
 - cpp
---

有个朋友问到一个给定的不可变的类，且是安装好的三方库，不能改代码，不能重新编译，想获取其私有变量，有什么方法？
答案是友元～


lib头文件 t.h
```c++
#include <iostream>

class P{
    private:
        std::string private_string;
    public:
        P();

    //friend class G;    // ADD THIS LINE
};
```

lib代码 t.cc
```c++
#include "t.h"

P::P():private_string("private_string"){
}
```

上面两个文件编译为libt。注意这时候上面friend是屏蔽掉的，因为我们假定原始给定的头文件没有友元。
```sh
[xuamao@xuamaos-MacBook-Pro:~/qdev/test]$ g++ -c -fPIC t.cc -o t.o
[xuamao@xuamaos-MacBook-Pro:~/qdev/test]$ g++ -shared -o libt.so t.o
```

我们自己的测试代码m.cc
```c++
#include "t.h"

struct G{
    std::string get_private(const P& p)
    {
        return p.private_string;
    }
};

int main(void)
{
    P p;
    G g;
    std::cout << g.get_private(p) << std::endl;

    return 0;
}
```

此时如果不把上述friend行打开，直接编译会报错：
```sh
[xuamao@xuamaos-MacBook-Pro:~/qdev/test]$ g++ m.cc -lt -L./
m.cc:6:18: error: 'private_string' is a private member of 'P'
        return p.private_string;
                 ^
./t.h:5:21: note: declared private here
        std::string private_string;
                    ^
1 error generated.
```

这是符合预期的，因为就是要测试friend行代码的效用嘛～打开后就能正常编译执行。
我的测试环境是mac+clang，如果是linux＋g++，最后编译可执行文件时需要增加运行期lib查找路径 -Wl,-rpath=./

总结：
* class的private/protected权限是编译期的行为，提供的是编译期的内存获取权限的检查，编译完成后就没有任何约束了
* 因此，我们想要获取一个给定对象的私有变量，是我们自己代码编译时期的权限检查，只要保证自己代码编译时有friend来放开权限即可

{% note warning %}
如果给定一个类，对于其私有成员变量，直接get有时候可以理解，绝不要直接set，在不知道原本class实现的前提下，极有可能会破坏其内部实现的逻辑
{% endnote %}




