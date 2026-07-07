---
draft: true
date: 2023-01-31
categories:
  - Hello World
authors:
  - Jagger
comments: true
---

# ppo

<!-- more -->

- 注意区分observation、state。obs是sta的一部分,agent不一定是全视野，只能看到部分->obs
- reward定义的好坏很大程度上影响训练
- return很重要；我们不追求当前reward最大，而是希望累积返回的return最大

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202607070946475.png)

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202607070950260.png)

- on policy
  - 采集数据和训练的policy是同一个
  - 大部分时间都在采集数据，训练非常慢
  - actor-critic算法。actor负责做动作，critic负责打分

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202607071017507.png)

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202607071021068.png)

- lambda是衰减因子
- 平衡了采样不同步带来的方差和偏差的估计

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202607071026686.png)

- sigma表达式
  - 状态价值函数
    - 状态价值函数可以用一个神经网络拟合可以和策略函数共用网络参数最后一层改为输出单一值，代表当前状态价值
- 总体价值估计
- 策略梯度优化目标函数
  - 目的是让这个函数的值越大越好

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202607071036415.png)

- on policy
  - 采集的数据只能用一次就需要丢弃，训练速度慢
- off policy
  - 训练的模型和采集数据的模型不是同一个采集的数据可以用来多次训练

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202607071040509.png)
在p分布下采样x，计算f(x)的期望

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202607071046246.png)

- 用重要性采样更新目标函数的梯度公式，将on policy转化为off policy
- 要求参考策略和训练策略在同一情况下动作概率分布的差别不能太大
- 重要性采样的目的就是为了从on-policy转变为off-policy，并自适应调整步伐大小。原本模型采样一次数据就要更新一次，但是使用重要性采样后，模型可以利用采样的数据训练多次，并自适应地控制更新的幅度，不要太偏离old模型。训练多次之后再用最后的模型覆盖old模型，如此反复。

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202607071050102.png)

- 通过KL散度加上差别不能太大的约束
- 可以通过截断函数替代KL散度实现防止偏差过大
