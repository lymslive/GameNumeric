% dgflow: damage flow
% 伤害流模型计算
%
% 输入参数：
% 1. 有两种调用方式，两个参数时：表示单一伤害流
% @source: 初始伤害，比如攻击力
% @flow: 伤害流模型参数数组，矩阵，每一行代表一个多项式修正伤害值
% 
% 2. 只有一个输入参数时，且参数是一个 struct 数组，表示多种伤害流并存
% 该 struct 包含两个域名，即 source 与 flow，每个strct 表示一种伤害类型
%
% 输出参数：
% @damage: 最终总伤害
% @static: 伤害统计。
%  1. 如果是单一伤害流，static 为流经每步后的伤害值
%  2. 如果是多种伤害流，static 为每种不同类型的伤害最终值
%
% maintain: lymslive / 2015-12
function [damage, static] = dgflow(source, flow)

if isstruct(source)
	% 并流情况

	m = length(source);
	damage = 0;
	singledamage = 0;

	if nargout > 1
		static = zeros(m, 1);
	end

	try
		for i = 1 : m
			st = source(i);
			singledamage = singleflow(st.source, st.flow);
			if nargout > 1
				static(i, 1) = singledamage;
			end
			damage = damage + singledamage;
		end
	catch
		error('dgflow() expect .source and .flow fields as input');
	end

else
	% 单流情况
	if nargout > 1
		[damage, static] = singleflow(source, flow);
	else
		damage = singleflow(source, flow);
	end
end

end %-of main

%% 子函数
% 计算单个伤害流
%
% 输入参数：
% @source: 初始伤害
% @flow: 流经接口，m*2 数组，每行表示一个一次多项式 [k, b]
%  但并不检查列数，直接调用 polyval，因此高次多项式也允许
%
% 输出参数：
% @damage: 最终伤害
% @middle: 中间每步的伤害，第一个元素不包括初始伤害值，最后一个元素即最终伤害
%  middle 数组长度与 flow 相同, 表示经过每步后的伤害
%
% 说明：
% 如果伤害流在每步出现小于等于 0 的情况，立即终止伤害流计算
function [damage, middle] = singleflow(source, flow)

damage = source;
m = size(flow, 1);
if nargout > 1
	middle = zeros(m, 1);
end

for i = 1 : n
	damage = polyval(flow(i, :), damage);
	if damage <= 0
		break;
	end
	if nargout > 1
		middle(i, 1) = damage;
	end
end

end %-of sub
