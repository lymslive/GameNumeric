areaman 工具内容与开发笔记
=======

基本工具
-------

* 新建项目：newar newar_fun()
* 打开项目：openar openar_fun()
* 关闭项目：closear closear_fun()
* 保存项目：savear

因为该项目管理工具需要管理主工作区，向主工作区注入、修改内容，所以基本工具只能
写成脚本，且脚本无法带参数。

为避免污染主工作区的变量，脚本尽量少用中间变量，要用到时以 a_* 前缀命名，脚本
最后用 `clear -regexp ^a_` 清理临时变量。

其他可用函数调用解决的，则改为在函数栈内处理。如子目录的向搜索路径中的添加与删
除。

在所管理的项目主目录下面生成两个数据文件：

* name_ar.mat 项目信息文件
* name_ws.mat 工作区文件

name_ar.mat 中存在的变量（域名），在 newar_fun 中生成：

* base: 主目录全路径
* name: 目录或项目名称
* project: _ar.mat 项目文件名
* workspace: _ws.mat 工作区文件名
* subpath: 相对路径列表，cellstr 类型
* filtera: 正则表达式，自动保存工作区哪些变量，默认 '^[a-zA-Z]{4,}$'

其中，supath 包含自己，用 '.' 表示，并自动搜索直接子目录，添加含有 .m/.mat 的
子目录。只在创建时搜索一次，故只在管理既有项目目录有效，新的空白项目目录不妨手
动添加修改。


项目记录
-------

* hisarea(basedir, prjfile)  在末尾添加一项记录
* [basedir, prjfile] = areas(rindex) 获取一项记录，或查看所有记录
* areas_ls.mat 项目记录数据，由 hisarea() 生成与修改

areas_ls.mat 所含变量（域名结构）:

* capacity: 容量，即最多保存几条记录，默认 5
* area: n*2 cellstr，每行是 `{basedir, prjfile}` 格式

即每条记录由项目目录及项目文件构成，结合起来就是项目文件 *_ar.mat 的全路径。
用 filesep 连接，使其与操作系统（win/linux）无关。

但由于记录全路径，项目管理信息不可移植，也不建议将 *_ar.mat 移至其他目录。

areas() 无参时只打印项目记录在窗口中，查看用。
areas(0) 返回最近项目，即 .area 域最后一行，接收正整数索引取其他记录，
返回 `.area{end-rindex,:}` 行。


其他辅助工具
----------

headpath: 查看搜索路径 path 前几行，也可修改。

一般 path 是很长的列表，所以提供一个函数只关注前几行：

* headpath(): 打印前 10 个 path
* headpath(+n): 打印前 n 个 path
* headpath(-n): 删除第 n 个 path，然后显示前 n+1 个，看删除后效果
* headpath(0): 兼容调用 path 内置函数，用处不大。

可以有返回参数，以 cellstr 列向量方式返回前 n 个 path;

还可以提供字符串作输入参数，表示相对路径，转化为绝对路径后添加后 path

* headpath('.'): 将当前路径添加至 path
* headpath('..'): 将当前路径的父目录添加至 path
* headpath('sub'): 将 pwd/sub 添加至 path

如有接收参数，返回转成的绝对路径字符串。
