---
# draft: true 
date: 2023-09-25 
categories:
  - 学习笔记
comments: true
authors: 
    - Jagger
---

# java8语法特性-Lambda表达式、Stream API学习
Lambda表达式：Lambda允许把函数作为一个方法的参数（函数作为参数传递到方法中）。

Stream API：新添加的Stream API（java.util.stream）把真正的函数式编程风格引入到Java中。

<!-- more -->

## Lambda表达式

Lambda表达式可以用于替换单方法接口

在Java编程语言中，Lambda表达式是一种函数式编程的特性，它提供了一种简洁的方式来创建匿名函数。Lambda表达式可以被视为一种更简洁的匿名类的写法。

Lambda表达式的语法由箭头符号（->）分隔成两部分。箭头左侧是参数列表，箭头右侧是表达式主体。Lambda表达式是一个可以被分配给函数式接口（Functional Interface）的对象，该接口必须只包含一个抽象方法。

我们把只定义了单方法的接口称之为`FunctionalInterface`，用注解`@FunctionalInterface`标记。

Lambda表达式的形式如下： (param1, param2, ...) -> { 表达式主体 }

下面是一个简单的Lambda表达式的示例：

`int[] numbers = {1, 2, 3, 4, 5};`

```java
Arrays.stream(numbers)
.map(n -> n * 2)
.forEach(System.out::println);
```

在上述示例中，Lambda表达式 (n -> n * 2) 是一个函数式接口的实现。它接受一个参数n，并返回n乘以2的结果。这个Lambda表达式被应用于Stream的map操作，用于对数组中的每个元素进行处理。

使用Lambda表达式可以简化代码，使代码更加易读和简洁。Lambda表达式通常可以取代使用匿名内部类的方式来实现函数式接口，减少了冗余的代码和额外的类定义。

需要注意的是，Lambda表达式只能用于函数式接口。函数式接口是只有一个抽象方法的接口，可以使用@FunctionalInterface注解进行标识。对于抽象方法多于一个的接口，无法使用Lambda表达式。

