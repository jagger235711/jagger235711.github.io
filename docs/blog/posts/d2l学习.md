---
authors: 
    - Jagger
categories:
  - 学习笔记
date: 2025-04-10
# draft: true
comments: true
---
学习深度学习的笔记
[课程主页](https://courses.d2l.ai/zh-v2/)

<!-- more -->

- 深度学习中的三种角色

![image-20250410215920852](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250410215920852.png)

- 找paper

- 注意广播机制可能会改变张量的形状
- 使用切片机制实现对张量的原地操作
- 机器学习的核心就是处理缺失数据
- 矩阵乘法其实是在做一个空间变换
- 机器学习求解核心思想：求解梯度变换最快的方向

![矩阵计算](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250411104049378.png)

![image-20250413172908015](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250413172908015.png)

![截图 2025-04-13 19-09-06](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/截图 2025-04-13 19-09-06.png)

![截图 2025-04-13 19-08-03](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/截图 2025-04-13 19-08-03.png)

![截图 2025-04-13 19-14-28](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/截图 2025-04-13 19-14-28.png)

![image-20250414090908463](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250414090908463.png)

![image-20250414091348836](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250414091348836.png)

![image-20250414091929344](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250414091929344.png)

- 机器学习主要关注np问题

正向传播和反向传播

- 正向就是求复合函数的值
- 反向就是求偏导数和梯度
- 数学中的求导就是反向传播的方向
- 代码中正向积累的中间值只有在明确声明需要且调用了反向积累时才会计算，因为计算它 too expensive

![image-20250411204538280](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250411204538280.png)

- 课程中默认向量是列向量

-  A.sum(axis=0)对矩阵某一维度进行求和，第0维是竖着的，对应默认向量是列向量

- **范数**（英语：Norm），是具有“长度”概念的[函数](https://zh.wikipedia.org/wiki/函數)。在[线性代数](https://zh.wikipedia.org/wiki/線性代數)、[泛函分析](https://zh.wikipedia.org/wiki/泛函分析)及相关的数学领域，是一个[函数](https://zh.wikipedia.org/wiki/函數)，其为[向量空间](https://zh.wikipedia.org/wiki/向量空間)内的所有[向量](https://zh.wikipedia.org/wiki/向量)赋予非零的正**长度**或**大小**。另一方面，**半范数**（英语：seminorm）可以为非零的[向量](https://zh.wikipedia.org/wiki/向量)赋予零长度。

  ![image-20250412081934431](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250412081934431.png)

![image-20250412175358645](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250412175358645.png)

- 神经网络层数->看带权重的层有几层

### 线性回归

- 超参数

  - 学习率就是每次下降的步长，一次下降多少

    - 偏大导致震荡偏小导致学习速度慢

  - b就是批量大小，控制每次随机采样个数。`batchSize`（批量大小）指的是在一次前向传播与反向传播过程中所使用的样本数量。在训练深度学习模型时，通常不会将整个数据集一次性输入到模型中进行训练，而是把数据集划分成若干个小的批次（batch），每个批次包含 `batchSize` 个样本。

    - batchSize宜小不宜大。小的话有噪音，噪音可以增强泛化能力。过大的话求解就针对这个训练集了
    - shuffle 随机取是可以保证所有样本都取一遍的，不放回

    ![image-20250414204603942](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250414204603942.png)

- 统计模型 损失函数长什么样
- 优化模型 用什么样的算法来求解
- 我们并不关心收敛的速度，而是收敛到哪一个位置，次优解可以有很多个
- 生成器生成数据是懒惰类型，不是一下全都生成，节省内存
- 线性模型的训练就是在找最适合的w和b。w是各参数的权重，b是偏移量

### SoftMax回归

![image-20250420135304952](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250420135304952.png)

![image-20250420134237041](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250420134237041.png)

![image-20250420134408925](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250420134408925.png)

- 对分类问题，如果类别间有自然顺序，可以转化为回归问题

- softmax函数能够将未规范化的预测变换为非负数并且总和为1，同时让模型保持

  可导的性质。

#### 损失函数
- L1损失 绝对值损失 会出现尖点
- L2损失 平方损失
- ![image-20250420141918333](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250420141918333.png)

​		优化较平滑

- 使用对数似然即使用负对数对softmax后的概率进行处理的目的是给错误的类添加更大的惩罚从而使得正确的类更加显著
- ~~对于交叉熵损失，我们只会得到独热编码为1时的那个类的概率,只关心对正确类的预测值的置信度~~
- 交叉熵损失可以很好的反映预测的概率和实际概率之间的差异

#### 图片分类数据集

- 训练的瓶颈可能在数据读取，在训练之前要batchMark测试一下，数据读取最好比训练要快

#### softMax回归手动实现

- 训练softmax回归循环模型与训练线性回归模型非常相似：先读取数据，再定义模型和损失函数，然后使用优化算法训练模型。大多数常见的深度学习模型都有类似的训练过程。

### 多层感知机

#### 感知机

- 感知机就是在线性模型的基础上套一层激活函数，使得输出由线性变为非线性

![image-20250427164403675](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250427164403675.png)

![image-20250427194314440](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250427194314440.png)

![image-20250427194633922](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250427194633922.png)

#### 多层感知机

![image-20250427200747243](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250427200747243.png)

- 隐藏层大小是超参数 代表隐藏层个数
- 这里b2=R是因为这里是单隐藏层，只需要一个偏置即可

![image-20250427210433271](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250427210433271.png)

- 为什么需要一个非线性激活函数？
  - 如果激活函数是线性的话，模型等价于单层的感知机
  - ![image-20250427211423992](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250427211423992.png)

##### 激活函数

- 主要用于避免层数塌陷。如果隐藏层只有一层，不加激活函数，一个感知机就退化成线性模型了

![image-20250427211819250](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250427211819250.png)

- 解决了x=0处不好求导的问题，是0-1分布的soft版本

![image-20250427211955627](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250427211955627.png)

- 解决了x=0处不好求导的问题，是-1-1分布的soft版本

![image-20250427212455555](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250427212455555.png)

- 好处是不用求指数，算得快。**最常用**

##### 多类分类

- 和之前的softMax没有本质区别

![image-20250427213052678](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250427213052678.png)

- 模型设计最好是金字塔型

![image-20250427220141130](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250427220141130.png)

#### 代码实现

- 交叉熵函数自带softMax

#### QA

- 最好别用SVM，不好转其他模型
- ![image-20250428150057779](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250428150057779.png)
  - 左边这种不好训练，且容易过拟合
- 激活函数的本质是引入非线性性。他的重要程度低于选择隐藏层大小等的超参数

### 模型选择 + 过拟合和欠拟合

#### 模型选择

- 训练数据集 用于调整权重、偏置等模型参数

- 验证数据集 用于调整超参数（模型训练之前需要手动设置的参数，它们不能通过模型的训练过程自动学习得到，而是需要通过在验证集上进行实验和调优来确定。超参数的选择会影响模型的学习速度、复杂度和泛化能力等。）

  要独立于训练数据集，不能参与训练（会导致验证结果虚高）

- 测试数据集用于测试模型最终训练结果，不可以在这个数据集上训练

![image-20250428162716622](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250428162716622.png)

- 数据集大小不够的解决方法
  1. 用于确定超参数，然后在此基础上重新训练模型
  2. 直接找选定超参数后K折里精度最好（或随便）的一折，选择该模型，不再重新训练。
  3. 每折得出的模型都用上，对测试集使用后求均值

![image-20250428171307608](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250428171307608.png)

#### 过拟合、欠拟合

![image-20250428172738663](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250428172738663.png)

![image-20250428173009988](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250428173009988.png)

- 首先模型容量得够，然后再去控制误差。一定的过拟合是可以承受的

![image-20250428173624295](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250428173624295.png)

![image-20250428181239108](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250428181239108.png)

- 模型复杂度可以通过VC维来量化，就是这个模型所完美分类一个数据集的最大的大小

![image-20250428181844410](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250428181844410.png)

#### QA

- 神经网络是不那么直观，但是编程性比较好的一种框架

- 调参数其实就是在调超参数，欠拟合、过拟合就是在暗示什么样的参数是好的
  - 超参数的设计靠
    1. 经验
    2. 一个一个试，根据上一个的效果优化下一个
    3. 随机选取
- 如果数据集比较小且不均衡，验证数据集最好均衡一下
  - 其实不然，应该考虑现实世界是什么样子的，如果现实世界ushijie也是不均衡的，那就保留这种不均衡，保证在主流部分的精确性
  - 如果只是采样偏差，可以对小的那个进行加权
- CNN（空间信息）本质上是一个mlp，RNN同理（时序信息。都是通过神经网络来描述对问题的理解
- 艺术、工程、科学
- 如果在验证数据集上loss发生了先下降在上升，就是发生了过拟合

### 权重衰退

- 最常见用于处理过拟合的方法
- 缩小模型的容量
  1. 限制参数的个数
  2. 限制参数的域

![image-20250430084418721](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250430084418721.png)

![image-20250501092905197](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250501092905197.png)
