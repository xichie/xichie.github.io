---
title: python3中的浅拷贝与深拷贝
tags:
  - python
toc: false
comments: true
mathjax: true
categories:
  - python
date: 2020-05-18 17:23:00
---
在下面的代码中列表a中又包含一个列表和一个字符串。所以在使用copy进行浅拷贝得到b和d，更改a中索引值为0,1，-1的元素，b和d中只有索引值为0被更改，而且b和d的地址和a又不相同，所以可以看出，浅拷贝创建了一个新的对象，但是新对象中所存储的对象并没有被拷贝（和原有的对象用的是同一个地址）。

而深拷贝显然是将要拷贝的对象和其子对象都进行了拷贝。

而且还看出将字符串都变为大写，是重新创建了一个新的对象。=。=
```
import copy
def f(x):
    return x
a = [["a", "b"],1,2,3, "d"]
b = copy.copy(a)
c = copy.deepcopy(a)
d = a.copy()
e = f(a)
a[0].append("c")
a[1] = 0
a[-1] = a[-1].upper()
print(a)                    #[['a', 'b', 'c'], 0, 2, 3, 'D']
print(b, id(b) == id(a))    #[['a', 'b', 'c'], 1, 2, 3, 'd'] False
print(c, id(c) == id(a))    #[['a', 'b'], 1, 2, 3, 'd'] False
print(d, id(d) == id(a))    #[['a', 'b', 'c'], 1, 2, 3, 'd'] False
print(e, id(e) == id(a))    #[['a', 'b', 'c'], 0, 2, 3, 'D'] True
```






