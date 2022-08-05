---
title: MapReduce单元测试不通过
tags:
  - 大数据
toc: false
comments: true
mathjax: true
categories:
  - 大数据
abbrlink: 8e63b6f8
date: 2020-05-18 17:20:51
---
前几天用mrunit进行单元测试，一直报错：java.lang.IncompatibleClassChangeError: Found interface org.apache.hadoop.mapreduce.TaskInputOutputContext, but class was expected

在网上查了一下，说这个错误是导入的包有问题，废了老半天劲，原来是mrunit包导入的不对。开始导入包是：



后来在改了依赖后，pom文件中的依赖是这样写的：

<dependency>
    <groupId>org.apache.mrunit</groupId>
    <artifactId>mrunit</artifactId>
    <version>1.0.0</version>
    <scope>test</scope>
</dependency>

但是一直报错误：Missing artifact org.apache.mrunit:mrunit:jar:1.0.0

最后加了一行改成如下：

<dependency>
	    <groupId>org.apache.mrunit</groupId>
	    <artifactId>mrunit</artifactId>
	    <version>1.0.0</version>
	   <classifier>hadoop2</classifier>
	    <scope>test</scope>
</dependency>
发现错误消失了。 去查看下载的jar包后发现，包名包含hadoop2，mrunit官网看了一下也带着hadoop：



要是不加hadoop2，maven肯定不知道下载什么啊。