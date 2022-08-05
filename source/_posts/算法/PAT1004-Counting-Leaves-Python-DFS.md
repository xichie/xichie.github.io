---
title: 'PAT1004:Counting Leaves Python DFS'
tags:
  - python
  - 算法
  - PAT
toc: false
comments: true
mathjax: true
categories:
  - 算法
abbrlink: 2f4483d6
date: 2020-05-18 17:08:48
---

题目大概意思就是统计一个树中每一层叶节点的个数。
节点编号从01开始，程序将其转化为从1开始。最终提交结果（27/30）
**第五个测试点就是不通过！求好心人解答。**
题目链接：https://pintia.cn/problem-sets/994805342720868352/problems/994805521431773184
![](https://img-blog.csdnimg.cn/20190409154407817.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzI2OTcyNzM1,size_16,color_FFFFFF,t_70)
![](https://img-blog.csdnimg.cn/20190409155404160.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzI2OTcyNzM1,size_16,color_FFFFFF,t_70)
#### 用深度优先搜索遍历整棵树，树采用map存储

```
def main():
  G ={}
  level = [0] * 101
  visted = [0] * 101
  def dfs(node, degree):
    visted[node] = 1
    if G.get(node, -1) == -1:     # 没有子节点
      level[degree] += 1
      return
    for child in G[node]:          # dfs遍历当前节点的所有子节点
      if visted[child] == 0:
        dfs(child, degree+1)
  ##########      
  N, M = list(map(int, input().split(" ")))
  if N == 1:                       # 只有一个节点直接输出1
    print(1)
  else:                          
   # 初始化树
    for _ in range(M):
      node, k, *child_nodes  = list(map(int, input().split(" ")))
      G[node] = child_nodes
      
    dfs(1, 0)     # 从根节点开始遍历
    
    leaves = N - M
    count = 0
    result = ''
    for num in level:
      result += str(num) + ' '
      count+=num
      if count >= leaves:
        break
    print(result.strip())    # 去除首尾的空格
    return 0
if __name__ == '__main__':
  main()
```
