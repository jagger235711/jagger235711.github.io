---
# draft: true 
date: 2025-10-28 
categories:
  - Hello World
authors: 
    - Jagger
comments: true
---

# 使用 LaTeX 撰写科研论文的完整实践总结

本文记录了在使用 LaTeX 编写科研论文过程中积累的经验，包括环境配置、结构设计、代码与图表管理、参考文献系统、调试过程以及常见问题的解决方法。文章重点在于提供一个可复用的实践路径，帮助后续写作更高效、更规范。
<!-- more -->

* * *

一、LaTeX 环境与编译配置
---------------

建议使用 **TinyTeX** 搭配 **XeLaTeX**。TinyTeX 是 TeX Live 的轻量版本，易于维护，占用空间小。安装完成后使用以下命令更新并安装宏包：

```bash
tlmgr update --self --all
tlmgr install <package-name>
```

首次编译出现缺少 `.sty` 文件的错误是正常现象，例如：

```
! LaTeX Error: File `caption.sty' not found.
```

可以直接安装：

```bash
tlmgr install caption
```

编译时建议使用：

```bash
latexmk -xelatex mypaper.tex
```

该命令能自动检测依赖并多次编译，确保交叉引用正确。

* * *

二、论文结构与章节规划
-----------

一篇完整的实验类论文通常包含以下章节：

1. **引言（Introduction）**：介绍研究背景和问题。
2. **相关工作（Related Work）**：说明已有研究与差距。
3. **方法（Methodology）**：阐述算法、模型或理论基础。
4. **实验设计（Experiment Setup）**：描述实验数据、环境和参数。
5. **实验结果与分析（Results and Analysis）**：展示与解释实验结果。
6. **讨论（Discussion）**：探讨结果意义与局限。
7. **结论（Conclusion）**：总结工作与展望未来方向。
8. **参考文献（References）**

附录可包含实验代码、推导、附加数据等。  
若论文中包含算法实现，可以在方法章节下添加“小节：原理性分析”，用于通过公式或伪代码分析算法行为，以便在实验前预测性能。

* * *

三、数学公式与符号规范
-----------

数学表达式建议加载以下宏包：

```latex
\usepackage{amsmath, amssymb}
```

常用环境：

```latex
\begin{align}
  \mathbf{x}_{t+1} &= \mathbf{x}_t - \eta \nabla f(\mathbf{x}_t), \\
  \Delta \mathbf{w} &= -\mathbf{H}^{-1}\nabla f(\mathbf{w})
