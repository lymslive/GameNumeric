parent = addParentPath();

% 设定战斗双方的基本属性
A.hp = 100;
A.atk = 20;
A.def = 10;
A.cst = 10;
% 暴击，可以设计更多属性，取决于 equation 调用是否用到这属性
% equation 需要的参数必须要有，多余的属性忽略
A.baoji = 50;

B.hp = 100;
B.atk = 20;
B.def = 10;
B.cst = 10;

disp('减法公式模拟')
% 在减法公式中，忽略 .cst 属性，它只在乘法公式用到
equation = @(A, B) equsubtract(A.atk, B.def);
simbattle(A, B, equation),

disp('乘法公式模拟')
equation = @(A, B) equmultiply(A.atk, B.def, A.cst);
simbattle(A, B, equation),

disp('除法公式模拟')
equation = @(A, B) equdivide(A.atk, B.def);
simbattle(A, B, equation),

% 传给 simbattle 的 equation 函数句柄，除了用逆名函数
% 也可以直接用 @function_filename
% 但独立文件中的函数，接收参数是 A, B 结构体，而非仅其 atk 或 def
% 因而可表达更复杂的战斗伤害计算，只要函数返回是单次伤害值

disp('保存战斗于变量中，过程中不打印到命令窗')
[vic rep] = simbattle(A, B, equation);
vic
rep
for i = 1 : length(rep)
	disp(rep{i});
end

disp('传入选项，但忘记设定相应域名')
option = struct;
[vic2 rep2] = simbattle(A, B, equation, option);
% 结果既在窗口输出，也保存于变量 rep2 中
%

rmpath(parent);
