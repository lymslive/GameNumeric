% 问题：马氏链转移，从起点经过固定步数，能达到前面某步的概率
% 
% 输入参数：
%   Pmatrix：一步转移概率矩阵，
%   source:  起点状态
%   target:  目标状态
%   step: 转移步数
% 输出参数：
%   p: 能到达目标状态的概率
%
% maintain: lymslive / 2015-11
function p = markovbyto(Pmatrix, source, target, step)

	T = Pmatrix;
	[n, ~] = size(Pmatrix);
	Ix = zeros(1, n); Ix(target) = 1;
	T(target, :) = Ix;
	R = T^step;
	p = R(source, target);
end %-of main
