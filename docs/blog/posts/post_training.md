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

![](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/202605290839999.png)

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
