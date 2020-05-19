---
title: Latex+VScode配置方法，以及bibtex导入中文文献的问题
tags:
  - 工具
toc: true
comments: true
mathjax: true
categories:
  - 日常笔记
abbrlink: b6592798
date: 2020-05-18 17:00:37
---

最近要写开题报告，一开始用word写，还是那个问题，格式什么的弄得我头疼。心想后面有论文要写，所以准备用latex。
原来一直在用vscode，所以网上搜了很多vscode配置latex环境的教程。所以在这里做一个详细的记录，希望对和我一样的人有所帮助。

**环境：win10+vscode+CTeX_2.9.2.164_Full**
##  下载CTex
由于我也不太懂latex原理，反正凑合着会用。所以没试过别的环境。用的是清华的镜像，下载地址：http://www.ctex.org/CTeXDownload/。 下载带full的那个，包比较全，省好多事儿。
## 下载VScode
地址：https://code.visualstudio.com/。 微软的编辑器，在windows上的好处我不多说了。安装不要太简单，也没啥说的。


## 安装CTex
我的安装方式就是，点开安装包，下一步点到底，全默认的。安装的过程可能比较慢，建议边安装，边进行下面的过程。

## 配置VSCode环境
先安装如下图所示的插件，只需要安装第2个和第3个就可以。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190622133124840.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzI2OTcyNzM1,size_16,color_FFFFFF,t_70)
然后打开vscode的配置文件（vscode的左下角蓝色圈圈那个位置，点击**设置**进入配置文件）如图：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190622134346401.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzI2OTcyNzM1,size_16,color_FFFFFF,t_70)
然后点击上图右上角红色圈住的图标，进入配置文件（json格式的），如图：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190622134555491.PNG?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzI2OTcyNzM1,size_16,color_FFFFFF,t_70)
把下面的配置复制进去，就可以。

```
{
    "git.ignoreMissingGitWarning": true,
    "files.autoSave": "afterDelay",
    "editor.fontSize": 16,
    "editor.fontFamily": "'Courier New'",
    "editor.wordWrap": "on",
    // latex
    "latex-workshop.latex.recipes": [
    {
        "name": "pdflatex -> bibtex -> pdflatex*2",
        "tools": [
            "pdflatex",
            "bibtex",
            "pdflatex",
            "pdflatex"
        ]
    }
    ],
    "latex-workshop.latex.tools": [{
        "name": "latexmk",
        "command": "latexmk",
        "args": [
            "-synctex=1",
            "-interaction=nonstopmode",
            "-file-line-error",
            "-pdf",
            "%DOC%"
        ]
    }, {
        "name": "xelatex",
        "command": "xelatex",
        "args": [
            "-synctex=1",
            "-interaction=nonstopmode",
            "-file-line-error",
            "%DOC%"
        ]
    }, {
        "name": "pdflatex",
        "command": "pdflatex",
        "args": [
            "-synctex=1",
            "-interaction=nonstopmode",
            "-file-line-error",
            "%DOC%"
        ]
    }, {
        "name": "bibtex",
        "command": "bibtex",
        "args": [
            "%DOCFILE%"
        ]
    }],
    "latex-workshop.view.pdf.viewer": "tab",
    "latex-workshop.view.pdf.hand": true,
    "latex-workshop.latex.autoBuild.run": "onFileChange",
    "latex-workshop.latex.clean.fileTypes": [
        ".aux",
        ".bbl",
        ".blg",
        ".idx",
        ".ind",
        ".lof",
        ".lot",
        ".out",
        ".toc",
        ".acn",
        ".acr",
        ".alg",
        ".glg",
        ".glo",
        ".gls",
        ".ist",
        ".fls",
        ".log",
        ".spl",
        ".synctex.gz",
        "*.fdb_latexmk"
    ],
    "latex-workshop.latex.autoClean.run": "onBuilt",
}
```
**ok！vscode环境就配置好了！**下面就等着CTex安装完毕，CTex安装完后，应该会自动配置系统的环境变量（没有的话，可以自己配置一下）。如图：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190622135009307.png)
## 大功告成
最后效果如下图：可以边写，边看效果。编译速度还是可以的。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190622135604554.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzI2OTcyNzM1,size_16,color_FFFFFF,t_70)

**还没完！！！，还有一些关于latex导入中文文献的问题。**
##  Bibtex导入中文文献的问题

关于如何使用Bibtex导入文献的问题，这里我做一个简单的介绍：
首先在你的 **.tex** 文件在目录下，创建一个后缀为 **.bib** 的文件，比如叫：**ref.bib**。
在你的 **.tex** 文件中 **\end{document}** 前面加入下面两行：

```
\bibliographystyle{ieeetr}       %这里是参考文献的引用格式，可以自定义。
\bibliography{ref}       %这里是你自己的.bib文件的名字
```
然后我们通过google学术（没梯子的可以用镜像：）或者百度学术，搜索我们引用的论文：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190622141223288.png)
点击下面的双引号，出现：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190622141321153.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzI2OTcyNzM1,size_16,color_FFFFFF,t_70)
我们选择Bibtex，将出现的网页上的内容复制，粘贴到自己创建的.bib文件中就行。
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019062214143375.png)
在.tex中，导入参考文献相应的包：

```
\usepackage{cite}
\newcommand{\upcite}[1]{\textsuperscript{\textsuperscript{\cite{#1}}}} %参考文献上标
```
引用格式：

```
\begin{document}
\maketitle          %添加这一句才能够显示标题等信息

我爱你，中国！！！\upcite{wu2008fast}
中文文献\upcite{meng}

\bibliographystyle{ieeetr}
\bibliography{ref} 
\end{document}
```
效果：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190622143118919.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzI2OTcyNzM1,size_16,color_FFFFFF,t_70)
####  我们可以看到，对于中文参考文献，如果用ieeetr等默认的格式，就会有问题。
这里我找到了一个模板，可以下载下来：https://raw.githubusercontent.com/Haixing-Hu/GBT7714-2005-BibTeX-Style/master/gbt7714-2005.bst 直接复制保存为.bst文件就行。比如叫chinese.bst
然后将这个bst文件放到和你的.tex文件同一目录下，只需要更改bst文件的引用就行：
```
\bibliographystyle{chinese.bst}
```
并且参考文献的标题是英文的，如果想改成中文，在文件开头加入下面的代码

```
\renewcommand\refname{参考文献}
```
效果如图：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190622143401674.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzI2OTcyNzM1,size_16,color_FFFFFF,t_70)

##  总结
至此，latex+vscode的环境就算配置好了，其它如果有关于latex格式的问题，可以直接百度，基本上都能轻松搞定。


## 参考资料
[1] https://liam.page/2014/05/09/gbt7714-2005-bibtex-style/
[2] https://www.jianshu.com/p/dc0ffa4368e3