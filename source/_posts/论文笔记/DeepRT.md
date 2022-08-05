---
title: DeepRT论文笔记
tags:
  - 调度算法
  - GPU推理
  - 深度学习
categories:
  - 论文笔记
toc: true
comments: true
mathjax: true
description: 隐藏后续内容
abbrlink: c85bd4be
date: 2022-08-05 15:52:48
---
<!--more-->
论文链接： [https://ieeexplore.ieee.org/document/9708995](https://ieeexplore.ieee.org/document/9708995)
# 背景

- 无处不在的智能手机相机和IoT摄像头，以及深度学习的快速发展。大量的CV驱动的终端应用部署在边缘服务器上。 
- 由于服务器GPU资源有限，因此在多租户的场景下（互相抢占资源），让边缘服务器支持soft real time的应用非常困难。 （soft real time推理的应用，即在ddl之前能够响应推理请求，并且允许偶尔违背ddl的约束）

**问题： 如何能够在有限的GPU资源下，及时的完成推理请求，并保证系统的高吞吐？**

# 性能分析
![在这里插入图片描述](https://img-blog.csdnimg.cn/0402abae23f34ecfb3fc0c7c72abd98a.png)
观察的现象：

- 同时执行两个或多个模型并不能显着提高系统吞吐量，并且由于执行时间增加而增加了每个请求的延迟。
- 在同一GPU 上执行多个任务时，存在干扰，无法分析或估计任务最坏的情况，增加了调度系统的困难
- 批量处理输入数据增加了系统吞吐量，远远超过模型并发执行，但牺牲了请求的执行时间。

**结论：**

- 并发执行多个模型实例并不能实现我们在保持高吞吐量的同时保证最大延迟的目标； 相反，它引入的干扰使设计实时系统变得困难。 所以采用顺序执行模型实例而不是并发执行。
- 批处理增加了吞吐量，但我们需要确保增加的延迟（增加的执行时间+等待属于同一批次的其数据时的排队时间）不会导致ddl miss。
# Design overview
![在这里插入图片描述](https://img-blog.csdnimg.cn/0cb3c7eab00247e9987fc98b0cad3bc9.png)

一共包含四个模块：

- Admission Control Module
   - 防止请求过多，导致任务阻塞。控制哪些请求可以进入后续的模块
- DisBatcher
   - 接收ACM的提交的请求，打包batch，进行batch的分发
- Performance Profiler
   - 记录不同setting下不同模型的延迟 
- Adaptation Module
   - 处理overrun的任务，尽可能避免ddl miss


### 请求的处理

- 将请求划分成不同的类别
   - 模型、输入shape相同的为同一类
- 为不同类的请求划分time window
### Performance Profiler
离线分析不同模型和输入的执行时间（取最坏情况下的），生成一个映射。交给Admission Control Module
### Admission Control Module
已经按请求类别划分了time window，以及不同输入和模型的执行时间。因此，采用基于模拟的方法，来确定哪些请求可以被处理。
两个阶段：

1. 去掉明显在ddl之前完不成的请求

s: 请求类别； N_s: 该类请求job instance的数量； E_i:  job_i 的执行时间； P_s:  该类请求的时间窗口长度
![在这里插入图片描述](https://img-blog.csdnimg.cn/fd965bca63804ec28fe0fa34904692b7.png)

2.  模拟任务运行，过滤超过ddl的请求
   1. 模拟生成job instance
   1. 使用EDF算法模拟job instance是否应该被调度
### DisBatcher
![在这里插入图片描述](https://img-blog.csdnimg.cn/5ad9ab7c6fec46bc8dfb1b960121b080.png)

- 每个time window中相同类别的请求，打包成一个batch，称为**job instance/task instance.   (task instance 包含多个job instance)**
- 设置**job instance/task instance**的ddl为对应的time window的长度，即在下一个time window之前必须要完成


#### 设置time window的长度
如图3，每个job instance中的帧的数量可能是不同的，不同job instance的执行时间有差异。因此，确定time window的长度以保证所有的帧在ddl之前完成很重要。
**DisBatcher设置time window的长度为所有同类请求中最小的ddl的一半。（证明了在请求到达的时间与ddl之间有一个完整的time window）**
![在这里插入图片描述](https://img-blog.csdnimg.cn/f760761959b448be9c24fb2bb73153a4.png)
###  Execution Worker
一旦请求可以被调度，ACM向DisBatcher发送请求相关的metadata（model, ddl, frame shape, period）
DisBatcher为每个类别的请求维护了一个队列，根据EDF的原则排序。ddl越早优先级越高。

- worker按优先级执行job instance，监控是否ddl miss。并且，如果实际执行时间ACM估计的时间长，则向ACM报告。
- 如果请求已经到达，但是在等待DisBatcher打包，则GPU偶尔会有空闲。
   - DeepRT在time window结束之前，立即发送到GPU进行执行
### Adaption Module
当GPU计算相同的任务时，可能相应时间也不同。如果一个job超时，那么会影响后续其它的job。因此需要对超时的任务有惩罚，更重要的是尽可能避免ddl miss。

- 为每个类别的job设置可一个惩罚值，初始为0。如果实际的执行时间大于profile的时间，惩罚值增加多的执行时间
- 同时，通知DisBatcher减少该类别job的输入shape（降低分辨率），生成新的job instance。减小后，不会与其它相同shape的其它类job打包成同一个batch
- Woker记录新的job instance的执行时间。并从惩罚中减去节省的执行时间。
# 实验结果
**GPU：** RTX2080、Jetson TX2（推理专用）
**Baseline： **AIMD、BATCH、BATCH-Delay
#### ddl miss rate:
![在这里插入图片描述](https://img-blog.csdnimg.cn/8f30b22993d548a0b7020abb548b9641.png)
#### overdue
soft real time 中允许一些请求超过ddl。从图5可以看出，由于使用了EDF算法，DeepRT超时的时间明显短。
![在这里插入图片描述](https://img-blog.csdnimg.cn/a544cd1c2e1742248f826cd2b13527d1.png)
#### Peak memory usage
![在这里插入图片描述](https://img-blog.csdnimg.cn/58e089fa9a7b4e7e89f4dec708600db9.png)
#### Through & handle the number of concurrent requests
![在这里插入图片描述](https://img-blog.csdnimg.cn/bcf8be7158c84064ae4d2f2c14bab96a.png)
#### estimatied latency accuracy && ACM running time
![在这里插入图片描述](https://img-blog.csdnimg.cn/2ea1436852d748aab966ff3c412cf0d1.png)
#### overrun 
![在这里插入图片描述](https://img-blog.csdnimg.cn/b28c89c3e2224d928f6714785902cb63.png)

