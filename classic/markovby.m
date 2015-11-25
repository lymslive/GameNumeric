% 问题：马氏链转移，从起点经过固定步数，平均能前进到哪步，及多少消耗
%
% 输入参数：
%   Pmatrix：一步转移概率矩阵，
%   source:  起点状态
%   step: 转移步数
%   lcost：  每个状态的消耗向量，横向量
% 输出参数：
%   target:  目标状态
%   cost: 平均消耗
%
% maintain: lymslive / 2015-11
function [target cost] = markovby(Pmatrix, source, step, lcost)

	P = Pmatrix;
	c = lcost;

	[n, ~] = size(Pmatrix);
	I = eye(n);
	Ix = zeros(1, n); Ix(source) = 1;

	if source == n
		target = n
	else
		R = P^step;
		target = [1:1:n] * R(source, :)';
	end

	Q = zeros(n);
	for i = 1 : step
		Q = Q + P^(i-1);
	end
	cost = Ix * Q * c';
end %-of main
