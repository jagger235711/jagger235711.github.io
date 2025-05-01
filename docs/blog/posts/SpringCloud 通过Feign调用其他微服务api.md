---
date: 2023-10-11
authors: 
    - Jagger
categories:
    - 技术分享
    - springCloud
comments: true
---

# springCloud-desk微服务远程调用springCloud-user微服务方法

本文以一次实际开发经历为例，介绍了微服务间远程调用的方法，并探讨了用feign替代controller的可行性。
<!-- more -->

## 预先准备

1. springCloud-user中已经存在要被调用的方法
    - 在springCloud-user中创建新的controller
        - 注意在开头定义要调用的service
    - 在controller中编写方法，此时需要调用service处理具体的业务逻辑
    - 转到service层编写要被调用的service接口`sayHello（）`
    - 转到serviceImpl层编写接口实现
        - 注意实现类要继承接口
    - 检查controller、service、serviceImpl是不是对应了
    - 如果没有对数据库的操作，该方法就已经编写完成，可以启动user模块测试方法
        - 当编译时出现找不到符号的情况
            - 可能是因为其他模块有改动，重新编译一下整个项目

## 正式开始编写feign调用

1. 在要被调用微服务的api模块中创建feign的接口（springCloud-user-api）（`testUserClient`）
    - 使用`@FeignClient//定义Feign指向的service-id 即由springCloud-user-api->springCloud-user`注解指向要被调用的微服务模块
2. 返回被调用微服务的模块（springCloud-user），增加feign的实现类，填充要被调用的本模块的service
    1. 注意通过feign调用时，调用模块（springCloud-desk）改动很小,主要改动在被调用模块，要增加`testUserClient`。和被调用模块的api包中`testUserClientImpl`，再在`testUserClientImpl`中填写要被调用的service`testUserService`。service`testUserService`和feign`testUserClientImpl`应该是在同一模块中。
3. 转到调用微服务的模块`springCloud-desk`
    1. 在pom中引入被调用的api包`springCloud-user-api`
    2. 去controller部分创建新的controller调用client
4. 同时启用两个微服务，向调用微服务的模块发送请求
5. 请求路径
    1. desk
        1. 通过请求`/say-hello-from-desk` 找到方法并调用
        2. 调用其中client的sayHello方法
        3. 通过pom文件去找feign
    2. user
        1. 在client中找到sayHello方法
        2. 去clientImpl中调用方法实现
        3. clientImpl去service找sayHello方法的接口
        4. 去serciveImpl中找方法的实现并执行

### desk

```shell

 : Mapped to public java.lang.String org.springCloud.desk.controller.TestDeskDoUserFeignController.testDeskDoUserFeign_sayHello()
    : --> GET <http://ip/testFeign/say-hello>
    : Accept: */*
    : --> END GET
    : <-- 200 OK <http://ip/testFeign/say-hello> (7ms)
    : Content-Type: text/plain;charset=UTF-8
    : Content-Length: 5
    : Date: Mon, 09 Oct 2023 07:23:30 GMT
    :
    : hello
    : <-- END HTTP (5-byte body)

```

### user

```shell

 : Mapped to public java.lang.String org.springCloud.system.user.feign.TestUserClientImpl.sayHello()

```

## 进阶情况

### springCloud-desk微服务远程调用springCloud-user微服务且涉及到访问数据库的情况

在之前操作的基础上

1. 配置MyBatis-Plus
2. 配置MyBatis-Plus的mapper
3. 配置MyBatis-Plus的mapper.xml
4. 在对应service中通过baseMapper调用mapper的方法
5. 如有需要配置各种POJO对象

### 使用Feign与原生Controller的比较

在feignClient之上也可以加上@PostMapping这类注解。意味着feign可以代替controller使用。不过通过feign调用本模块的服务资源开销相比通过controller要大一点，但是只在大规模的系统中才能体现出来。
