---
authors: 
    - Jagger
categories:
    - 技术分享
date: 2024-04-01
draft: true
comments: true
---

# SpingCloud微服务框架学习

学习SpingCloud微服务框架时的笔记，[视频地址](https://www.bilibili.com/video/BV1gW421P7RD)。
<!--more-->

# 一些常见错误
1. 当远程调用由本地转为向consul注册中心注册时，由于consul天生支持负载均衡，如果远程调用不添加远程调用支持就会报错`运行时异常:I/O error on GET request for "http://cloud-payment-service/pay/get/1": cloud-payment-service`需要修改配置文件，给远程调用添加负载均衡支持。`@LoadBalanced`。
   

    底层的原因是： 引入微服务名字，按照微服务名称调用，默认后面是多个微服务，默认负载均衡和轮询，所以必须给 `restTemplate` 加上负载均衡

# 顺便听到的面试题
1. CAP
   1. 什么是CAP？
      1. CAP即：

          Consistency（一致性）

          Availability（可用性）

          Partition tolerance（分区容忍性）

          这三个性质对应了分布式系统的三个指标：

        ![20240406114035](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/20240406114035.png)

          而CAP理论说的就是：一个分布式系统，不可能同时做到这三点。

          最多只能同时较好的满足两个。

          CAP理论的核心是：一个分布式系统不可能同时很好的满足一致性，可用性和分区容错性这三个需求，

          因此，根据 CAP 原理将 NoSQL 数据库分成了满足 CA 原则、满足 CP 原则和满足 AP 原则三 大类：

          CA - 单点集群，满足一致性，可用性的系统，通常在可扩展性上不太强大。

          CP - 满足一致性，分区容忍必的系统，通常性能不是特别高。

          AP - 满足可用性，分区容忍性的系统，通常可能对一致性要求低一些。
      
   2. 几种注册中心的异同
    ![20240406115432](https://cdn.jsdelivr.net/gh/jagger235711/coooool/img/20240406115432.png) 
