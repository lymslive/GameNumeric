function result = test()

	% ��õ�ǰ�ű��ļ���������Ŀ¼��ӵ� path ��
	% �Ա������ϲ�Ŀ¼�еĺ���
	filename = mfilename('fullpath');
	[pathstr, name, ext] = fileparts(filename);
	parent = regexprep(pathstr, '\w+$', '');
	addpath(parent);

	% ��λ A �Ļ�������
	A.hp = 100;
	A.atk = 20;
	A.def = 10;

	% B �Ļ�����������Ϊ��A��ͬ
	B = A;

	% �����������ԣ�A ���ж���B �ܷ���
	A.candu = true;
	B.canfs = true;

	% ģ��ս����ս����ʽ���� equsample.m
	vic = cpxbattle(A, B, @equsample);
	disp(vic);

	% ����ʧ������
	option.fail = @fail10;
	vic = cpxbattle(A, B, @equsample, option);
	disp(vic);

	% ��2����λ��B����ʱ����
	% Ҳ����1����λ��A��ֻҪ���һ���غ���Ӯ
	option = struct;
	option.fail2 = @failtime;
	vic = cpxbattle(A, B, @equsample, option);
	disp(vic);

	% ������ϸ������Ϣ
	option = struct;
	option.detail = true;
	[vic, report] = cpxbattle(A, B, @equsample, option);
	disp(vic);
	% ��ս�����鷵���ܺ��������߷���
	result = report;

	% �ָ� path
	rmpath(parent);


end %-of main

%% ʧ�����������Ƚϼ򵥣���д��ͬһ���ļ���
% Ҳ������ @equsample һ��д�ڶ����ļ��У���ֱ������������
%
% ����ʧ���������۲�Ҫ������򣬴�10��Ѫ���ͷ�ʤ����
function tf = fail10(X, t)
	tf = X.hp <= 10;
end

% ���� 4 �غϾ�����
function tf = failtime(X, t)
	tf = t > 4;
end
