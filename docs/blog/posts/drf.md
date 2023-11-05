---
authors: 
    - Jagger
categories:
  - 技术分析
date: 2023-11-04
draft: true
comments: true
---
# django rest framework-一个基于Django的REST框架，用于构建Web API

接下来我会分享关于我在学习drf过程中的一些心得体会，以及一些遇到的问题和解决方法。
<!--more-->

## FBV&CBV

### fbv-function base view

要通过手动的方式对不同的请求方式进行处理

### cbv-class base view

django原生cbv： 通过继承View类，调用View中的dispatch实现不同请求方式的路由

基于drf的cbv：

## request对象

drf中的request不是原生的，它对django中原有的request进行了封装，封装了request.data，request.query_params等属性，方便我们使用

## 一些零碎的点

1. 创建django项目时，通过指定目录可以将项目创建在当前目录而不是当前目录的子目录

    ```python
    django-admin startproject day13 .  #.代表在当前目录下创建项目
    ```

    在表示相对路径中，单点表示当前目录，双点表示上一级目录，反斜杠“/”表示分隔目录；

    相对路径特殊符号有以下几种表示意义：

    - 以“./”开头，代表当前目录和文件目录在同一个目录里，“./”也可以省略不写！

    - 以"../"开头：向上走一级，代表目标文件在当前文件所在的上一级目录；

    - 以"../../"开头：向上走两级，代表父级的父级目录，也就是上上级目录，再说明白点，就是上一级目录的上一级目录

    - 以"/”开头，代表根目录

2. 应用drf时首先要在settings.py中注册。因为可能要用到它的模板和静态文件。django会去已经注册了的app中寻找
3. oop：面向对象
