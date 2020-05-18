---
title: web相关知识
date: 2020-05-18 11:39:05
tags:
categories:
toc:
comments:
mathjax:
---
#### servlet生命周期
&#8195; &#8195;**servelt是一个单实例多线程的动态web技术。** 默认情况下，第一次访问时调用init方法初始化。每当接受一个请求，就创建一个线程，并调用对应的service方法。最后，当此servlet被移除或者服务器正常关闭的时候，调用用destroy方法销毁。
#### session生命周期
当服务器启动，第一次调用getSeesion方法时，session创建。
session销毁的方式：
* seesion有默认的销毁时间，在web.xml中配置。
*  非正常原因关闭服务器。（正常关闭服务器，session不会销毁，会序列化到磁盘上）  
* 调用invalidate()方法销毁。
	
#### 重定向和请求转发的区别：
######  重定向：
两次请求，可以访问外部资源，路径要加项目名。
状态码：302
响应头：location：url （url必须加项目名）
###### 请求转发：
一次请求，只能访问内部资源，路径不能添加项目名。★

###### 会话技术
会话：它是一个过程，针对的是每个用户。打开浏览器，发送多次请求，得到多次响应，该过程叫做会话。
会话可以简单的分为：**Cookie(基于客户端的技术)、Session(基于服务器端的技术)**
###### Cookie技术：
流程：

 1. 浏览器端第一次向服务器发送请求
 2. 在服务端创建Cookie：Cookie c = new Cookie(key,  value)
 3. 通过response对象的addCookie方法，将服务器创建Cookie回写给浏览器端，并在浏览器端保存。响应头为set-cookie：key=value
 4. 当浏览器向服务器发送第二次请求时，请求头中包含cookie：key=value
 5. 服务器接受请求后，通过request.getCookies()获取Cookie对象，继续操作Cookie对象，并回写Cookie
 6. 默认情况下，当浏览器关闭后，Cookie会被清除。可以通过setMaxAge方法设置Cookie在浏览器端保存的时间。
###### session技术：
流程：
 7. 当浏览器第一次访问服务器，会在服务器端创建一个session空间，可以在空间中存取一些值。获得该空间的唯一标识jsessionid，并将jsessionid回写给浏览器set-cookie：jsessionid=value。
 8. 浏览器第二次访问服务器时，在请求头中会有jsessionid=value，然后通过它来访问自己的seesion空间。
##### Ajax异步请求
异步请求：就是只提交页面的一部分数据和服务器交互，局部刷新页面。如果服务器没有相应，也不会影响页面上的其它操作。
**———————————————— 了解内容—————————————————**
js提供了一个XMLHttpRequest对象来实现异步的请求。具体的步骤如下：
 * 创建XMLHttpReques对象xhr。
 * 连接资源。使用open(url)方法。
 * 设置请求的参数。send()方法。如send("username="+tom+"&password="+123）
 * 使用onreadystatechange时间监听xhr对象状态的改变。若xhr.readyState==4且判状态码xhr.status 为200。
 * 获取服务器响应的内容。xhr.responseText；
**—————————————— 了解内容—————————————————**

##### 使用jQuery对象实现异步请求：
**jQuery对象**

DOM对象转换为jQuery对象：$(dom对象)
jQuery对象转换为DOM对象：
---------------jQuery对象是一个数组对象。可以通过下标或者get(index)方法获取dom对象
DOM对象和JQuery对象的对比：
如果ID值不存在, DOM对象会报错，jQuery对象不会。

**jQuery中的Ajax**
 
 常用的方法：
 - 对象.load(url, data, callback(data, textStatus, XMLHttpRequest ))
 - $.get(url, data, callback, type)
 - $.post(url, data, callback, type)
 - $.ajax()  
 其中：
 	url：请求的资源路径
 	data：请求的参数
 	callback：回调函数，得到响应后的处理方式
 	type: 返回内容的格式。如：html, script, json, text, xml
 	————data：响应的内容
 	————textStatus: 请求的状态
 	————XMLHttpRequest : 底层对象
 
 

