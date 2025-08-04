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

## 杂项

- 炼丹步骤

  - 1.建立网络 2. 损失函数 3. 优化器（根据反向传播求得梯度 用优化器更具体的来更新参数） 4. 从训练集取出数据，进行训练，先梯度清0，算损失，反向传播，然后优化
- 找paper
- 注意广播机制可能会改变张量的形状
- 使用切片机制实现对张量的原地操作
- 机器学习的核心就是处理缺失数据
- 矩阵乘法其实是在做一个空间变换
- 机器学习求解核心思想：求解梯度变换最快的方向

![矩阵计算](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250411104049378.png)

![image-20250413172908015](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250413172908015.png)

![截图 2025-04-13 19-09-06](<https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/截图> 2025-04-13 19-09-06.png)

![截图 2025-04-13 19-08-03](<https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/截图> 2025-04-13 19-08-03.png)

![截图 2025-04-13 19-14-28](<https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/截图> 2025-04-13 19-14-28.png)

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
- A.sum(axis=0)对矩阵某一维度进行求和，第0维是竖着的，对应默认向量是列向量
- **范数**（英语：Norm），是具有“长度”概念的[函数](https://zh.wikipedia.org/wiki/函數)。在[线性代数](https://zh.wikipedia.org/wiki/線性代數)、[泛函分析](https://zh.wikipedia.org/wiki/泛函分析)及相关的数学领域，是一个[函数](https://zh.wikipedia.org/wiki/函數)，其为[向量空间](https://zh.wikipedia.org/wiki/向量空間)内的所有[向量](https://zh.wikipedia.org/wiki/向量)赋予非零的正**长度**或**大小**。另一方面，**半范数**（英语：seminorm）可以为非零的[向量](https://zh.wikipedia.org/wiki/向量)赋予零长度。

  ![image-20250412081934431](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250412081934431.png)

![image-20250412175358645](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250412175358645.png)

- 神经网络层数->看带权重的层有几层

## 深度学习基础

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

```
优化较平滑
```

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

- 主要用于避免层数塌陷，给模型增加非线性性。如果隐藏层只有一层，不加激活函数，一个感知机就退化成线性模型了

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

- 首先模型容量得高，然后再去控制误差。一定的过拟合是可以承受的

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

![image-20250501173935715](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250501173935715.png)

- ~~先把当前的权重做一次缩小，再做梯度下降~~
- 权重衰退就是在正常梯度更新的基础上对更新幅度做一个缩放

### 丢弃法

- 在层之间加入噪音

![image-20250502054006998](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250502054006998.png)

![image-20250502054154310](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250502054154310.png)

- 作用在全连接隐藏层的输出上
- 正则项b只在训练中使用，会对权重产生影响
  - 在推理中dropout直接返回输入
- 缩小隐藏层个数（不是隐藏层层数）效果不如隐藏层个数偏大+大dropout率

![image-20250502054834697](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250502054834697.png)

#### QA

- 由于使用了随机丢弃导致dropout有随机性。通过固定randonSeed可以使结果可重复

### **数值稳定性**

- 神经网络变得比较深时，数值非常容易不稳定
- 两个常见问题 都是由于网络比较深导致的

  1. 梯度爆炸

     ![image-20250501185052728](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250501185052728.png)
  2. 梯度消失

     ![image-20250501185601130](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250501185601130.png)

#### 模型初始化、激活函数（听不懂）

![image-20250501190434989](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250501190434989.png)

- 归一化的定义是将数据按照一定的规则进行变换，使其落入一个特定的区间或满足特定的统计特性。其主要目的是消除数据特征之间的量纲差异和尺度差异，让不同特征在数值上具有可比性。例如，在一个数据集中，特征 A 的取值范围是 1 到 1000，而特征 B 的取值范围是 0 到 1，若直接对数据进行分析或建模，特征 A 可能会因其较大的数值范围而对结果产生过大的影响，归一化可以解决这个问题。
- 权重初始化

![image-20250508163034275](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250508163034275.png)

- 权重初始化时的方差是根据输入和输出维度来确定
- 保证均值为0,方差是固定范围内的一个数

![image-20250508164107027](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250508164107027.png)

![20250706222047](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250706222047.png)

#### QA

- 数学底蕴很重要
- 限制的特征的范围，是在不损失模型的表达性的基础上的。主要目的是方便硬件处理，不会出现梯度爆炸和消失
- 所有的深度学习都是在解决数值稳定性的问题

### kaggle预测房价实战

- 用log来缩放一下数值较大的特征
- adam优化函数相对sgd来说对学习率没那么敏感
- 不可以在浅层网络上调参数然后运用到深层网络上，因为层数也是一个超参数。但是可以先用小容量数据来调

## 卷积神经网络

### 16 PyTorch 神经网络基础

- Sequential对象其实就是一个拿来装Linear (),ReLu()等方法(网络的层)的顺序容器
- 可以通过net[x]来访问x层
- 将复杂的网络模块化、多个模块嵌套构建最终的网络
- apply函数的功能是将传入的函数应用到指定的module上，不只是初始化，做什么都行
- 复用同一层可以达到共享权重的目的
- 80%的时间 做数据，20%的时间调模型。好的数据的重要性远大于模型
- 要有阶段性目标 要做什么、要获得什么成长

- 通过 net.state_dict() 可以直接将整个网络的全貌打印出来
- python列表推导式
![20250703000152](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250703000152.png)
- 为什么共享参数是个好主意？

  解答：

    1. 节约内存：共享参数可以减少模型中需要存储的参数数量，从而减少内存占用。

    2. 加速收敛：共享参数可以让模型更加稳定，加速收敛。

    3. 提高泛化能力：共享参数可以帮助模型更好地捕捉数据中的共性，提高模型的泛化能力。

    4. 加强模型的可解释性：共享参数可以让模型更加简洁明了，加强模型的可解释性。

### 19 卷积层

#### 卷积

- 图片匹配原则
  - 平移不变形
  - 局部性

![image-20250513154051254](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250513154051254.png)

- 卷积是一种特殊的全链接层
- 卷积核就是那个W（权重）
- **全连接层**：像 “全班大讨论”—— 每个人的发言都被所有人听到，信息全面但嘈杂。
- **卷积层**：像 “小组讨论”—— 每个人只和前后左右的同学交流，聚焦局部信息，效率更高。
- **池化层**：像 “小组代表发言”—— 每组选一个代表总结观点，压缩信息但保留关键特征。

![image-20250514184213823](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250514184213823.png)

![image-20250514184650756](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250514184650756.png)

![image-20250514184752711](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250514184752711.png)

#### 卷积层

![image-20250514185220175](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250514185220175.png)

- 动画里使用的是3*3的核
- 相当于利用卷积核将高维的输入映射为低维的输出

![image-20250514185549062](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250514185549062.png)

- 图中的星型计算就是上节定义的二维交叉计算
- 那个输出（）*（）指的是 高* 宽 是输出矩阵的大小

![image-20250514185917949](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250514185917949.png)

- 选用不同的核函数可以对图像进行不同的处理
- 卷积核：有正有负和为0是边缘检测、全为正和为1是均值滤波、高斯权重的均值滤波是高斯平滑/模糊

![image-20250514190238280](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250514190238280.png)

- 卷积和交叉相关是中心对称的关系。
- 实际实现的是交叉相关

![image-20250514190502556](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250514190502556.png)

- 气象地图多一个时间轴

![image-20250514190541701](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250514190541701.png)

- 核矩阵大小控制着局部性。大一点看到的部分多一点
- 卷积解决了之前随着输入变大权重矩阵变得特别大的问题。因为核函数是固定大小的

#### QA

- 窄而深的模型效果很多时候比宽而浅的好。对卷积和全链接层都是
- 全链接层最大的问题是权重W矩阵的高度（高指的是参数矩阵的行数）取决于输入矩阵的宽。当输入维度太大就炸了
- 全连接层输入层要为每个输入分配权值，而卷积是共享权值。不管输入维度多大，核的大小是固定的

### 20 卷积层里的填充和步幅

- 填充和步幅是卷积中的两个超参数

![image-20250517204818767](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250517204818767.png)

- 有一个问题是输入不能小于卷积核大小
- 卷积核通常不会选用很大的
- 解决方法

#### 填充

![image-20250517205105859](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250517205105859.png) ![image-20250517205426100](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250517205426100.png)

- 要注意在pytorch中的padding指的是一边的，等于这里的p/2

#### 步幅

![image-20250517205926626](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250517205926626.png)

![image-20250517210346114](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250517210346114.png)

![image-20250517210724464](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250517210724464.png)

![image-20250517210956840](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250517210956840.png)

#### QA

- 核大小通常是最关键的参数
- 步幅是为了减小输出 可以加速卷积的速度
- 填充的主要目的，是为了让卷积核更多地识别到边缘信息，而不是为了控制输入输出大小
- kernel边长通常为奇数。padding=kernel-1，而padding是分在图片上下的，kernel为奇数，padding就可以对半分。
- 第一层如果是3x3的filter的话，第二层中一块3x3的区域就包含了输入中一块5x5的区域的信息(stride=1)。卷积核小就把层数弄深一点
- 机器学习本质上是信息筛选过滤压缩
- 较大的卷积核配上较浅的网络可以等效小而深的，但是时间复杂度和核的高*宽相关。因此较大的卷积核训练会比较贵

### 21 卷积层里的多输入多输出通道

![image-20250608200444356](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250608200444356.png)

![image-20250608200955663](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250608200955663.png)

- 对每个输出通道都有一个自己的三维卷积核
- 输入和输出通道间没有太多相关性

![image-20250608201830906](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250608201830906.png)

![image-20250608202353241](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250608202353241.png)

![image-20250608202821679](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250608202821679.png)

![image-20250608202834174](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250608202834174.png)

- 输入是前一层的超参数
- 这里针对的是多输入多输出通道卷积层的介绍
- 多输出层依赖三维卷积核，该层做完卷积每个通道对应位置也相加，第三维维度大小对应对输出通道通道数

#### QA

- “不同通道的卷积核是一样的”，其实是不同通道的同一个输出通道的卷积核是一样的

- ”每个通道的卷积核是不一样的“，是因为有多少个输出通道就有多少种卷积核
- 这里针对二维卷积，对加上深度的图像不适用
- 卷积层参数共享指的是整个图像用同一个卷积核来扫描，和全连接网络相比共享了参数

### 22 池化层

![image-20250612075508563](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250612075508563.png)

- 和核差不多，不过一个是计算一个是选最大值输出
- 允许边缘有抖动，增强特征的平移不变形

![image-20250612080042592](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250612080042592.png)

![image-20250612080240090](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250612080240090.png)

![image-20250612080442511](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250612080442511.png)

- 步幅和窗口大小相同意味着投影不会有重叠
- 池化是在每个通道上做的，不会把通道合并

### 23 经典卷积神经网络 LeNet

![image-20250612104930013](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250612104930013.png)

![image-20250612105006724](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250612105006724.png)

- 每个通道的信息可以认为是一个空间的pattern
- 一般的训练策略是高宽减半通道数翻倍
  - 像素密度增大了，就是说输出通道数增加，每个同位置像元包含，多个通道信息，一个通道可理解为提取出一个特征信息。

- ![image-20250612121614356](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250612121614356.png)
  - 多输出通道
  - 16组，每组有6个卷积核 分别与6个通道的输入 进行互相关运算然后相加，最后把16个叠在一起

- 输出通道可以认为是匹配了某一种特定的模式

### 24 深度卷积神经网络 AlexNet

- dense：稠密层也称做全连接层，就是把特征提取成一维帮助最后分类

![image-20250612165934100](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250612165934100.png)

### 25 使用块的网络 VGG

![image-20250613171735925](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250613171735925.png)

![image-20250613172215249](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250613172215249.png)

- VGG（Visual Geometry Group）的核心思想是通过堆叠多个小卷积核（如 3×3）的卷积层来替代大卷积核（如 7×7、5×5）的卷积层，从而在保持相同感受野的同时减少参数量，并通过增加网络深度提升特征提取能力。

- vgg使用块替换掉了alexnet的卷积层

![image-20250613172727630](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250613172727630.png)

![image-20250613173045271](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/image-20250613173045271.png)

- 不要过度设计，尽量用简单的模型

### 26 网络中的网络 NiN

- 全连接层的问题
  - 特别占用参数空间
  - 过拟合
- nin的思想就是完全不要全连接层
![20250615230918](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250615230918.png)
- 1*1的卷积层等价于全连接层
![20250615231631](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250615231631.png)
- 最大池化层的作用是将高宽减半
- 最后应该是1000个通道， 每个通道一张图。 对每张图求平均， 就是1000个数。代表1000个类别的评分。
![20250615232000](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250615232000.png)
![20250615232116](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250615232116.png)
- 1×1 卷积层除了可实现通道维度变换等，还能引入非线性。因为 1×1 卷积层后一般会跟着激活函数（比如 ReLU ），每个像素经过 1×1 卷积计算以及激活函数处理，就给单个像素的特征变换增添了非线性，
- softmax 写在了traning中，所以网络定义中不需要再加softmax层  CrossEntropyLoss里面有Softmax

### 27 含并行连结的网络 GoogLeNet / Inception V3

![20250617174758](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250617174758.png)

- 输出时在通道维度做了合并。不改变高宽只改变通道数
- 高宽减半叫一个stage
![20250617182134](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250617182134.png)
![20250617183351](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250617183351.png)

### 28 批量归一化

- 在做很深的网络的时候这个是必须的层
- 批量规范化是在卷积层或全连接层之后、相应的激活函数之前应用的。
- 一般来说，BatchNorm可以在卷积层和全连接层之间使用，也可以在激活函数之前或之后使用。但是，并不是所有的层都需要使用BatchNorm，有时候使用过多的BatchNorm反而会降低模型性能。
- 批量归一化和暂退法一般是直接进行替换，不会同时用，因为二者都是起到正则项的作用

![20250618143543](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250618143543.png)

- 在反向传播过程中，梯度通过链式法则从输出层传递到输入层，由于链式法则的乘积形式，如果每一层的梯度范数小于1，那么经过多层的乘积后，梯度会指数级减小，从而导致梯度消失。

![20250618144017](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250618144017.png)

- 为什么会变化？
  - 每一层的方差和均值的分布都不一样
  - 固定住，使每一层都符合某一个分布
  - 但是计算总体损失的时候是逐个sample再求mean的，如果这些samples都符合某个分布会更方便
  - gama 和 beita 是通过学习得到的新的均值和方差

![20250618145432](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250618145432.png)
![20250618150400](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250618150400.png)
![20250618150458](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250618150458.png)

#### QA

- 模型稳定的情况下收敛不会变慢

### 29 残差网络 ResNet

- 加更多的层不一定能提升精度
- resnet的思路是在使用更大的层时，保证包含了之前的更小的层。这样至少不会让模型效果变差
![20250618163755](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250618163755.png)
![20250618164142](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250618164142.png)
![20250618164344](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250618164344.png)
![20250618165725](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250618165725.png)

### 29.2 ResNet为什么能训练出1000层的模型

![20250618180556](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250618180556.png)

## 计算机视觉

### 36 数据增广

![20250620085409](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250620085409.png)

- 增强一般在训练时使用、一般为在线生成且是随机进行增强
- 增强要合理
![20250620085830](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250620085830.png)
![20250620090022](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250620090022.png)
- 训练集的选取主要由实际会碰到的情况来决定。当部署的环境没有那么奇怪的结果可以不用考虑这种增强
![20250620090450](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250620090450.png)
- 图片增广不改变数据分布，改变方差
- mixup增广比较有效

### 37 微调

- 迁移学习是指将从一个任务（源任务）中学习到的知识或经验，迁移应用到另一个不同但相关的任务（目标任务）中，以提升目标任务的学习效率或性能，避免从零开始训练的机器学习方法论。其核心在于利用任务间的相关性实现知识复用，尤其适用于目标任务数据量少或标注成本高的场景。

 ![20250620122732](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250620122732.png)
![20250620123130](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250620123130.png)
![20250620123251](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250620123251.png)
![20250620123547](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250620123547.png)
![20250620123721](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250620123721.png)
![20250620123747](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250620123747.png)
![20250620123940](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250620123940.png)

- 给不是迁移过来的层使用更大的学习率
- 预训练模型的权重拿来用而不固定，你在你这个数据集上训练会有变化的，只是训练的epoch可以更少，模型更快收敛
- 尽量从微调开始进行训练

#### QA

- 越是接近输入 特征越通用

***

### 41 物体检测和数据集

- 边缘框 用于表示这个物体的位置，原点在左上角
![20250628175129](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250628175129.png)

#### QA

- 标注的时候先自己标一些然后通过迁移学习等方法训练一个模型，再把那些置信度低的类拿出来多标几张再训练模型

### 42 锚框

- 算法对边框位置的一个猜测
![20250628183034](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250628183034.png)
![20250628183441](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250628183441.png)
![20250628183850](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250628183850.png)
![20250628184324](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250628184324.png)
![20250628184548](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250628184548.png)
![20250628184930](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250628184930.png)
- 生成高质量的锚框很关键
- 总结：1.如何生成锚框 2.如何判断锚框有效 3.每个类保留一个锚框进行预测
- 处理训练样本三个重点:1.产生大量锚框，像素点*(s+r-1) 2.基于iou和label数据给锚框分类和偏移 3.nms精简非背景锚框，确保一个锚框对应一个目标

### 43 树叶分类竞赛技术总结

![20250630171417](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250630171417.png)
![20250630172646](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250630172646.png)
![20250630173005](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250630173005.png)
![20250630174332](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250630174332.png)

- 学术界更关心模型，工业界关心数据

- 实战时碰到的一些坑
  - 标准化不是 “必须” 的操作，其效果高度依赖数据与模型的匹配度。当你的数据分布与标准化参数（如 ImageNet 的均值 / 标准差）不兼容时，去掉标准化或使用自定义统计量，反而能让模型更好地学习数据特征，从而提升精度。
  - 如果要加标准化那训练集测试集等都得加，不然导致数据分布不同

***

### 44 物体检测算法：R-CNN，SSD，YOLO

- 区域卷积神经网络
![20250701161124](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250701161124.png)
![20250701161413](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250701161413.png)
![20250701161659](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250701161659.png)
- CNN 是卷积神经网络（Convolutional Neural Network）的缩写
![20250701162651](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250701162651.png)
![20250701163353](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250701163353.png)
![20250707111035](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250707111035.png)

- ssd 单阶段检测
![20250707111338](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250707111338.png)
![20250707111920](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250707111920.png)
- 主要思想是做多个分辨率下的检测
- 图片大，锚框不变，检测小物体
- 图片小，锚框不变，检测大物体
- 与之前的区别是没有rpn网络了，直接在生成的所有锚框上去预测
![20250707113046](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250707113046.png)
- yolo
  - 尽量让锚框不重叠
![20250707161826](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250707161826.png)
- 第三点为了解决多物体重叠问题
![20250707163659](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250707163659.png)

### 45 SSD实现(非常困难)

- 锚框信息通过loss进入神经网络

***

### 46 语义分割和数据集

![20250712153758](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250712153758.png)

- 目标检测分割太过粗糙，需要更细致的分割
- 语义分割是像素级别的分割
- 语义分割处理时不好做缩放处理，因为新多出来的像素和标号不好对应

### 47 转置卷积

![20250713175402](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250713175402.png)

- 无法通过padding进行有效的增大高宽
- 对语义分割来说，是对像素级的pixel进行分割，如果通过卷积的话，分辨率不停减小，不利于进行语义分割，因此需要另一种操作子
- 操作和卷积差不多相反
![20250713181029](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250713181029.png)
- 超参数一样的前提下，转置卷积相当于把对应卷积的输出变成输入的大小。注意是形状上的还原，而不是值的还原

#### QA

### 47.2 转置卷积是一种卷积

![20250717114537](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250717114537.png)
![20250717114752](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250717114752.png)
![20250717115030](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250717115030.png)

- 对转置卷积来说，加填充会使输出变小
![20250717115112](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250717115112.png)
- 对转置卷积来说，增加步幅会使输出成倍增加
![20250717115439](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250717115439.png)
- 这里的p指的是单边的填充数量
![20250717120114](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250717120114.png)
![20250717120131](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250717120131.png)

### 48 全连接卷积神经网络 FCN

![20250717170105](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250717170105.png)

- k是通道数，等价于有多少类
- 这节代码中的使用pretrain模型的方式值得学习。
  - 先取出pretrain模型中的参数，去除掉不要的层的参数
  - 把模型结构解包去除不要的层再丢进新的网络
  - 如此就得到了一个不含最后全连接层的网络
  
  ***

  ### 49 样式迁移

- 将样式图片的样式迁移到内容图片上，得到合成图片

![20250717182740](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250717182740.png)

- 看上去有三个cnn,其实只有一个，后两个网络是第一个的复制
- 目标是训练一个cnn,使得图片输入进网络时，在某一层的输入上匹配上内容图片，在某一层的输入上匹配上样式图片
- 样式匹配指的是 通道之间的统计分布和通道内的统计分布匹配的上
- 风格转移的损失函数是内容损失、风格损失、总变化损失的加权和
  - 这里的权重是老中医，目标是使这三个字在差不多一致的范围内，不要有数量级误差
- 训练是直接对着结果图片进行训练，最小化结果图片和风格图片、内容图片的损失。

### 50 课程竞赛：牛仔行头检测

![20250718112501](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250718112501.png)

- 解决类别不平衡
  - 调整采样
  - 权重

## 循环神经网络

### 51 序列模型

![20250721153307](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250721153307.png)
![20250721153430](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250721153430.png)
![20250721153819](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250721153819.png)
![20250721154301](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250721154301.png)

- 自回归模型（Autoregressive Model，简称 AR 模型）是一种用变量自身的历史数据来预测其未来值的时间序列模型。
- 核心思想就是求解 F 函数
![20250721154853](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250721154853.png)
![20250721155209](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250721155209.png)
- 需要训练两个模型，一个是算 h^ ，一个是算 x^
![20250721160650](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250721160650.png)

### 52 文本预处理

- 将文本当做一个时序序列
- 核心思想是怎么把词变成可以训练的东西
- token的常见单位划分
  - word 词
  - char 字
- “unk”unknow的意思，未知的token
![20250722212842](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250722212842.png)
![20250723184719](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250723184719.png)

- 注意常见错误
  - 使用特定模型时，未配套使用该模型训练时依赖的字典（词表）。

    具体来说，模型的训练基于特定的字典（包含其识别的词汇、字符及对应编码），若使用其他字典，会导致输入文本的编码与模型预期不匹配，进而引发语义理解偏差、推理错误等问题。例如，用 BERT 模型却用了 Word2Vec 的词表，会因词汇映射不一致导致模型无法正确解析输入。

### 53 语言模型

![20250725221332](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250725221332.png)
![20250725221829](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250725221829.png)
![20250725222350](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250725222350.png)

  马尔可夫假设是**简化序列概率计算**的常用方法，核心是“未来状态仅依赖于近期有限历史状态”，在自然语言处理的N元语法场景里，用于缓解长序列因数据不足导致的概率估计难题：

- **问题背景**：长文本序列（如很长的单词序列）因文本量有限，完整序列出现次数少（甚至≤1 ），难直接算概率。
- **假设核心**：认为一个元素的概率，仅与前面有限个（而非全部）元素相关，以此简化计算。比如二元语法中，某单词概率只依赖前一个单词；三元语法依赖前两个，依此类推。
- **实际作用**：让长序列概率计算更可行，通过“截断”历史依赖，用短序列组合估计长序列概率，是语言模型、文本生成等任务的基础简化思路 。

![20250725224017](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250725224017.png)

- 两种不同的data_iter构造思路
  - 使用随机抽样生成一个小批量子序列 批量之间的关系是随机的
  - 使用顺序分区生成一个小批量子序列 批量之间是顺序关系 可以拿到更多空间信息

### 54 循环神经网络 RNN

![20250726211108](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250726211108.png)
![20250726212609](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250726212609.png)

- RNN本质也是MLP
- 计算损失时是比较ot和xt之间的损失，但是xt是用来更新ht+1的
- Whx是隐藏层的权重
- 最简单的RNN是通过whh来存储时序信息的

![20250726211702](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250726211702.png)
![20250726213704](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250726213704.png)

- 语言模型说白了就是一个分类问题，预测一个长为n的序列就做n次评估，即n次交叉熵的平均
- 困惑度就是平均交叉熵取指数
- 当困惑度为K时。可以认为下一个词有K种可能，相对平均交叉熵更加直观

![20250726214249](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250726214249.png)

- g是所有层的梯度放在一起构成的向量
- 保证长度永远不会超过sita

![20250726214437](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250726214437.png)

![20250726214927](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250726214927.png)

- 从具体时间点来看其实就是一个多分类问题
- pytorch的rnn层不包括输出层。要自己加
- 嵌入表示（Embedding）

### 56 门控循环单元（GRU）

- 解决隐藏序列中不是所有信息同等重要、RNN隐藏信息无法做的太长的问题

![20250728173147](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250728173147.png)

![20250728174723](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250728174723.png)

- 激活函数使用的是sigmoid
- 等价于一个全连接层

![20250728175329](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250728175329.png)

- 点圈代表按元素乘法
- Rt属于0～1，是一个可以学习的参数。当Rt的元素趋近于0时相当于忘记对应的隐藏状态

![20250728175815](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250728175815.png)

- Zt的取值范围为0～1，取1时相当于不更新隐藏状态

![20250728180036](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250728180036.png)

在 PyTorch 中，`@` 符号表示矩阵乘法运算，类似于 NumPy 中的 `@` 运算符，也等价于 PyTorch 中的 `torch.matmul()` 函数。

它主要用于两个张量（Tensor）之间的矩阵乘法操作，具体行为会根据张量的维度自动调整：

- 对于两个二维张量（矩阵），`@` 执行标准的矩阵乘法（(n×m) 矩阵 × (m×p) 矩阵 = (n×p) 矩阵）
- 对于高维张量，`@` 会在最后两个维度上执行矩阵乘法，前面的维度被视为批次维度

示例：

```python
import torch

# 二维矩阵乘法
a = torch.tensor([[1, 2], [3, 4]])
b = torch.tensor([[5, 6], [7, 8]])
c = a @ b  # 等价于 torch.matmul(a, b)
print(c)
# 输出:
# tensor([[19, 22],
#         [43, 50]])
```

需要注意的是，`@` 与 `*` 运算符不同，`*` 在 PyTorch 中表示元素-wise 乘法（哈达玛积），而 `@` 才是真正的矩阵乘法。

### 57 长短期记忆网络（LSTM）

![20250804202919](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250804202919.png)
![20250804203010](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250804203010.png)

- 候选记忆单元相当于之前rnn的Ht隐藏层
![20250804203215](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250804203215.png)
![20250804203427](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250804203427.png)

- 由于 Ct-1 范围较大导致 Ct 范围大，无法保证 -1～1 的取值范围。通过 tanh 来控制数值范围
![20250804203838](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250804203838.png)

![20250804203936](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250804203936.png)

-  RNN、GRU、LSTM 的本质区别就在于是如何更新 H 
-  

### 58 深层循环神经网络


### 61 编码器-解码器架构

![20250707211927](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250707211927.png)
![20250707212031](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250707212031.png)
![20250707212114](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250707212114.png)
![20250707212226](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250707212226.png)

### 62 序列到序列学习（seq2seq）

![20250707212654](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250707212654.png)
![20250707212705](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250707212705.png)
![20250708093120](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708093120.png)
![20250708093247](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708093247.png)
![20250708093410](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708093410.png)

- n-gram是n个词的意思，比如p1就是match一个词的个数占所有词的比例
- bleu越大越好
![20250708094017](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708094017.png)

### 63 束搜索

![20250708094205](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708094205.png)
![20250708102421](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708102421.png)
![20250708102944](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708102944.png)
![20250708103210](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708103210.png)

- $\frac{1}{L^a}$ 用于正补偿长句子
![20250708103656](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708103656.png)
- n时不是穷举

### 64 注意力机制

![20250708104040](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708104040.png)
![20250708104149](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708104149.png)
![20250708104453](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708104453.png)
![20250708134225](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708134225.png)

### 65 注意力分数

### 68 Transformer

![20250708134612](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708134612.png)
![20250708135026](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708135026.png)
![20250708135050](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708135050.png)
![20250708135229](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708135229.png)
![20250708135345](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708135345.png)

- ffn实际上就是一个全连接
![20250708135604](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708135604.png)
- 这里是对每个样本进行归一化。因为输出长度会改变导致预测不稳定
![20250708140138](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708140138.png)
![20250708140336](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708140336.png)
![20250708140539](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250708140539.png)
