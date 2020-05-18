---
title: VAE变分自编码器Keras实现
tags:
  - VAE
  - 深度学习
toc: true
comments: true
mathjax: true
categories:
  - 深度学习
date: 2020-05-18 17:13:41
---

   **这篇博客用来记录我自己用keras实现(抄写)VAE过程中，掉进的一个坑。。。。。。**
    最近这几天在网上看了很多VAE的介绍，并且看了一下keras中的实现。自我感觉良好，就想按着官方的代码自己也去写一遍。不写不知道，一写吓一跳！！我跳进了一个很大坑中（笑哭），我在把代码写完以后，开始训练模型，发现代码报出如下错误。
```
InvalidArgumentError: Incompatible shapes: [64,784] vs. [64]
	 [[Node: add_3 = Add[T=DT_FLOAT, _class=["loc:@training_1/Adam/gradients/add_3_grad/Reshape"], _device="/job:localhost/replica:0/task:0/device:CPU:0"](logistic_loss_1, Sum_2)]]
```
  

   维度不匹配吗这不是，于是我非常认真仔细的开始找错误的原因，找了好久也没发现哪里维度不匹配，我跟keras中实现的VAE开始一行一行的比对自己定义的模型，并且都都把模型的结构都画了出来，发现完全一样，这就让我纳闷了。。。憋的我都想哭。到底哪里出了问题呢？（抓狂）
   鬼知道我找了多久，我终于发现了问题所在，原来是重构误差定义的问题，官方中实现的方式是用的from keras.losses import binary_crossentropy中的交叉熵损失，而我用的是K.binary_crossentropy（我是TensorFlow的后端），我把重构误差改成keras中的交叉熵损失后，OK！问题解决。（神清气爽！！）
   我查了一下Keras中和TensorFlow中这binary_crossentropy的源码，如下：
   

```
# keras.losses
def binary_crossentropy(y_true, y_pred):
    return K.mean(K.binary_crossentropy(y_true, y_pred), axis=-1) 
	
# tensorflow 后端
def binary_crossentropy(target, output, from_logits=False):
    return tf.nn.sigmoid_cross_entropy_with_logits(labels=target,
                                                   logits=output)
```
keras中虽然也是调用的TensorFlow中的方法，但是它求均值了（**划重点**），当然shape不匹配了。。如果还想继续使用K.binary_crossentropy那么定义重构损失如下:

```
reconstruction_loss = K.sum(K.binary_crossentropy(inputs, outputs), axis=-1)
```
官方提供示例中的定义：

```
reconstruction_loss = binary_crossentropy(inputs, outputs) * original_dim
```
由于keras中求了平均，所以还得乘以原来的维度，变成求和（何必呢。。。）

看来以后看代码还得仔细加认真啊。。。。由于现在框架众多，隐藏了太多的细节，所以看一看源码还是很有必要的，要不遇到大坑，都不知道什么情况。（好气啊。。。），努力！！！
   