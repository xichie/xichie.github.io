---
title: JSP学习笔记
toc: true
tags:
  - web基础
categories:
  - web
date: 2020-05-18 15:33:03
comments:
mathjax:
---
# Jsp介绍：
jsp(java server pages)本质上就是一个servlet。而servlet是一个运行在服务器端的小程序，可以生成动态的内容。jsp可以将内容的生成和显示分离。
# jsp组成：
html+java代码+jsp标签。
# jsp脚本：
	

 1. <%代码 %>：java代码片段。（代码会在_jspService方法中）
 2. <%=代码%>：脚本表达式输出，不能以分号结尾。（代码会在_jspService方法中）
 3. <%!代码%>：声明表达式。（全局的变量或方法）
# jsp注释：
 1. html注释（面试题）
 &emsp; 内容会编译,java原码中会有,页面上不体现。**因为html的注释只是隐藏不显示。**
 2. java注释
 &emsp; 不会运行也不会在页面上显示出来。
 3. jsp注释（常用）
 &emsp; <%--注释内容--%>，html和原码中都不会出现。
