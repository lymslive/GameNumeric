damage process
==============

处理伤害流程相关工具。

单元模型模拟战斗: simbattle
-----------

    [victory report] = simbattle(attacker, defender, equation, [option])

标准单位 1v1 对战模拟框架工具，需要传递两个战斗单位（struct），以及描叙它们之
间如何战斗造成伤害的公式（函数句柄），额外可选选项表示直接打印在命令窗可将战报
保存在一个变量中（cellstr）类型。

返回的第一个参数，victory 的正负号表示第一个输入参数（攻击方）是否赢，绝对值表
示战斗持续回合数。默认情况下（省略 option），如果提供两个接收参数，则第二个返
回值 report 保存战报；未提供接收参数则直接打印于命令窗。

在 simbattle 中，每次调用 equation(attacker, defender) 及换顺序调用，计算伤害
。根据某一方的血量(.hp)判断胜负。所以前两个参数必须要有 .hp 域名，此外可以拥有
任意域值，在 equation 函数可取双方的属性以任意方式计算伤害，最后返回一个伤害值
。

模型限制：只支持单向伤害，即在 A 攻击 B 的回合，除了造成对 B 的伤害，虽然支持
任意伤害计算方式，但此外不能有其他任意影响，A 不会被反伤，双方的其他属性在战斗
模拟过程中不变。通过改写 equation 支持即时生效的技能伤害，但不支持持续性 buff
。

常用战斗公式
-----------

- equsubtract, 减法公式
- equmultiply, 乘法公式
- equdivide,   除法公式

注意这些公式函数的输入参数是具体的攻击、防御属性，及其他必要参数。不能直接传递
给 simbattle 的第三参数，因为 simbattle 的三参数接收的是“对象”，而不是单一属
性。需要对常用公式进行一层包装才能传递给 simbattle 函数。
示例参考 example/testsim.m。

对于复杂的伤害公式或计算流程，建议单独写个 .m 文件函数，直接以包含所有属性的对
象（struct 即可，但也不介意用 class object）作为输入参数。然后用 @ 取函数句柄
传给 simbattle 驱动战斗模拟。

扩展模拟战斗：cpxbattle
-----

	[victory, report] = cpxbattle(attacker, defender, equation, option)

cpxbattle 是对 simbattle 的扩展，用法相似。不过 cpxbattle 支持的战斗公式，即
equation 参数句柄所引用的函数，允许在其内以计任意方式计算并修改双方的属性，并
可以利用回合数信息，最后返回修改后的对象。

自定义 equation 应该写在独立的文件函数或同文件的子函数中，定义形如：

	[A B] = equsample(A, B, t)

可参考 example/equsample.m。

cpxbattle 模拟还支持自定义失败条件，使用 option.fail 引用另个函数句柄，还可用
option.fail1, option.fail2 分别定义两个单位不同的失败条件。默认共用
option.fail 的失败条件，未指定时就按血量 .hp 降到 0 认为失败。fail 函数要求接
受两个参数，战斗单位结构，与时间回合数，形如：

	tf = fail10(X, t)

完整的示例见 example/testcpx.m
