---
authors: 
    - Jagger
categories:
  - 技术分享
date: 2023-11-04
draft: true
comments: true
---
# drf框架学习分享

django rest framework-一个基于Django的REST框架，用于构建Web API

接下来我会分享关于我在学习drf过程中的一些心得体会，以及一些遇到的问题和解决方法。
<!--more-->

## FBV&CBV

### fbv-function base view

要通过手动的方式对不同的请求方式进行处理

### cbv-class base view

django原生cbv： 通过继承View类，调用View中的dispatch实现不同请求方式的路由

基于drf的cbv：

## request对象

drf中的request不是原生的，它对django中原有的request进行了封装，封装了request.data，request.query_params等属性，方便我们使用。

但是可以通过drf中的request.xxx（相当于request._request.xxx）获取到django中的request.xxx属性。因为drf中使用了`getattr()`方法，使得这些查找参数的过程对我们透明了。

```python
 def __getattr__(self, attr):
        """
        If an attribute does not exist on this instance, then we also attempt
        to proxy it to the underlying HttpRequest object.
        """
        try:
            return getattr(self._request, attr)
        except AttributeError:
            return self.__getattribute__(attr)
```

## 反射

在Python中，反射是指在运行时通过字符串的形式来访问、调用、修改或创建对象、模块、函数、类等的属性和方法的能力。反射使得我们可以根据程序运行时的状态来动态地操作对象，而不需要事先编写固定的代码。

Python中的反射主要借助于以下几个内置函数和特殊方法：

`getattr(object, name[, default])`：用于获取对象的属性或方法。参数object是待操作的对象，name是属性或方法的名称，default是可选参数，表示如果属性或方法不存在时返回的默认值。

`setattr(object, name, value)`：用于设置对象的属性或方法。参数object是待操作的对象，name是属性或方法的名称，value是要设置的值。

`hasattr(object, name)`：用于判断对象是否具有指定的属性或方法。参数object是待操作的对象，name是属性或方法的名称。

`delattr(object, name)`：用于删除对象的属性或方法。参数object是待操作的对象，name是属性或方法的名称。

`__dict__`：是一个特殊的字典属性，包含了对象的所有属性和方法。可以通过字典的方式操作这些属性和方法。

反射的使用可以在很多场景中发挥作用，比如动态地调用函数、根据用户输入执行不同的方法、动态地创建类或对象等。但需要注意，由于反射是基于字符串的，因此在使用时要注意安全性和错误处理，避免操控不当导致意外的结果。

在Python中，反射是指通过字符串来访问对象的属性和方法。通常情况下，我们会直接使用对象的属性或方法，比如`obj.attribute或obj.method()`。但是有时我们需要根据运行时的情况动态地访问对象，而不是提前知道需要访问的属性或方法的名称。

反射提供了一种灵活的方式来实现这个目的。我们可以通过字符串来获取对象的属性或方法，而不需要直接使用属性或方法的名称。这使得我们可以在运行时根据需要进行操作，而不需要提前定义所有的属性和方法。

举个例子，假设我们有一个叫obj的对象，并且我们希望通过字符串获取该对象的属性或方法，我们可以使用`getattr(obj, 'attribute')`来获取属性的值，或者使用`getattr(obj, 'method')()`来调用方法。

反射的应用场景很广泛，可以实现动态加载模块、调用不同的函数、动态调整对象的属性等等。通过反射，我们可以根据需要在运行时决定对象的行为，增加了程序的灵活性和动态性。但是需要注意的是，在使用反射时要谨慎，确保操作的安全性，并进行适当的错误处理。

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
