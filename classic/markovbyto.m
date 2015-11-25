% ���⣺������ת�ƣ�����㾭���̶��������ܴﵽǰ��ĳ���ĸ���
% 
% ���������
%   Pmatrix��һ��ת�Ƹ��ʾ���
%   source:  ���״̬
%   target:  Ŀ��״̬
%   step: ת�Ʋ���
% ���������
%   p: �ܵ���Ŀ��״̬�ĸ���
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
