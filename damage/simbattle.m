% simbattle: simulate battle or simple battle
% 战斗模拟框架方法
%
% Input:
%   @attacker: 攻击方，结构体，struct
%   @defender: 受击方，结构体，struct
%   @equation: 伤害公式，函数句柄
%   @option: 其他选项，struct 结构体
%    option.print: true/false 是否在命令窗打印战报
%    option.save: true/false 是否将战报保存在一个 cellstr 中
%    如果省略参数 option, 则根据输出参数个数决定只打印可只保存在返回变量中
%
% Output:
%   @victory: 攻击方是否胜利，正数胜利，负数失败，绝对值表示战斗回合数
%   @report: 战报，字符串数组，cellstr，cell(n, 1) 列向量元胞
%
% remark:
%  1. 假设恒速回合制 1v1 模型，attacker 先攻击
%  2. 调用 equation(A, B) 计算每次伤害，
%     equation 函数接收的参数，A,B 是表示攻防双方的结构体
%     返回伤害值，伤害若出现小数，向下取整，可能为 0
%  3. attacker, defender 结构体要求有 .hp 域名表示血量属性，
%     其他属性可自命名，只要所调用的 equation 也使用匹配的属性域名
%  4. 战报格式:
%     Round +%2d: A --> B damage %d; B.hp -> %d
%     用 AB 代表对抗双方，用+/-表示各自的回合，列出本次伤害与剩余血量
%
% see also: cpxbattle
%
% maintain: lymslive / 2015-11

function [victory report] = simbattle(attacker, defender, equation, option)

	A = attacker;
	B = defender;
	dh = 0;

	if nargin < 4 || ~isstruct(option)
		option = struct;
		if nargout < 2
			option.print = true;
			option.save = false;
		else
			option.print = false;
			option.save = true;
		end
	else
		if ~isfield(option, 'print')
			option.print = true;
		end
		if ~isfield(option, 'save')
			option.save = true;
		end
	end

	report = {};
	str = '';
	win = '';

	str = sprintf('Start: A <-> B; A.hp -> %d, B.hp -> %d', A.hp, B.hp);
	% 内嵌函数，处理战报
	function dealreport(str)
		if option.print 
			disp(str);
		end
		if option.save
			report{end+1} = str;
		end
	end
	dealreport(str);

	turn = 0;
	while true
		if A.hp <= 0 || B.hp <= 0
			break;
		end
		turn = turn + 1;

		% A 攻击 B
		dh = equation(A, B);
		dh = floor(dh);
		B.hp = B.hp - dh;
		str = sprintf('Round +%2d: A --> B damage %d; B.hp -> %d', turn, dh, B.hp);
		dealreport(str)
		
		if B.hp <= 0
			win = 'A';
			break;
		end

		% B 攻击 A
		dh = equation(B, A);
		dh = floor(dh);
		A.hp = A.hp - dh;
		str = sprintf('Round -%2d: B --> A damage %d; A.hp -> %d', turn, dh, A.hp);
		dealreport(str)

		if A.hp <= 0
			win = 'B';
			break;
		end
	end

	str = sprintf('Stop: %s wins', win);
	dealreport(str);

	if win == 'A'
		victory = turn;
	else
		victory = -turn;
	end

	if nargout > 1
		report = report';
	end

end %-of main
