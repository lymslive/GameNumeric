% ����һ��ս��ģ��
% �����˺���ʽ�ó���
% A �� B�������ж����غϣ������ӣ�ʹB ���Լ��ж��غ���10���˺� 
% B �з��ˣ�ÿ�α������� 10 ���˺�
% (ʵ��Ч����������������10�˺�����)
% ע�⣺�ú��������������ã�
% �� cpcbattle ÿ���Զ��������Σ��� A/B �ĵ���˳����
function [A B] = equsample(A, B, t)

	% �����˺������ó�����ʽ
	dh = equdivide(A.atk, B.def);
	dh = floor(dh);
	B.hp = B.hp - dh;

	% ���뷴�˶��򵥹̶� 10 �˺�
	du = 10;
	fs = 10;

	% ���� B �ı����غ�
	% ����ж����ڶԷ��ж�ʱҲ��Ѫ����ȡ��ע�����
	% if isfield(B, 'isdu') && B.isdu
		% if t - B.duStart < 2
			% B.hp = B.hp - du;
		% else
			% B.isdu = false;
		% end
	% end

	% ���� A B �ǻ����ģ�����˳������Ƿ�������
	% ���øú���ʱ���� A ���Լ��ж��غ�
	if isfield(A, 'isdu') && A.isdu
		if t - A.duStart < 2
			A.hp = A.hp - du;
		else
			% �����غϣ��ж� debuff ��ʧ
			A.isdu = false;
		end
	end

	% ��� A ���������������¶��ļ���
	if isfield(A, 'candu') && A.candu
		if ~isfield(B, 'isdu') || ~B.isdu
			% ��� B δ�ж����������ж����������ж���ʼʱ�䣨�غϣ�
			B.isdu = true;
			B.duStart = t;
			% B.hp = B.hp - du;
			% �����趨 A �ܱض��� B �ж�������Ϸ����Ӧ���Ǹ������ж�
		else
			% B �Ѿ��ж������ܵ��ӵĻ�ʲô��Ҳ������
		end
	end

	% ��� B �����������з��˼��ܣ��� A Ҳ����һ���˺�
	if isfield(B, 'canfs') && B.canfs
		A.hp = A.hp - fs;
	end

	% ������β���� A B ��״̬����

end %-of main

%%
% ģ����һ ��
% A��һ�غ���B�ж���B �������غϻ�ֹͣ�ж��������Ļغϲ������ж�
% ���� B ���ж�һ�غϣ���ÿ�غ� A �� B ������
% ������غϺ�B����ʤ�ƣ������Bʤ��A ��������
