htable: 句柄包装的 table 类
========

htable 类包含一个内置的 table 数据变量，提供与内置 table 基本一致的用法接口。
对 htable 对象的操作，基本都转化为对内部的 table 变量的操作。

htable 类的设计目的与主要特征用法有：

- 是一个句柄类，但作为参数传递给函数时可节省开销，尤其是 table 变量在处理函数
  内是只读，并不修改时，避免值拷贝操作。
- 借鉴 excel 表格的列名风格，可以用 A B C 引用 table 的第 1 2 3 列。
- 单索引表示行，me(i) me{i} 分别是 me(i,:) me{i,:} 的简写
- htable 建议使用标量对象。


构造函数
-------

类内部只有一个私有（保护 protected）数据 tab_。

- me = htable()
- me = htable(tab)     接收一个 table 变量，将其转为 htable 对象
- me = htable(vargin)  接收多个变量，用以创建 table 变量，然后 htable 对象

回转函数，将 htable 转回 table 变量。

- tab = me.table
- tab = table(me)


取行取列，改行改列
-------

增加两个方法，命名为 col row 分别用于获取或修改 (get/set) 表格的一列或一行，也
可同时处理多列或多行。调用时只提供索引参数时是取值，额外提供新值时是设值。

- n = me.col(); 返回列数
- names = me.col('-names'); 返回所有列名，元胞行向量，cellstr
- var = me.col(inex); 返回指定列的值，索引可以是整数、列名，或 Excel 风格的字
  母列名（A, B, ...）。
- [var1 var2 ...] = me.col(indices); 用整数向量或字符串元胞指定多列，可以有多
  个返回值，分别接收，但如果只有一个接收参数，则全部合并在一个变量中。
- me = me.col(index, value); 为列赋值，由于句柄类，其实不必再赋回自己。
- me = me.col(indices, val1, val2, ...); 可以提供多个输入值变量。

注意：col 方法内部，用 table 的花括号（{}）索引取值，因此只有相同数据类型的列
才可以在一次调用中取值。设值提供的 value 需与原来的类型相同。设值时提供原来不
存在的列，会增加会。

Excel 风格的列名转换，只在取值时用到，只有当原来表中不存在名字就叫 'A' 的列，
才把 'A' 解释为第1列。此法不区别大小写，但建议用大写字母。

设值时，不利用 Excel 风格的列名转换。如果原来没有叫 'A' 的列，`col('A', val)`
将新增一个名字就叫 'A' 的列，而不是修改第 1 列。这是由于，如果使用
`col('DEF', val)`，不会将 'DEF' 转化为一个非常大的列号（2840），而应该直接建一
列叫做 'DEF'。

me.row 方法与 me.col 方法类似。但行名（RowNames）不是每个 table 都必须的，可能
经常是空元胞。


索引重载
---------

- subsref
- subasgn

对 htable 对象的索引，几乎都转化为对内部的 table 变量的索引。点索引列名，括号
单索引行，括号双索引则取表格区域。小括号取子表（table类型），大括号取值（表单
元格内保存的数据类型，一般是数字或字符串）。

在 subsref 点索引取值时，域名使用的优先级是：

- methods(htalbe); htable 对象的方法名优先使用
- methods(table);  如果是能处理 table 类型的方法，转为调用该方法处理内部的变量
- htable.col(name); 最后取内部 table 变量的列名，因此也可用 Excel 列名风格

在用 subsasgn 点索引赋值时，直接赋值，可以新增原不存在的列。但若与 htable 或 table
方法名冲突，给出警告（但并阻止），这样做之后，无法在用点索引取值，但仍可用 col
方法取列。

另外，htable 对象唯一的成员数据 tab_ 外部是无法访问的。但重载索引后，'tab_' 将
被解释某个列的名字。然而，比较好的工作实践，所用表格的列名，理应尽量避免与这些
方法名冲突。


静态方法
-------

- excelStyle
- letter

处理整数索引与 Excel 风格字母索引的相互转换。excelStyle 是较复杂通用的方法，还
支持类似 'A1:B2' 的区域范围索引。letter 专门只转换列名，相当于 ABC 26 进制与整
数 10 进制的转换。鉴于 Excel 表最大的列数也就 XFD ，所以超过 4 字母不作转化。
也因此，表的实际列名最好取 4 字母以上有意义的名词单词。


转换方法
------

- table: 直接返回内部的 table 变量，tab_
- double: 返回可合并为数值矩阵的部分，不能合并的返回在元胞矩阵中。可返回多值。
- cell: 转换为元胞矩阵，可选参数指定是否将列名加到第一行。
- struct: 转换为 struct ，可选参数指定转为 struct 数组（默认）或标量。

参考 Matlab 内置函数 table2array, table2cell, table2struct.
