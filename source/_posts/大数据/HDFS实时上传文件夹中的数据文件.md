---
title: HDFS实时上传文件夹中的数据文件
tags:
  - 大数据
toc: false
comments: true
mathjax: true
categories:
  - 大数据
abbrlink: c39328c
date: 2020-05-18 16:59:25
---
需求：
编写一个脚本，监控一个文件夹，当有文件加入将其上传到HDFS。

步骤：

 1. 记录已经上传过的文件
 2. 获取文件夹下所有数据文件
 3. 判断是否已经上传，如果没有，上传，并记录


python脚本：

```
import os
from subprocess import call
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("path", type=str)
args = parser.parse_args()

old_files = []
path = args.path

while True:
    files = os.listdir(path)
    for file in files:
        if file not in old_files:
            ret_code = call('hdfs dfs -put %s /qjx/test' %file, shell=True)
            print('code:%s, filename:%s'%(str(ret_code), file))
            old_files.append(file)

```
