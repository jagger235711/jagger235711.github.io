---
# draft: true 
date: 2025-08-01
categories:
  - 技术分享
authors: 
    - Jagger
comments: true
---

# 记录一下使用 matplotlib 绘制中文图标不显示问题的解决思路

## TLDR

关键步骤就两个

1. 确定你系统里可以完美显示中文的字体 确定方法见下文脚本
2. 添加 matplotlib 配置 见下文配置

<!-- more -->

## 背景描述

今天在做机器学习评估模型性能的时候需要把相关指标可视化，可是中文怎么都不显示，在网上搜索添加了代码 1 仍然无法显示。效果如图 1 。经多方求助和指导后终于成功实现了 matplotlib 下中文绘图。成果如图 2 所示。

<sub>代码 1</sub>

```python
# 加载自定义字体
custom_font = FontProperties(fname=font_path)

# 设置中文显示相关参数
plt.rcParams["font.family"] = custom_font.get_name()
plt.rcParams["axes.unicode_minus"] = False  # 解决负号显示问题

```

<sub>图 1 </sub>

![图 1 ](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250801101623.png)

<sub>图 2 </sub>

![图 2 ](https://cdn.jsdelivr.net/gh/jagger235711/coooool@main/img/20250801102500.png)

## 处理步骤

1. 确定系统中可用中文字体

```python
import matplotlib.font_manager as fm
import os
import re


def find_matplotlib_fonts(show_all=False, show_chinese_support=True):
    """
    搜寻系统中Matplotlib可用的字体文件（适配用于Matplotlib 3.8+版本）

    参数:
        show_all: 是否显示所有字体
        show_chinese_support: 是否特别标记支持中文的字体
    """
    # 获取字体管理器（新版本Matplotlib推荐方式）
    font_manager = fm.FontManager()
    # 获取所有可用字体属性
    font_properties = font_manager.ttflist

    # 用于检测中文字体的正则表达式
    # 匹配中文字符或常见中文字体名称关键词
    chinese_pattern = re.compile(
        r"[\u4e00-\u9fff]|"  # 匹配任何中文字符
        r"(Noto Sans CJK)|(WenQuanYi)|(Heiti)|(Microsoft YaHei)|"
        r"(SimHei)|(FangSong)|(KaiTi)|(NSimSun)"
    )

    print(f"找到 {len(font_properties)} 个可用字体文件：\n")

    # 分类存储字体
    chinese_fonts = []
    other_fonts = []

    for font in font_properties:
        # 提取字体核心信息
        font_name = font.name
        font_path = font.fname
        font_style = font.style
        font_weight = font.weight

        # 判断是否为中文字体（通过名称或路径中的中文特征）
        is_chinese = bool(
            chinese_pattern.search(font_name)
            or chinese_pattern.search(os.path.basename(font_path))
        )

        # 收集字体信息
        font_info = {
            "name": font_name,
            "path": font_path,
            "style": font_style,
            "weight": font_weight,
            "is_chinese": is_chinese,
        }

        if is_chinese:
            chinese_fonts.append(font_info)
        else:
            other_fonts.append(font_info)

    # 显示支持中文的字体
    print(f"=== 支持中文的字体 ({len(chinese_fonts)}) ===")
    for i, font in enumerate(chinese_fonts, 1):
        print(f"{i}. 名称: {font['name']}")
        print(f"   路径: {font['path']}")
        print(f"   样式: {font['style']}, 字重: {font['weight']}\n")

    # 显示其他字体（如果需要）
    if show_all:
        print(f"\n=== 其他字体 ({len(other_fonts)}) ===")
        for i, font in enumerate(other_fonts, 1):
            print(f"{i}. 名称: {font['name']}")
            print(f"   路径: {font['path']}")
            print(f"   样式: {font['style']}, 字重: {font['weight']}\n")

    # 提供配置建议
    if chinese_fonts:
        print("=" * 50)
        print("推荐配置（将以下代码添加到你的绘图脚本开头）：")
        print("import matplotlib.pyplot as plt")
        print("plt.rcParams['axes.unicode_minus'] = False  # 解决负号显示问题")
        print(
            f"plt.rcParams['font.serif'] = ['{chinese_fonts[0]['name']}'] + plt.rcParams['font.serif']"
            f"\nplt.rcParams['font.sans-serif'] = ['{chinese_fonts[0]['name']}'] + plt.rcParams['font.sans-serif']"
        )
        
if __name__ == "__main__":
    # 默认为只显示支持中文的字体
    find_matplotlib_fonts(show_all=False)
```

2. 复制推荐代码到目标代码文件开头或者选择一个自己喜欢的字体通过代码加入目标代码

```python
plt.rcParams["axes.unicode_minus"] = False  # 解决负号显示问题
# 配置支持中文的无衬线字体（优先使用Noto Sans CJK SC）
plt.rcParams["font.serif"] =["你喜欢的字体"] + plt.rcParams["font.serif"]
plt.rcParams["font.sans-serif"] = ["你喜欢的字体"] + plt.rcParams["font.sans-serif"]
```
