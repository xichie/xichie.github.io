---
title: 'PAT乙级1011:A+B和C（C语言）'
tags:
  - c语言
  - 算法
  - PAT
toc: false
comments: true
mathjax: true
categories:
  - 算法
abbrlink: 5756a91f
date: 2020-05-18 15:57:30
---

不知道这个题考的知识点是什么。。。。。
```c
#include <stdio.h>
int main()
{
	int t, i;
	double a, b, c;
	while(~scanf("%d", &t))
	{
		for(i = 0; i < t; i++)
		{
			scanf("%lf %lf %lf", &a, &b, &c);
			if(a + b > c)
			{
				printf("Case #%d: true\n", i+1);
			}
			else
			{
				printf("Case #%d: false\n", i+1);
			}
		}
	}
	return 0;
}
```
