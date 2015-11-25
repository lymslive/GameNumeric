% ���⣺������ת�ƣ�����㾭���̶�������ƽ����ǰ�����Ĳ�������������
%
% ���������
%   Pmatrix��һ��ת�Ƹ��ʾ���
%   source:  ���״̬
%   step: ת�Ʋ���
%   lcost��  ÿ��״̬������������������
% ���������
%   target:  Ŀ��״̬
%   cost: ƽ������
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
