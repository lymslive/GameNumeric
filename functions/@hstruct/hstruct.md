hstruct: 结构扩展运用类
============

简介
---------

封装 Matlab 的结构体 struct，做成句柄类。主要有以下几个特点与优势：

- 句柄类引用降低函数间传递参数的开销。
- 保留 struct 使用的便捷性，可以动态增加域名。
- 收集处理 struct 的成员函数，方便管理。
- 可以继承，为具有特定结构的 struct 增加一套成员函数。
- struct 可以对应硬盘上的一个 mat 数据文件（以struct方式save&load），以此方式
  保存的对象结构方便 Matlab 预览。而 hstruct 完全对应一个 struct。
- hstruct 通过一个私有变量 stin_ 包含一个 struct，通过重载重要操作方法，使对对
  象的操作转化为对该 struct 的操作。
- 比较适合 hstruct 标量对象，若用对象数组不便保证每个对象内含的 struct 结构一
  致。


实现方式
--------

### 成员数据

stin_: 唯一一个成员，保存实际使用的 struct，私有，不允许用户修改 stin_。

### 构造方法

构造方法也就要求一个 struct 参数，将该参数封装为 stin_　私有数据。但也允许接受
空参数。默认的 stin_ 会增加一个域，stin_.Class_ = 'hstruct'。

### 定制重载

stin_本身是私有，但它所表示的 struct 相当于完全公有化。通过重载索引，可以方便
索引内含的 struct，像一般 struct 取值赋值。

- subsref, 索引 struct 域值，不存在的域返回空（[]），则不会报错。
- subsasgn, 索引赋值，为某个域赋空值，表示删除该域（rmfield）。
- fieldnames, 返回 stin_ 的域名列表，cellstr 列向量。
- struct, 就是返回内含的 stin_。
- display, 在命令窗口打印 stin_ 信息。
- get/set, 点索引的函数版，因为在类成员方法内点索引重载不生效，get/set 方便。

通过这些重载，对标量 hstruct 对象能完全模拟 struct 的操作。但 hstruct 对象数组
仅实现有限的支持，它不等同于 struct 数组。struct 数组要求每个 struct 有相同的
结构，如果仅为其中一个元素赋值增加一个域，则其他元素也会相应增加空值域。而
hstruct 对象数组，不认为每个对象所包含的 struct 都要有相同的结构。所以点索引
hstruct 对象数组被禁止，但点索引 struct 数组是允许的，它返回多值逗号列表。

另外，如果觉得有必要对 stin_ 所内含的 struct 的某些域实行访问控制权，可以修改
（或继承后覆盖）索引方法 subsref/subsasgn 及取域名的 fieldnames 方法。然后个人
设计这个 hstruct 类的初衷，就是要利用 struct 的一切便利性，因而不打算控制权限
。

### 与 mat 数据文件的关联操作

设计 hstruct 类的另一个目的，是为了方便管理与处理保存于硬盘的 .mat 数据文件。

用 Matlab 内置命令 `save -struct` 可以将一个 struct “解压”保存各域变量至外部文
件，然后用 `s = load()` 将外部文件加载为一个 struct。这样做的好处是将一个外部
文件与内存的 struct 变量关联起来了，且在 Matlab 的工作桌面上可以预览 mat 文件
内变量，也即加载后 struct 的域名结构。

然而，若仅用 struct 来关联 mat 文件双嫌薄弱。每个保存的 mat 数据文件往往是有特
定域名结构的（尤其是真正有保存价值的 mat ，一般应该要知道它保存了什么数据），
所以就有需求为该 mat 的数据写一些特定相关的函数方法。于是就设计了 hstruct 基类
。

虽然按常规方式定义的 Matalb 类，也可以保存与加载，甚至按需要重载 saveobj 与
loadobj。但它是以一个变量保存到 mat 文件中，在加载进内存之前，无法预览其内部结
构。且需要精心定义每个类，如果想为某个对象动态增加一些域的话，会很麻烦。

