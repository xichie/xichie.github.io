---
title: 读取带标点的英文段落，分词、去重按字典顺序输出(C语言)
toc: true
comments: true
mathjax: true
tags:
  - c语言
  - 算法
  - PAT
description: PAT算法题练习
categories:
  - 算法
abbrlink: bcf8358e
date: 2020-05-18 15:35:03
---
例如：
输入：
I love Beijing.
I Love China.
Oh,Beijing is the capital of China.
Do you know?
Cheer up!!
输出：
Beijing
Cheer
China
Do
I
Love
Oh
capital
is
know
love
of
the
up
you
```c
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

void sort(char str[][100], int n)
{
	int i, j;
	char s[100] = {'\0'};
	for(i = 0; i < n; i++)
	{
		for(j = 0; j < n - i -1; j++)
		{
			if(strcmp(str[j], str[j+1]) > 0)
			{
				strcpy(s, str[j]);
				strcpy(str[j], str[j+1]);
				strcpy(str[j+1], s);
			}
			else if(strcmp(str[j], str[j+1]) == 0)
			{
				str[j][0] = '\0';
			}
		}
	}
}

int main()
{
	char str[1000][100] = {"\0"};
	int i, j, count;
	freopen("data.txt", "r", stdin);
	count = 0;
	while(~scanf("%s", str[count++]));
	for(i = 0; i < count; i++)
	{
		j = 0;
		while(isalpha(str[i][j]))
		{
			j++;
		}
		str[i][j] = '\0';
	}
	sort(str, count);
	for(i = 0; i < count; i++)
	{
		if(strlen(str[i]) != 0)
		{
			printf("%s\n", str[i]);
		}
	}
	fclose(stdin);
	return 0;
}
```