## Stream API
[Java 8 Stream | 菜鸟教程 (runoob.com)](https://www.runoob.com/java/java8-streams.html)

https://www.liaoxuefeng.com/wiki/1252599548343744/1322402873081889

https://blog.csdn.net/const_/article/details/96302525

https://cloud.tencent.com/developer/article/1746942

这种风格将要处理的元素集合看作一种流， 流在管道中传输， 并且可以在管道的节点上进行处理， 比如筛选， 排序，聚合等。

元素流在管道中经过中间操作（intermediate operation）的处理，最后由最终操作(terminal operation)得到前面处理的结果。

Stream API的特点是：

- Stream API提供了一套新的流式处理的抽象序列；
- Stream API支持函数式编程和链式操作；
- Stream可以表示无限序列，并且大多数情况下是惰性求值的。

Stream API的基本用法就是：创建一个`Stream`，然后做若干次转换，最后调用一个求值方法获取真正计算的结果：

```java
int result = createNaturalStream()// 创建Stream
             .filter(n -> n % 2 == 0)// 任意个转换
             .map(n -> n * n)// 任意个转换
             .limit(100)// 任意个转换
             .sum();// 最终计算结果
```

### `Stream.map()`

`Stream.map()`是`Stream`最常用的一个转换方法，它把一个`Stream`转换为另一个`Stream`。

在其中可以使用lambda表达式`.map(s -> s.replaceAll(" ", ""))`

还可以使用方法调用`.map(LocalDate::parse)` 

英文格式双冒号::，读：double colon，双冒号（::）运算符在Java 8中被用作方法引用（method reference），方法引用是与lambda表达式相关的一个重要特性。它提供了一种执行方法的方法,为此，方法引用需要由兼容的函数式接口组成的目标类型上下文。

大致意思是，使用lambda表达式会创建匿名方法， 但有时候需要使用一个lambda表达式只调用一个已经存在的方法（不做其它）， 所以这才有了方法引用！

**常用语法**

- 静态方法引用语法：className::methodName 例如：Person::getAge
- 对象的实例方法引用语法：instanceName::methodName 例如：System.out::println
- 对象的超类方法引用语法：super::methodName
- 类构造器引用语法：className::new 例如：ArrayList::new
- 数组构造器引用语法：typename[]::new 例如：String[]::new

### `Stream.filter()`

`Stream.filter()`是`Stream`的另一个常用转换方法。

所谓`filter()`操作，就是对一个`Stream`的所有元素一一进行测试，不满足条件的就被“滤掉”了，剩下的满足条件的元素就构成了一个新的`Stream`。

### `Stream.reduce()`

`map()`和`filter()`都是`Stream`的转换方法，而`Stream.reduce()`则是`Stream`的一个聚合方法，它可以把一个`Stream`的所有元素按照聚合函数聚合成一个结果。`reduce()`是聚合方法，聚合方法会立刻对`Stream`进行计算。

 `stream.reduce((acc, n) -> acc + n)`

接收两个参数，第一个是sum聚合的初始值，第二个是聚合方法，常为一个lambda表达式

流的特点是每个元素只遍历一次，聚合操作无非就是一个遍历+累加计算的过程，内部已经自动帮你遍历了

你想再遍历一遍，那只能构造一个新的stream

### **输出集合**

我们介绍了`Stream`的几个常见操作：`map()`、`filter()`、`reduce()`。这些操作对`Stream`来说可以分为两类，一类是转换操作，即把一个`Stream`转换为另一个`Stream`，例如`map()`和`filter()`，另一类是聚合操作，即对`Stream`的每个元素进行计算，得到一个确定的结果，例如`reduce()`。

区分这两种操作是非常重要的，因为对于`Stream`来说，对其进行转换操作*并不会触发任何计算*！

输出为list：调用`collect()`并传入`Collectors.toList()`对象

输出为set：`collect(Collectors.toSet())`可以把`Stream`的每个元素收集到`Set`中

分组输出：分组输出使用`Collectors.groupingBy()`，它需要提供两个函数：一个是分组的key，这里使用`s -> s.substring(0, 1)`，表示只要首字母相同的`String`分到一组，第二个是分组的value，这里直接使用`Collectors.toList()`，表示输出为`List`

分组输出练习

```java
package com.itranswarp.learnjava;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * Learn Java from https://www.liaoxuefeng.com/
 *
 * @author liaoxuefeng
 */
public class CollectProblem {

  public static void main(String[] args) {
    Stream<Student> studentStream = Stream.of(
      new Student(2, 3, "小明", 80),
      new Student(3, 1, "小王", 90),
      new Student(3, 1, "小z", 50),
      new Student(1, 2, "小强", 100),
      new Student(3, 1, "小红", 90),
      new Student(1, 2, "小黄", 100),
      new Student(2, 3, "小黑", 80),
      new Student(1, 2, "小军", 100),
      new Student(2, 3, "小乔", 70),
      new Student(3, 1, "小林", 90)
    );
    // 尝试按照成绩,不及格,及格,良好,优秀来分个组
    Map<Integer, Map<Integer, Map<Object, List<Student>>>> studentByGradeAndClass = studentStream.collect(
      Collectors.groupingBy(
        Student::getGradeId,
        Collectors.groupingBy(Student::getClassId, Collectors.groupingBy(
          s -> s.getScore() >= 90 ? "优秀" : s.getScore() >= 80 ? "良好" : s.getScore() >= 70 ? "及格" : "不及格"))
      )
    );
    studentByGradeAndClass.forEach((k, m) -> {
        
      System.out.print("Grade" + k + " ");
      m.forEach((key, value) ->
        System.out.println("Class" + key + " = " + value)
      );
    });
  }
}

class Student {

  private int gradeId;
  private int classId;
  private String name;
  private int score;

  public Student(int gradeId, int classId, String name, int score) {
    this.gradeId = gradeId;
    this.classId = classId;
    this.name = name;
    this.score = score;
  }

  public int getGradeId() {
    return gradeId;
  }

  public int getClassId() {
    return classId;
  }

  public String getName() {
    return name;
  }

  public int getScore() {
    return score;
  }

  @Override
  public String toString() {
    return "Name:" + getName() + " " + "Score: " + getScore();
  }
}
```

输出

```bash
Grade1 Class2 = {优秀=[Name:小强 Score: 100, Name:小黄 Score: 100, Name:小军 Score: 100]}
Grade2 Class3 = {及格=[Name:小乔 Score: 70], 良好=[Name:小明 Score: 80, Name:小黑 Score: 80]}
Grade3 Class1 = {不及格=[Name:小z Score: 50], 优秀=[Name:小王 Score: 90, Name:小红 Score: 90, Name:小林 Score: 90]}
```

### 排序

注意`sorted()`只是一个转换操作，它会返回一个新的`Stream`。

### 去重

对一个`Stream`的元素进行去重，没必要先转换为`Set`，可以直接用`distinct()`

`Stream`提供的常用操作有：

转换操作：`map()`，`filter()`，`sorted()`，`distinct()`；

合并操作：`concat()`，`flatMap()`；

并行处理：`parallel()`；

聚合操作：`reduce()`，`collect()`，`count()`，`max()`，`min()`，`sum()`，`average()`；

其他操作：`allMatch()`, `anyMatch()`, `forEach()`。

### Java双冒号(::)运算符

在 Java 中，"::" 是一个方法引用运算符，也称为方法引用符。它的作用是将方法转换为对象。

### MyBatis-Plus条件构造器LambdaQueryWrapper

1. CRUD接口
    1. service CRUD接口
        1. 继承`iService`，在`controller`中调用
    2. mapper CRUD接口
        1. 继承`BaseMapper`，在`serviceImpl`中调用
2. **条件构造器**

[条件构造器](https://www.w3cschool.cn/mybatis_plus/mybatis_plus-426u3mjp.html)

[条件构造器用法](https://blog.csdn.net/m0_46159545/article/details/107161814)

用于向crud接口中传递查找条件