hstruct 的保存方式是将内含的 stin_ 提出并解压保存各域变量。重新加载后可以只当
普通 struct 使用，或者将 struct 构造为 hstruct 使用。

为此，hstruct 向 stin_ （及保存的 mat 文件）注入了两个特殊域变量：

- .Class_: 表示关联的类名，可以是 hstruct 的继承类
- .File_: 表示 mat 文件保存的物理路径，全路径

变量名末尾加个下划线，是理念上的“私有变量”，而不是技术上的私有变量。如果用户不
避麻烦乐意使用之，则是用户的责任了。

然后在 hstruct 基类中提示两个方法：

- savemat(me, file): 保存数据，me 是对象自己，若未提示 file 路径参数，则按
  File_ 域保存的路径保存，如果也没有 File_ ，则以变量名为文件名保存在当前目录
  。
- loadmat(file, class)：类静态函数，加载 file.mat 文件，如果提供 class 参数，则
  将加载的 struct 传给 class 的构造方法封装为对象；否则按 Class_ 中保存的类名
  构造对象；如果都缺省，则用 hstruct 基类对象；如果连 hstruct 也从路径中删除了
  ，则返回普通 struct，仍然是数据完整的 struct。

既然是静态方法，就该用 hstruct.loadas(...) 格式调用，为进一步方便使用，在路径
中再增加一个全局函数 `loadas`，调用 `hstruct.loadas`。

不想武断重载覆盖 Matlab 内置的 save 与 load，所以增加了 mat 后缀。

由于 saveas 与 loadas 处理了默认情况，即使 mat 文件或 struct 变量缺失 Class_
与 File_ 域变量也无关紧要。注入是为了使用方便，却也不是必不可少的。所以如果觉
得它们碍眼，可以用 clean 方法清理之。

- clean(regexp)：无参时默认清理末尾是下划线的变量，也可传入参数指定清理哪些域
  自变量，以正则表示式匹配方式。如果仅是想清理一个变量，赋空值即可。

所以没事不要自己找不自在，在 mat 或 struct 数据中用 _ 变量保存重要数据。顺便提
一下，在一般情况下，Class_ 与 File_ 的排列位次会在顶部的。

扩展说明：Matlab 也有一个内置类 matfile ，将一个 .mat 文件与一个对象关联起来，
可用于部分加载数据，对大文件尤其有用。这里提供的 hstruct 关注的是 .mat 文件内
的变量域名及其可操作方法。

派生子类
---------

可以派生子类，只需增加一组处理特定 mat 数据文件的成员方法，无需额外定义类的成
员变量。用户须自己保存各方法中引用的变量，在 mat 文件中确实是存在的，同时不要
介意文件中可能还存在用不上或不用处理的变量名。如果本来为某类 mat 文件写的一套
方法，发现对另一类 mat 文件也适用，也尽管去用。也就是说，同一个封装数据，有可
能由多个类方法来处理，这貌似是个不错的特性呢。

当然，如果 mat 文件不能为类方法提供所需的变量，是会出错的。OK，正如你试图用
Word 来打开电影文件，会出错岂不是天经地义的事；或许你也可以用 Vim 打开位图文件
，只是得不到有意义结果而已。

最坏的情况，始终可以把 mat 文件加载为普通 struct 来使用，这也可兼容早期 Matlab
版本。最好的情况，hstruct，用起来也只像个普通 struct 而已。咦，好像没什么变化
呢，对，你得到了它，苟能达到这个效果，那就对了。


变量纯文本化(xml)
---------

savexml 方法将结构变量保存为 xml 格式文档，方便用外部程序查看。

- me.save(file, ...); 保存至文件
- xmlstr = me.save(...); 转化为字符串
- me.save([file], rootname, ...); 指定 xml 根元素标签，缺省则用 'struct'
- me.save(..., mode); 转化模式，保存数据或保存结构信息

mode 转化模式：

* -data 或 1; 保存数据
* -frame 或 2; 保存结构信息

依赖关系：
- xmlbox/mat2xfrag.m, mat2xframe.m
- extra/@cList 类
