% ���⣺������ת�ƣ�����㵽�յ���Ҫƽ�����ٲ���ƽ����������
%
% ���������
%   Pmatrix��һ��ת�Ƹ��ʾ���
%   source:  ���״̬
%   target:  Ŀ��״̬
%   lcost��  ÿ��״̬������������������
% ���������
%   step: ƽ������
%   stop: ÿ��״̬ͣ���Ĵ�����������
%   cost: ƽ������
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
