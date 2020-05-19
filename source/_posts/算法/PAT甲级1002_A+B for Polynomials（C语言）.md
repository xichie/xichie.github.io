---
title: 'PAT甲级1002:A+B for Polynomials（C语言）'
tags:
  - c语言
  - 算法
  - PAT
toc: false
comments: true
mathjax: true
categories:
  - 算法
abbrlink: a25b8781
date: 2020-05-18 16:07:42
description:
---

笨方法：创建一个结构体保存指数和系数。
测试点：
	

 - 系数为0的情况。不计入项数，也不输出。
 - 输出格式的问题
 - 

```c
#include <stdio.h>
#include <stdlib.h>
#define MAX 20

typedef struct num
{
	// n^m
	double n;
	int m;
}NUM;

void sort(NUM a[], int k)
{
	int i,j;
	NUM tmp;
	for(i = 0; i < k; i++)
	{
		for(j = 0; j < k- i -1; j++)
		{
			if(a[j].m < a[j+1].m)
			{
				tmp = a[j];
				a[j] = a[j+1];
				a[j+1] = tmp;
			}
		}
	}
}


int main()
{
	NUM a[MAX];
	NUM b[MAX];
	int k, i, j, q, flag;

	scanf("%d", &k);
	for(i = 0; i<k; i++)
	{
		scanf("%d %lf", &a[i].m, &a[i].n);
	}
	scanf("%d", &k);
	for(j = 0; j < k; j++)
	{
		scanf("%d %lf", &a[i].m, &a[i].n);
		i++;
	}
	
	// 合并相同指数的项，存入结构体数组b中
	// flag标记是否发生合并
	k = 0;
	for(j = 0; j < i; j++)
	{
		flag = 0;
		for(q = 0; q < k; q++)
		{
			if(b[q].m == a[j].m)
			{
				b[q].n += a[j].n;
				flag=1;
				break;
			}
		}
		if(!flag)
		{
			b[k++] = a[j];
		}
	}
	sort(b, k);   // 按指数降序排序
	//i统计系数非零项的数量
	i = 0;
	for(j = 0; j < k; j++)
	{
		if(b[j].n != 0)
		{
			i++;	
		}
	}
	// 输出系数非零项的数量
	printf("%d", i);
	// 输出系数非零的项
	for(j = 0; j < k; j++)
	{
		if(b[j].n == 0)
		{
			continue;
		}
		printf(" ");
		printf("%d %.1f", b[j].m, b[j].n);
	}
	printf("\n");
	return 0;
}
```
简单的方法：创建一个1001大小的数组，索引为指数，值为系数。然后统计输出即可。

```c
#include <stdio.h>
#include <stdlib.h>

int main()
{
	int k, i, j,cnt=0;
	double a[1001] = {0.0}, tmp;
	while(~scanf("%d", &k))
	{
		for(i = 0; i < k; i++)
		{
			scanf("%d", &j);
			scanf("%lf", &tmp);
			a[j] += tmp;
		}
	}
	for(i = 0; i < 1001; i++)
	{
		if(a[i] != 0)
		{
			cnt++;
		}
	}
	printf("%d", cnt);
	if(cnt == 0)
	{
		return 0;
	}
	for(i = 1000; i >= 0; i--)
	{
		if(a[i] != 0)
		{
			printf(" ");
			printf("%d %.1lf", i, a[i]);
		}
	}
	printf("\n");
	return 0;
}

```
