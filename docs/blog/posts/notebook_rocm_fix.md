---
# draft: true 
date: 2025-06-18 
categories:
  - 技术分享
authors: 
    - Jagger
comments: true
---

# 关于如何解决AMD rocm 在 vscode jupyter notebook 插件下不可用的问题


环境说明：linux环境、通过vscode jupyter notebook 插件编写pytorch机器学习代码、rocm运行环境已安装、通过rocm-smi等命令都正确检测到amd gpu、export HSA_OVERRIDE_GFX_VERSION=10.3.0 （设备类型强制覆盖）环境变量已成功设置

一句话说明问题：因为jupyter notebook 使用另外的环境变量，导致设备类型强制覆盖失败

解决方案： 在vscode配置里配置jupyter notebook启动参数，强制覆盖设备类型。

配置路径：/home/用户名/.config/Code/User/settings.json

参数设置： 
 ```json
   "jupyter.runStartupCommands": [
        "import os",
        "os.environ['HSA_OVERRIDE_GFX_VERSION'] = '10.3.0'  # Adjust to your GPU's GFX version"
    ],
```

<!-- more -->

终端配置文件添加

``` shell
# export ROCM_PATH=/opt/rocm
export HSA_OVERRIDE_GFX_VERSION=10.3.0
# export HSA_ENABLE_IPC_MODE_LEGACY=0
export HIP_VISIBLE_DEVICES=0
```