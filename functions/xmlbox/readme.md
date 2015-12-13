xmlbox: matlab 处理 xml 数据文件的一些方法心得
===========

由于笔者曾有游戏项目采用 xml 作配置文件，曾探究过一些用 Matlab 处理 xml 的方法
。处理文本原不是 Matlab 的长项，它本身提供了 xmlread 与 xmlwrite 接口方法，大
约基于 Java 的 DOM 模型。但直接用这两个函数觉得还是有些不便，所以去网上找了些
其他人写的工具，然后多方借鉴又自己写了几个方法几个类来处理 xml。

保留的轻量工具
---------

试用过网上不少 xml 相关工具（下载自 Matlab 官网社区），最终仍保留推荐以下几个
函数文件。因为很轻量，专门解决某个问题很方便。

- xml2struct.m / struct2xml.m ：将 xml 文档与 matlab struct 类型变量互相转化。
- myXMLwrite.m : 原来的 xmlread/xmlwrite 重写会多余空行，该方法只为解决这问题。

自己写的几个轻量工具
------

- qxml.m : 基于 DOM 与 xpath，局部查询与修改 xml 元素属性值
- sxmlval.m : 基于 xml2struct 的 struct 结构，查询或修改 xml 元素属性

matlab 变量 xml 化
-------

将矩阵风格的 matlab 变量保存为 xml 纯文本格式，方便外部工具查看。将矩阵的每一
行保存为 xml 的一个元素，每一列保存为元素的属性。并支持 struct 与 cell。

- xsave.m : 将一个变量保存为 xml 文件，或 xml 格式字符串
- xwsave.m : 将当前工作区的所有变量保存在 mworkspace.xml 文件中
- mat2xfrag.m : 被 xsave 调用的工具方法，将 matlab 变量转化为 xml 片断文本
- mat2xframe.m : 只保存变量的结构框架信息，类型、维度、域、元胞内容类型等

一套类处理工具
-------

后来写了几个颇为复杂的类来处理 xml ，源于两个目的。一个是 Matlab 自己提供的
xmlread 没有保留 xml 源文件中属性的顺序，我需要关注属性顺序。另一个是上面
xsave.m 保存的 xml 化的 matlab 变量，得逆解析吧。

- @txtfile : 将一个纯文本文件读入到 cellstr 中处理
- @xmlfile : 派生至 @txtfile，解析简单的 xml 数据源文件
- @xmlel : xml 元素结点类，算是个比较核心的类
- @xmldoc : 包含一个 xmlel 根元素的 xml 文档抽象类

说明事项
------

这里提供的工具类或方法，不为解决通用的 xml 文档模型，只为方便处理保存数据的
xml 文档，这类数据文档相对简单，主要结构大致为：

```
<record fieldA="valA" fieldB="valB" filedC="valC" />
<record fieldA="valA" fieldB="valB" filedC="valC" />
.....
<record fieldA="valA" fieldB="valB" filedC="valC" />
```

如果这些字段中保存的都是数字的话，我就特想让 Matlab 将其读入为一个矩阵来处理，
如果有字符串的话，就只好用无胞矩阵来保存了。
