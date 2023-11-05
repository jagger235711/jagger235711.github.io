---
# Additional metadata can be used in the template
authors: 
  - Jagger
categories:
  - 技术分析
date: 2023-11-02           
comments: true
draft: true
---
# Python中的*args（arguments）和**kwargs（keyword arguments）参数

<!-- more -->

在Python中，*args和**kwargs是用于传递不定数量的参数的特殊语法。

*args用于传递任意数量的非关键字参数。它允许传递任意数量的参数，并将它们作为一个元组传递给函数或方法。在函数定义时，使用*args可以接受任意数量的参数。

下面是一个示例，展示了如何使用*args来接受不定数量的参数并打印它们的值：

```python
def my_function(*args):
    for arg in args:
        print(arg)

my_function(1, 2, 3, 4)

输出：

1
2
3
4
```

`**kwargs`用于传递任意数量的关键字参数（键值对）。它将关键字参数作为字典传递给函数或方法。在函数定义时，使用**kwargs可以接受任意数量的关键字参数。

下面是一个示例，展示了如何使用**kwargs来接受不定数量的关键字参数并打印它们的值：

```python
def my_function(**kwargs):
    for key, value in kwargs.items():
        print(key + " = " + str(value))

my_function(name="Alice", age=25, city="New York")

输出：

name = Alice
age = 25
city = New York
```

在类中使用*args和**kwargs与函数类似。你可以在类的方法中使用这些语法来接受不定数量的参数。下面是一个示例，展示了如何在类中使用这些语法：

```python
class MyClass:
    def my_method(self, *args, **kwargs):
        for arg in args:
            print(arg)
        for key, value in kwargs.items():
            print(key + " = " + str(value))

my_object = MyClass()
my_object.my_method(1, 2, 3, name="Alice", age=25, city="New York")

输出：

1
2
3
name = Alice
age = 25
city = New York
```

通过在方法定义中使用*args和**kwargs，你可以灵活地处理不定数量的参数，使代码更具通用性和可扩展性。

kwargs可以用get取值，后面的默认值不能用关键字参数的形式
kwargs.get("key", 1)
