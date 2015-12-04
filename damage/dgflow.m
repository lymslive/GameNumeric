% dgflow: damage flow
% �˺���ģ�ͼ���
%
% ���������
% 1. �����ֵ��÷�ʽ����������ʱ����ʾ��һ�˺���
% @source: ��ʼ�˺������繥����
% @flow: �˺���ģ�Ͳ������飬����ÿһ�д���һ������ʽ�����˺�ֵ
% 
% 2. ֻ��һ���������ʱ���Ҳ�����һ�� struct ���飬��ʾ�����˺�������
% �� struct ���������������� source �� flow��ÿ��strct ��ʾһ���˺�����
%
% ���������
% @damage: �������˺�
% @static: �˺�ͳ�ơ�
%  1. ����ǵ�һ�˺�����static Ϊ����ÿ������˺�ֵ
%  2. ����Ƕ����˺�����static Ϊÿ�ֲ�ͬ���͵��˺�����ֵ
%
% maintain: lymslive / 2015-12
function [damage, static] = dgflow(source, flow)

if isstruct(source)
	% �������

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
	% �������
	if nargout > 1
		[damage, static] = singleflow(source, flow);
	else
		damage = singleflow(source, flow);
	end
end

end %-of main

%% �Ӻ���
% ���㵥���˺���
%
% ���������
% @source: ��ʼ�˺�
% @flow: �����ӿڣ�m*2 ���飬ÿ�б�ʾһ��һ�ζ���ʽ [k, b]
%  ���������������ֱ�ӵ��� polyval����˸ߴζ���ʽҲ����
%
% ���������
% @damage: �����˺�
% @middle: �м�ÿ�����˺�����һ��Ԫ�ز�������ʼ�˺�ֵ�����һ��Ԫ�ؼ������˺�
%  middle ���鳤���� flow ��ͬ, ��ʾ����ÿ������˺�
%
% ˵����
% ����˺�����ÿ������С�ڵ��� 0 �������������ֹ�˺�������
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
