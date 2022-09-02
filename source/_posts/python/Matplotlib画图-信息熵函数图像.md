---
title: 'Matplotlib画图:信息熵函数图像'
tags:
  - python
toc: false
comments: true
mathjax: true
categories:
  - python
abbrlink: 6414d8ba
date: 2020-05-18 17:12:27
---


最近在看GAN和VAE的过程中，发现信息熵的概念多次出现，就又复习了一下。为了更形象的了解信息熵，在网上找信息熵函数图像的过程中，发现只有二元的信息熵图像，出于好奇，画了就画了一下三元的。

$E = -p_1 * log_2p_1 - (1 - p_1) * log_2(1 - p_1)$
![二元信息熵函数](https://img-blog.csdnimg.cn/20181129104954265.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzI2OTcyNzM1,size_16,color_FFFFFF,t_70)
$E = -p_1 * log_2p_1 - p_2 * log_2p_2 - (1 - p_1 - p_2) * log_2(1 - p_1 - p_2)$
![三元信息熵函数](https://img-blog.csdnimg.cn/20181129105100534.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzI2OTcyNzM1,size_16,color_FFFFFF,t_70)


代码：

```python
# coding: utf-8
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
# 二类信息熵
def binary_entropy(p, epslion=1e-10):
	'''params:
		   p: A numpy array
		   epslion: 防止数值溢出
	'''
	return -(p * np.log2(p + epslion) + (1 - p) * np.log2(1 - p + epslion))
# 三类信息熵
def compute_entropy(p1, p2, p3, epslion=1e-10):
	'''params:
		   p1, p2, p3: A numpy array
		   epslion: 防止数值溢出
	'''
	return -(p1 * np.log2(p1 + epslion) + p2 * np.log2(p2 + epslion) + p3 * np.log2(p3 + epslion))
# 二类信息熵图像
p1 = np.linspace(0, 1, 50)
entropy = binary_entropy(p1)

plt.figure()
plt.plot(p1, entropy, 'k-')
plt.xlabel('$p_1$')
plt.ylabel('E')
plt.savefig('./二类熵函数图像.jpg')
plt.show()

# 三类信息熵图像
p1 = np.linspace(0, 1, 50)
p2 = np.linspace(0, 1, 50)

x, y = np.meshgrid(p1,p2)    # 生成网格
z = 1 - x - y                # p3 = 1- p1 - p2
z[z <= 0] = 0.				 # p1 + p2 >= 1 则p3 = 0
E = compute_entropy(x, y, z, 1e-10)
E[(x + y) > 1] = None 		 # p1 + p2 > 1 熵值不存在

fig = plt.figure()
ax = Axes3D(fig)
ax.plot_surface(x, y, E, rstride=1, cstride=1)
ax.set_xlabel('$p_1$')
ax.set_ylabel('$p_2$')
ax.set_zlabel('E')
plt.savefig('./三类熵函数图像.jpg')
plt.show()

```
