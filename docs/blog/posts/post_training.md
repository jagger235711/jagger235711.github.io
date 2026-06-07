---
draft: true 
date: 2026-05-28 
categories:
  - 技术分享
authors: 
    - Jagger
comments: true
---

# 后训练学习

<!-- more -->

## intro

- 监督式微调 SFT supervised fine-tuning
  - 在有标记的问答对上训练模型学习如何遵循指令或者通过复现 “输入提示词 → 期望响应” 的对应关系，来（让 AI）学会使用工具。
  - 对于引入新行为特别有效或对模型进行重大修改
- 直接偏好微调 DPO direct preference optimization
  - 通过展示好答案和坏答案来教导模型
  - 通过对比损失推动模型接近好的响应，远离坏的响应  
- 在线强化学习
  - 人类提供提示，模型产生响应，奖励函数对答案质量进行评分，模型根据奖励分数进行更新
    - 训练奖励模型的方式
      - 以人类对响应质量的判断开始，训练一个和人类判断一致的函数来打分
        - 近端策略优化 PPO proximal policy optimization
        - 可验证奖励 verifiable rewards
          - 适用有客观正确性度量的任务，例如数学和编程
          - 通过数学检查器或者单元测试来验证正确性
          - 这种客观对错构成奖励函数

  - 分组相对策略优化 GRPO grouped relative policy optimization

  ## introduction to post training

### what

  ![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605290833955.png)

### how

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605290951922.png)

- respond是模型应该回应的理想回复
- 只对response的token进行训练

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605290846879.png)

- 在线强化学习
  - 让模型自己生成回复，并用奖励模型打分，使用奖励信号更新模型
  - 同时最大化prompt和response
  
![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605290850129.png)

- 算法和数据的良好协同设计是成功后训练的重要因素
- 评估套件用于跟踪模型性能确保模型表现良好

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605290854507.png)

- 改进任何一个基准都很容易，难的是不让其他领域的能力下降

### when

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605290916835.png)

1. 特定领域大模型  ：让模型先学知识，然后学会如何与用户交谈
2. 严格遵循有限个指令或需要提升某个领域的能力

- 用于可靠地改变某个领域的能力，如果训练有误可能会降低其他没有训练的能力
![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605290924180.png)

## basics of SFT

- 经过预训练之后的LLM只有token补全的功能，即自回归的预测下一个token
- 对于通过在标注数据上经过SFT之后的LLM，可以变成聊天助手等各种自定义用途

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605301424137.png)

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605301427430.png)

- loss公式可以进一步地写成每个token生成概率的乘积的形式

### SFT最佳用例

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605301432294.png)

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605301436152.png)

- SFT需要模仿提供的所有数据，如果数据集中有低质量数据模型会被污染。所以质量大于数量

### 全量微调和参数高效微调

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605301441439.png)

- 节省大量内存、计算更高效
- 学习到的更少，忘记的也更少
- 这两种方法和后训练方法是并行的，可以兼容

## basics of SFT

- 经过预训练之后的LLM只有token补全的功能，即自回归的预测下一个token
- 对于通过在标注数据上经过SFT之后的LLM，可以变成聊天助手等各种自定义用途

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605301424137.png)

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605301427430.png)

- loss公式可以进一步地写成每个token生成概率的乘积的形式

### SFT最佳用例

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605301432294.png)

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605301436152.png)

- SFT需要模仿提供的所有数据，如果数据集中有低质量数据模型会被污染。所以质量大于数量

### 全量微调和参数高效微调

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605301441439.png)

- 节省大量内存、计算更高效
- 学习到的更少，忘记的也更少
- 这两种方法和后训练方法是并行的，可以兼容

---
## SFT
- 主要是学习输入数据的格式和知识，一般不用于调整风格
- 通过在模板中添加prompt可以调整风格，会导致问答能力下降。容易答非所问

问题

```
tokenizer.chat_template = """

{% for message in messages %}

{% if message['role'] == 'system' %}System: {{ message['content'] }}\n

{% elif message['role'] == 'user' %}User: {{ message['content'] }}\n

{% elif message['role'] == 'assistant' %}Assistant: Meow~{{ message['content'] }}Meow~ <|endoftext|>

{% endif %}

{% endfor %}

  

"""
```
	
- 这里的一个问题就是在模板格式中在加入固定字符Meow~后模型是否会看到和学习- 
	- 不理解为啥不行，反正记住SFT从数据集中学习就行了。在模板中加东西没用

## DPO
- 一种对比学习方法
- 通常使用一个指令型LLM作为起点
![](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20260607124137731.png)
- 贝塔越高代表这个对数差异越重要
![](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20260607121727440.png)

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20260607122202633.png)

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20260607123305687.png)
- 从模型本身收集同一个问题的多个响应，排序好坏响应
- 避免模型学到正面响应的通用特征。比如都有一些特殊词等。如果这样的话这个数据集上的训练会非常脆弱

---
## SFT
- 主要是学习输入数据的格式和知识，一般不用于调整风格
- 通过在模板中添加prompt可以调整风格，会导致问答能力下降。容易答非所问

问题

```
tokenizer.chat_template = """

{% for message in messages %}

{% if message['role'] == 'system' %}System: {{ message['content'] }}\n

{% elif message['role'] == 'user' %}User: {{ message['content'] }}\n

{% elif message['role'] == 'assistant' %}Assistant: Meow~{{ message['content'] }}Meow~ <|endoftext|>

{% endif %}

{% endfor %}

  

"""
```
	
- 这里的一个问题就是在模板格式中在加入固定字符Meow~后模型是否会看到和学习- 
	- 不理解为啥不行，反正记住SFT从数据集中学习就行了。在模板中加东西没用

## DPO
- 一种对比学习方法
- 通常使用一个指令型LLM作为起点
![](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20260607124137731.png)
- 贝塔越高代表这个对数差异越重要
![](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20260607121727440.png)

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20260607122202633.png)

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20260607123305687.png)
- 从模型本身收集同一个问题的多个响应，排序好坏响应
- 避免模型学到正面响应的通用特征。比如都有一些特殊词等。如果这样的话这个数据集上的训练会非常脆弱