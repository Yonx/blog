## Oh Python, My Love...

理论上, 你只需要掌握print函数，int/long float str等基本数据类型，还有list tuple dict基本容器，你就可以开始写代码了

如果你想了解除了print，还有那些函数可以直接用的，请输入：
```
>>> dir(globals()['__builtins__'])
```
* globals：也是一个内置函数，可以获取到当前代码执行的全局dict，相当当前执行的Context
* dir: 列出一个对象的所有成员，包括变量或者函数
* __builtins__： 如其名，就是内建的所有东东，包括你最亲切的print

对于列出来的东西，大部分你都不知道是干什么的吧，你可以选择google，你也可以选一个，比如range， 然后
```
>>> print range.__doc__
```

这样你就可以知道range到底是干什么用的了。

当然，也可以一劳永逸的来个
```
>>> mod = globals()['__builtins__']
>>> for name in dir(mod):
	print name
	print getattr(mod, name).__doc__
	print "-------------------------"
```
直接把所有内建的方法都罗列出来看是什么意思，上述的mod可以换成任何module，或者你写的模块，或者对象/方法。
要知道，python里面所有东西都是对象。


