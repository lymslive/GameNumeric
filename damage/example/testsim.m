parent = addParentPath();

% �趨ս��˫���Ļ�������
A.hp = 100;
A.atk = 20;
A.def = 10;
A.cst = 10;
% ������������Ƹ������ԣ�ȡ���� equation �����Ƿ��õ�������
% equation ��Ҫ�Ĳ�������Ҫ�У���������Ժ���
A.baoji = 50;

B.hp = 100;
B.atk = 20;
B.def = 10;
B.cst = 10;

disp('������ʽģ��')
% �ڼ�����ʽ�У����� .cst ���ԣ���ֻ�ڳ˷���ʽ�õ�
equation = @(A, B) equsubtract(A.atk, B.def);
simbattle(A, B, equation),

disp('�˷���ʽģ��')
equation = @(A, B) equmultiply(A.atk, B.def, A.cst);
simbattle(A, B, equation),

disp('������ʽģ��')
equation = @(A, B) equdivide(A.atk, B.def);
simbattle(A, B, equation),

% ���� simbattle �� equation �����������������������
% Ҳ����ֱ���� @function_filename
% �������ļ��еĺ��������ղ����� A, B �ṹ�壬���ǽ��� atk �� def
% ����ɱ������ӵ�ս���˺����㣬ֻҪ���������ǵ����˺�ֵ

disp('����ս���ڱ����У������в���ӡ�����')
[vic rep] = simbattle(A, B, equation);
vic
rep
for i = 1 : length(rep)
	disp(rep{i});
end

disp('����ѡ��������趨��Ӧ����')
option = struct;
[vic2 rep2] = simbattle(A, B, equation, option);
% ������ڴ��������Ҳ�����ڱ��� rep2 ��
%

rmpath(parent);
