string: 字符串类
============

简介
------

Matlab 主要是设计用于数值计算，在字符串处理方面可能不尽如人意或众口难调。
所以按自己的一些使用习惯写一个 string 类。

Matlab 内置处理字符串的数据类型是：
- char vector: 一个字符串
- char matrix: multiply row vector，多个等长的字符串（较少用）
- cellstr: 无胞数组（矩阵），每个元素可以是不等长字符串

这儿的 string 类：
- scalar object(me): from a char vector
- array objects(we): from cellstr or char matrix

重载括号索引
- me(): 像 char vector 一样取某位置上的字符，或子串
- we{}: 像 cellstr 一样取数组矩阵中某个 string object

对数组对象取小括号索引 we() 会返回多值列表，若只有一个接收参数，则返回
cellstr.

重载四则运算：

- 加法：me + he = she，末尾连接字符串。
- 减法：me - he = she，末尾移除子字符串，但 minus() 函数调用可指定选项在其他位
  置移除子串。
- 乘法：me * he = she，以 he 作为分隔符连接多个字符串，me 是数组 we。
- 除法：me / he = she，以 he 作为分隔符分隔一个字符串 me，返回数组对象 she。
- 取负：-me = she，将字符串逆序重排

以上，加法与减法是可逆运算，乘法与是可逆运算。符号左值 me 与返回值 she 都是
string 对象，右操作数 he 可以是 string 对象或 char vector/cellstr。

在加减法中，me 与 he 可以是同维数组，或 he 允许标量字符串，返回的 she 与 me 同
维。乘法中 me 是数组对象，she 是标量对象。除法反之，me 是标量对象，she 是数组
对象。

实现笔记
--------

直接参考各 .m 文件的头部注释。

- string; 构造函数
- get/set; 取子串，设子串(不更改原大小，内部数组赋值)
- setslice; 替换子串
- subsref/subsasgn; ()与{}索引重载，点索引保持默认
- display; 打印信息，对并长字符串与长数组对象优化打印
- plus/minus/uminus/mtimes/mrdivide; 运算重载

静态方法：
- string.isscalar; 判定是否标量字符串
