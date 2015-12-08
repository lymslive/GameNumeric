Matlab 与 Excel 协作方式简介
======

Spreadsheet Link EX
------

这是 Matlab 提供的一个工具箱，用作 Excel 的宏插件。
请按 Matlab 的帮助文档步骤安装。
其主要功用是在 Excel 与 Matlab 两应用程序之间建立了一个联系，可方便地在 Excel
工作表与 Matlab 工作区之间交换数据。
简言之，就是可将 Matlab 当作计算后台，而将 Excel 表格当作数据显示前端。

安装后，建议对该 Excel 插件设置一下选项：

- 取消 Start Matlab at Excel startup。如果启动 Excel 自动也启动 Matlab ，启动
  可能较慢，建议取消，在需要 Matlab 时再手动启动。
- 选上 Use Matlab desktop。否则只有 Matlab 的命令窗口，没有完整的工作环境。

注意：从 Excel 的插件工具栏启动的 Matlab 会话（session）才能与 Excel 联动。在
Matlab 的帮助文档中说用以 `matlab -automation` 方式启动的 Matlab ，能让后来打
开的 Excel 自动连上 Matlab ，但我试过几次都不成功。

所以最靠谱的办法还是先打开 Excel 再打开 Matlab。以此方式打开的 Matlab 在关闭最
后一个 Excel 文件时，也会自动关闭 Matlab ，当然也可以手动先关闭 Matlab。


table 基本数据类型
----------

大约从 Matlab2013 版开始，Matlab 新增了一种基本数据类型，就叫 table，它是与矩
阵及 cell 元胞基本平级的基础类型，索引用法也类似。

table 的主要特点是可以按列保存不同类型的数据，但同一列的数据类型应一致，各列长
度要相同。每列可以有列名，即 matlab 允许的变量，然后像结构体 struct 索引域一样
，table 按列名（域名）索引一列。同时，table 还可以有行名，行名允许任意字符串，
因为行名不是用点索引的，而是 tab('行名', :)。取一列的方法是 tab.colname。行名
不是必须的，但列名很有用，很方便。

总之 table 这种数据类型，几乎可以完美对应 Excel 的一个区域表格。不过注意，
table 的行名与列名，不计在 table 的大小内，行名列名是在数据之外单独存放。Excel
的表格，首行/首列当作列名/行名的话，一般也与数据区域连在一起。

xlsread / xlswrite / readtable / writetable
-------

xlsread / xlswrite 是读写 Excel 文件的函数。在 table 推出后，用 readtable /
writetable 可能更方便。

Spreadsheet link 适用于打开两个应用程序时的交互使用。但在用脚本全自动化时，可
用这些读写方法。

另外，matlab 直接写 xls(x) 文件会比较慢，可以先导出为 csv 纯文本文件。然后在
excel 中导入 csv 数据，源 csv 文件被修改后，excel 文件内的数据可以选择刷新。当
然 csv 文件本身也可用 Excel 打开查看，只是 csv 只有一页。
