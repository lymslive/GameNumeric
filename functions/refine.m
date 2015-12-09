% refine: refine a curve
% ϸ������
% ����һ���ϴֵ����߱�n*2 ����
% ���һ��ϸ�������߱�m*2 ����
%
% ���������
% @short: ���У���2���ǵ�1�еĺ�������ֻ��һЩ��ɢ�ĵ�
%  ��õ�1��Ҫ�󵥵����򣬵�2�в������ظ���ֵ
%  ÿ�е�����ֵ�൱�����һ�����ݵ�
%
% @option: ����ѡ���ѡ����
%  .method: ��ֵ������ͬinterp1 �� method ������Ĭ���� 'linear'
%  .addorigin: �Ƿ��� short ���������ֵ [0, 0]��Ĭ�� false
%  .plot: �Ƿ��ͼ�鿴��ֵ���߽��
%
% ���������
% @long: ���У���1����ϸ�����Ա�������Χ�� short �ĵ�1�е����һ��
%  ����Ĭ��Ϊ1����Ϸ���漰�����ߵ��Ա���һ������Ȼ��
%  �� short ������δָ�����м�㣬�ò�ֵ�ķ�ʽ���
%
% ����˵����
% �㷨��Ҫ���� interp1 ��ֵ����
%
% maintain: lymslive / 2015-11
function long = refine(short, option)

if nargin < 2
	option = struct;
elseif ~isstruct(option)
	error('refine() expect option as a struct');
end

if size(short, 2) ~= 2
	error('refine() expect a tow-column array as input');
end

if isfield(option, 'addorigin') && option.addorigin
	short = [0, 0; short];
end
if isfield(option, 'method')
	method = option.method;
else
	method = 'linear';
end

n = size(short, 1);

start = short(1, 1);
stop = short(n, 1);

x = [start : stop]';
y = interp1(short(:,1), short(:,2), x, method);

long = [x, y];

if isfield(option, 'plot') && option.plot
	plot(x, y, 'b-', short(:, 1), short(:, 2), 'ro');
end

if isfield(option, 'addorigin') && option.addorigin
        long(1,:) = [];
end

end %-of main
