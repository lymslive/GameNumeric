% cpxbattle: 'complex battle' relate to simbattle
% 扩展的战斗模拟框架
%
% Input:
%   @attacker: 攻击方，结构体，struct
%   @defender: 受击方，结构体，struct
%   @equation: 伤害公式，函数句柄
%   @option: 其他选项，struct 结构体
%    option.print: true/false 是否在命令窗打印战报
%    option.save: true/false 是否将战报保存在一个 cellstr 中
%      如果省略参数 option, 则根据输出参数个数决定只打印可只保存在返回变量中
%    option.fail: 函数句柄，定制如何判断胜负的函数，默认按血量判负
%    option.fail1, option.fail2 也可以为前两个参数单位分别定制失败条件
%      默认共用 option.fail
%    option.detail: true/false: 除了文件战报，保存更多数据信息
%      须要 option.save 不为 false 会返回 report 才有意义
%
% Output:
%   @victory: 攻击方是否胜利，正数胜利，负数失败，绝对值表示战斗回合数
%   @report: 战报，字符串数组，cellstr，cell(n, 1) 列向量元胞
%     如果 option.detail == true, 则扩展 report，后面增加三列
%     report(:, 2) 保存回合数信息，第一行 report{1, 2} 是 0
%     report(:, 3) 保存第一个单位(attacker)在每个行动回合后的状态
%     report(:, 4) 保存第二个单位(defender)在每个行动回合后的状态
%     注意：每个回合有正负两个回合，分别表示两个单位的行动回合（行动后状态）
%     最后一行 report{end,1} 只是标记结束文本，后面三个 cell 为空
%     所以数据比文本少一行
%
% remark:
%  1. 假设恒速回合制 1v1 模型，attacker 先攻击
%  2. 每回合调用两次战斗公式，让攻防双方互相攻击
%     [A B] = equation(A, B, turn)
%     [B A] = equation(B, A, turn)
%     equation 函数接收的参数，A,B 是表示攻防双方的结构体，turn 是回合数
%     返回原来的参战对象 AB，其中的属性（主要是血量）可能被修改
%  3. 如果未指定 option.fail，则
%     attacker, defender 结构体要求有 .hp 或 .h 域名表示血量属性，
%     其他属性可自命名，只要所调用的 equation 与 fail 也使用匹配的属性域名
%  4. 战报格式:
%     Round +%2d:\tA --> B;\tA.hp -> %d;\tB.hp -> %d
%     用 AB 代表对抗双方，用+/-表示各自的回合，列出本次行动后双方的剩余血量
%     请注意详细战报，最后一行后三列为空
%
% see also: simbattle
%
% maintain: lymslive / 2015-11

function [victory, report] = cpxbattle(attacker, defender, equation, option)

	A = attacker;
	B = defender;

	if nargin < 4 || ~isstruct(option)
		option = struct;
		if nargout < 2
			option.print = true;
			option.save = false;
		else
			option.print = false;
			option.save = true;
		end
		option.fail = @fail;
	else
		if ~isfield(option, 'print')
			option.print = true;
		end
		if ~isfield(option, 'save')
			option.save = true;
		end
		if ~isfield(option, 'fail')
			option.fail = @fail;
		end
	end
	if ~isfield(option, 'fail1')
		option.fail1 = option.fail;
	end
	if ~isfield(option, 'fail2')
		option.fail2 = option.fail;
	end

	report = {};
	replen = 0;
	turn = 0;
	str = '';
	win = '';

	str = sprintf('Start:\tA <-> B;\tA.hp -> %d,\tB.hp -> %d', A.hp, B.hp);
	% 内嵌函数，处理战报
	function dealreport(str, turn)
	if option.print 
			disp(str);
		end
		if option.save
			replen = replen + 1;
			report{replen, 1} = str;
		end
		if nargin > 1 && isfield(option, 'detail') && option.detail
			report{replen, 2} = turn;
			report{replen, 3} = A;
			report{replen, 4} = B;
		end
	end
	dealreport(str, turn);

	while true
		turn = turn + 1;

		% 进入回合时刻，先判断有没谁输
		if option.fail1(A, turn)
			win = 'B';
			break;
		end
		if option.fail2(B, turn)
			win = 'A';
			break;
		end

		% 先进入 A 的行动回合，A 攻击 B
		[A, B] = equation(A, B, turn);
		str = sprintf('Round +%2d:\tA --> B;\tA.hp -> %d,\tB.hp -> %d', turn, A.hp, B.hp);
		dealreport(str, turn);

		if option.fail2(B, turn)
			win = 'A';
			break;
		elseif option.fail1(A, turn)
			win = 'B';
			break;
		end

		% 然后进入 B 的行动回合，B 攻击 A
		[B, A] = equation(B, A, turn);
		str = sprintf('Round -%2d:\tB --> A;\tA.hp -> %d,\tB.hp -> %d', turn, A.hp, B.hp);
		dealreport(str, -turn);

		if option.fail1(A, turn)
			win = 'B';
			break;
		elseif option.fail2(B, turn)
			win = 'A';
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

end %-of main

%% 子函数
% 默认的判断失败函数，血量小于0，域名用 .hp 或 .h
function tf = fail(st, turn)
	if isfield(st, 'hp')
		tf = st.hp <= 0;
	elseif isfield(st, 'h')
		tf = st.h <= 0;
	else
		error('a battle unit should has .hp or .h field!');
	end
end %-of fail