\end{align}
```

写作规范：

* 向量使用粗体（如 $\\mathbf{x}$）；
* 使用 `align` 对齐等号；
* 公式编号通过 `\label` 管理。

* * *

四、伪代码与源代码插入
-----------

### 1\. 伪代码（Algorithm）

使用 `algorithm2e` 宏包：

```latex
\usepackage[ruled,vlined]{algorithm2e}
```

示例：

```latex
\begin{algorithm}[h]
\caption{拟牛顿法（BFGS）算法}
\KwIn{初始参数 $\mathbf{w}_0$，容差 $\epsilon$}
\KwOut{最优参数 $\mathbf{w}^*$}
初始化 $\mathbf{H}_0 = I$；\\
\While{$\|\nabla f(\mathbf{w}_t)\| > \epsilon$}{
  计算方向 $\mathbf{p}_t = -\mathbf{H}_t \nabla f(\mathbf{w}_t)$；\\
  执行线搜索求 $\alpha_t$；\\
  更新参数 $\mathbf{w}_{t+1} = \mathbf{w}_t + \alpha_t \mathbf{p}_t$；\\
  更新 $\mathbf{H}_{t+1}$；
}
\end{algorithm}
```

### 2\. 代码（Listings）

代码建议用 `listings` 宏包，并放置在 `code/` 目录：

```latex
\usepackage{listings}
\lstinputlisting[language=Python, caption={梯度下降法示例}]{code/gd.py}
```

避免在正文中直接粘贴大段代码，保持版面整洁。

* * *

五、图表与实验结果展示
-----------

图片用 `graphicx`，表格用 `booktabs`：

```latex
\usepackage{graphicx, booktabs}
```

表格示例：

```latex
\begin{table}[ht]
\centering
\caption{不同算法的性能对比}
\begin{tabular}{lcc}
\toprule
算法 & 最终损失 & 迭代次数 \\
\midrule
GD   & 0.0099 & 1000 \\
BFGS & 0.0095 & 100 \\
\bottomrule
\end{tabular}
\end{table}
```

图片建议采用相对路径存放在 `figures/` 目录，并统一命名。

* * *

六、参考文献系统与 biber 配置
------------------

使用 `biblatex` + `biber` 组合管理参考文献：

```latex
\usepackage[backend=biber,style=gb7714-2015]{biblatex}
\addbibresource{references.bib}
```

正文引用：

```latex
如文献 \cite{Nocedal2006} 所述……
```

编译命令顺序：

```bash
latexmk -xelatex mypaper.tex
biber mypaper
latexmk -xelatex mypaper.tex
```

### 1\. 常见错误：`biber` 未找到

错误信息：

```
sh: biber: 未找到命令
```

解决方案：

```bash
tlmgr install biber
export PATH=$PATH:~/.TinyTeX/bin/x86_64-linux/
```

验证：

```bash
which biber
```

* * *

七、latexindent 格式化工具配置问题
-----------------------

在 VSCode 使用 TexLab 或 LaTeX Workshop 自动格式化时，若出现：

```
latexindent not found
```

则说明未安装依赖。

解决方案：

```bash
tlmgr install latexindent
cpan YAML::Tiny File::HomeDir Unicode::GCString
```

在 VSCode 设置中加入路径：

```json
"latex-workshop.latexindent.path": "/home/user/.TinyTeX/bin/x86_64-linux/latexindent"
```

这样可以在保存时自动格式化文档。

* * *

八、常见编译与调试技巧
-----------

| 场景 | 命令或方案 |
| --- | --- |
| 清理中间文件 | `latexmk -C` |
| 自动编译 | `latexmk -xelatex -pvc mypaper.tex` |
| 参考文献缺失 | 手动运行 `biber` 再编译 |
| 浮动体乱序 | 使用 `[!htbp]` 指定位置 |
| 跨页图片 | 使用 `figure*` 环境 |
| 编号不更新 | 连续编译两次 |

当 `.log` 文件中出现 `!` 或 `undefined reference` 时，说明标签或引用未生成，多编译几次通常可解决。

* * *

九、宏包推荐
------

| 功能 | 宏包 |
| --- | --- |
| 中文排版 | ctex |
| 数学公式 | amsmath, amssymb |
| 插图 | graphicx |
| 表格 | booktabs |
| 伪代码 | algorithm2e |
| 代码展示 | listings |
| 超链接 | hyperref |
| 参考文献 | biblatex, biber |
| 页面设置 | geometry |
| 自动缩进 | latexindent |

* * *

十、经验总结
------

1. 环境问题是最容易卡人的环节，尤其是 `biber` 与 `latexindent` 的路径配置。
2. 模板确定后，后续论文的写作效率显著提升。
3. 代码、图表、参考文献都应独立成目录，避免项目杂乱。
4. 多利用 `latexmk` 自动化编译，减少人工命令。
5. 学会阅读 `.log` 文件，是解决大部分错误的关键。
6. 对论文类项目，尽量保持统一的样式与文件结构，便于长期维护。

* * *

十一、结语
-----

使用 LaTeX 写论文的过程前期配置繁琐，但长期收益显著。  
一旦熟悉了文档结构、宏包管理与编译流程，论文排版、引用管理、格式规范都会变得高效且一致。  
本文总结的经验可作为构建个人科研写作模板的参考，为今后的实验报告、综述或学术论文提供可复用的写作基础。
