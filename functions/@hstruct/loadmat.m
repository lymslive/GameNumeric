% loadmat: static method load from a file
% 从文件中加载 mat 数据，并包装 struct 为对象
%
% 输入参数：
% @file: 路径全名，后缀 .mat 可选
% @className: 类名，将 mat 加载为 struct 后包装为哪个类
%  缺省的话从 .Class_ 中读取类名，也没有的话用 hstruct
%
% 输出参数：
% @hst: 构造的对象
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
