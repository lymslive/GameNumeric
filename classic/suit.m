% ��װ�ռ����⣺
%  ĳ��װ�� n ��װ����ɣ�ÿ��ɱ boss ����ֻ������һ�������ļ��ɸ������ʾ�����
%  ����Ҫ�ռ�����װƽ����Ҫɱ boss ����
%
% ���������
%   Pvec, ÿ�������Ĳ������ʣ����⡣
%   һά������Ԫ�ض�С��1ʱ��Ϊ���ʣ�����1ʱ��ΪȨ�أ�������������������
% ���������
%   avgnum, ������������������
% ע�⣺
%   combntns �������ں���Matlab�汾���������� nchoosek
%
% maintain: lymslive / 2015-11

function avgnum = suit(Pvec)

	if any(Pvec < 0 )
		error('probability should positive float, or int as weight');
	end

	if sum(Pvec) <= 1
		P = Pvec;
	else
		P = Pvec/sum(Pvec);
	end

	n = length(Pvec);
	avgnum = 0;
	for i = 1 : n
		avgnum = avgnum + (-1)^(i+1) * sum( 1 ./ sum(nchoosek(P,i),2) );
	end

end %-of main
