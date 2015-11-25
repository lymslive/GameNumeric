function result = test()

	% 获得当前脚本文件名，将父目录添加到 path 中
	% 以便能用上层目录中的函数
	filename = mfilename('fullpath');
	[pathstr, name, ext] = fileparts(filename);
	parent = regexprep(pathstr, '\w+$', '');
	addpath(parent);

	% 单位 A 的基本属性
	A.hp = 100;
	A.atk = 20;
	A.def = 10;

	% B 的基本属性先设为与A等同
	B = A;

	% 增加特殊属性，A 能中毒，B 能反伤
	A.candu = true;
	B.canfs = true;

	% 模拟战斗，战斗公式调用 equsample.m
	vic = cpxbattle(A, B, @equsample);
	disp(vic);

	% 定制失败条件
	option.fail = @fail10;
	vic = cpxbattle(A, B, @equsample, option);
	disp(vic);

	% 第2个单位（B）超时算输
	% 也即第1个单位（A）只要坚持一定回合算赢
	option = struct;
	option.fail2 = @failtime;
	vic = cpxbattle(A, B, @equsample, option);
	disp(vic);

	% 保存详细数据信息
	option = struct;
	option.detail = true;
	[vic, report] = cpxbattle(A, B, @equsample, option);
	disp(vic);
	% 将战报详情返回能函数调用者分析
	result = report;

	% 恢复 path
	rmpath(parent);


end %-of main

%% 失败条件函数比较简单，就写在同一个文件了
% 也可以像 @equsample 一样写在独立文件中，或直接用匿名函数
%
% 定制失败条件，咱不要往死里打，打到10点血量就分胜负吧
function tf = fail10(X, t)
	tf = X.hp <= 10;
end

% 超过 4 回合就算输
function tf = failtime(X, t)
	tf = t > 4;
end
