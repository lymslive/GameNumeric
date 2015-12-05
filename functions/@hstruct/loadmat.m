% loadmat: static method load from a file
% ���ļ��м��� mat ���ݣ�����װ struct Ϊ����
%
% ���������
% @file: ·��ȫ������׺ .mat ��ѡ
% @className: �������� mat ����Ϊ struct ���װΪ�ĸ���
%  ȱʡ�Ļ��� .Class_ �ж�ȡ������Ҳû�еĻ��� hstruct
%
% ���������
% @hst: ����Ķ���
%
% maintain: lymslive / 2015-12-05
function hst = loadmat(file, className)

if ~ischar(file) || size(file, 1) > 1
	error('user:hstruct:loadmat', 'expect a string as filename');
end

if length(file) < 5 || ~strcmp(file(end-3:end), '.mat')
	file = [file, '.mat'];
end

if nargin < 2 || isempty(className)
	className = me.get('Class_');
	if isempty(className)
		className = 'hstruct';
	end
end

st = load(file);
evalstr = sprintf('%s(st);', className);
try
	hst = eval(evalstr);
catch
	hst = [];
end

end %F
