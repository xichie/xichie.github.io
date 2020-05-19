---
title: python读取cifar10数据集
tags:
  - python
toc: false
comments: true
mathjax: true
categories:
  - 机器学习
abbrlink: a27dd3ed
date: 2020-05-18 17:18:40
---
最近学习卷积网络用到cifar10数据集，自己写了一个工具类，用来读取已经下载到本地的cifar10数据集。

代码写的不算好，但是自己用起来还可以。所以放到网上，有需要的可以拿去用。代码比较少，所以没有写注释。下面介绍一下实现的功能。完整的代码可以在github上下载。地址：https://github.com/xichie/DeepLearning/tree/master/Cifar10

文件名为：input_data.py

创建了一个类Cifar10()：用于读取本地数据集，对数据集进行操作

__init__(self, path, one_hot = True): 参数path为本地数据集存储路径。one_hot：决定是否对类别独热编码

_load_data()：用于加载数据集

next_batch(batch_size, shuffle = True): 该方法返回指定batch_size大小的训练集， shuffle：决定是否打乱顺序

下面是使用该类的方法：

```
import input_data
import numpy as np

path = r"E:\pythonCode\TensorFlow\cifar10\cifar-10-batches-py"
cifar10 = input_data.load_cifar10(path, one_hot = True)
images = cifar10.images
print("训练集图片：" + str(images.shape))
labels = cifar10.labels
print("训练集类别：" + str(labels.shape))
test_images = cifar10.test.images
print("测试集图片："+ str(test_images.shape))
test_labels = cifar10.test.labels
print("测试集类别："+ str(test_labels.shape))
batch_xs, batch_ys = cifar10.next_batch(batch_size = 500, shuffle = True)
print("batch_xs shape is:" + str(batch_xs.shape))
print("batch_ys shape is:" + str(batch_ys.shape))
```
