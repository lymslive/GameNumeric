% 问题：马氏链转移，从起点到终点需要平均多少步，平均多少消耗
%
% 输入参数：
%   Pmatrix：一步转移概率矩阵，
%   source:  起点状态
%   target:  目标状态
%   lcost：  每个状态的消耗向量，横向量
% 输出参数：
%   step: 平均步数
%   stop: 每个状态停留的次数，横向量
%   cost: 平均消耗
%
% maintain: lymslive / 2015-11
function [step, stop, cost] = markovto(Pmatrix, source, target, lcost)

	P = Pmatrix;
	c = lcost;

	[n, ~] = size(Pmatrix);
	I = eye(n);
	Ix = zeros(1, n); Ix(source) = 1;
	Iy = zeros(n, 1); Iy(target) = 1;
	Ey = I; Ey(target, target) = 0;

	if source == target
		step = 0;
		stop = 0;
		cost = 0;
	else
		ivPEy = (I-P*Ey)^(-1);
		step = Ix * ivPEy^2 * P * Iy;
		stop = Ix * ( ivPEy * P + I ) * Ey;
		cost = stop * c';
	end

end %-of main
