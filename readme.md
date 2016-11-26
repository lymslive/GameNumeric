GameNumeric: 游戏数值之 Matlab 工具箱
===========

About me : lymslive (403708621@qq.com)

简介
----

用 Matlab 编程语言解决游戏数值问题。源于实际项目的经验总结，着重通用解决方案的
思路指引、分析与研究，但不涉及具体游戏项目的数据设计。

将是长期的开源项目，欢迎同行批评意见，或交流合作。

基本约定
-------

* 无特殊注明外，所有脚本代码为 Matlab 的命令行工具函数，不是 GUI 程序工具。
* Matlab 版本在 7.0 以上。
* .m 文件尽量参考 matlab 习惯维护注释头，当然用中文注释。
* 非注释文档理所当然使用纯文本格式的 markdown(.md) 格式。
* 函数定义参数按程序习惯用单词变量，而函数体内实现可按数学习惯用单字母符号变量。

常用符号变量：

- a: atk, attack, 攻击
- h: hp, health point, 生命/血量
- d: def, defend, 防御
- c: cst, constant argument, 常数参数
- n: lv, level, 等级
- dh: damage, 伤害（血量变化）
- r: rate, 免伤率，各种率
- p: probability, 概率
- t: time, turn, times, 时间，回合，次数
- R: require, 需求向量（如不同等级下的需求）
- S: supply, 产出向量（如不同等级下的产出供应）

目录内容
-------

### classic

  游戏经典问题收集，主要是可转化为数学上概率或组合的问题，最好能有数学分析解。
  然后整理为 .m 函数，以供类似问题调用求解。

### damage

  老生常谈的游戏伤害公式问题。收集常见伤害公式类型，并提供基于属性伤害的标准角
  色单位的 1v1 战斗模拟。

### areaman

  一个项目管理方案。管理当前工作区(base workspace)与项目文件夹。

### functions

  一些有用的工具，在做游戏数值工作中可能用到的便利性函数。

### extra

  另外一些扩展的工具，更侧重 matlab 基础运用，与游戏数值联系或许稍远。

TODO
-----

* 通用概率模拟方案
* 项目管理方案
* 与 excel 联合协作方案
* 数值系统设计与模拟

更新日志与笔记
------------

### 2015-11:

  学会使用 github 后，整理一些 matlab 代码，提交上传。
  最大感触是代码可调试，文档难写明。

### 2015-12

  继续扩充代码，陆续整理上传以前写的代码，及新写代码。
  由于在公司用 windows 系统，家用笔记本用 linux 系统，在编码上曾有纠结，未尽一
  致。主要影响只是中文注释。代码中不会出现中文，包括 error 或 warning 信息。虽
  然英文不怎样，但想想源文件还是尽量写英文。额外的文档用中文就好了。

### 2016-01

  (数值项目可能暂时搁置，写这么多代码，不如直接加入程序猿队伍好了)
