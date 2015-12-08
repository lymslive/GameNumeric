% pathseg: 路径分隔
% 将 xpath 解析为片断，输出 cellstr
% 第一列，路径中各级元素名，如 root element subelement
% 第二列，条件，如 [1] [@id=100]，包含 []
% onlyname，只返回第一列，默认 false，即返回全部两列
function cpath = pathseg(pathstr, onlyname)

if nargin == 0
	cpath = {};
	return;
end

if ~isscalarstring(pathstr)
	error('expects a scalar string input as xpath!');
end

if nargin < 2
	onlyname = false;
end

sp = regexp(pathstr, '/', 'split');
if isempty(sp{1})
	sp(1) = [];
end
if isempty(sp{end})
	sp(end) = [];
end

len = numel(sp);
cpath = cell(len, 2);
expr = '^\s*(.+)\s*(\[.*\])?\s*$';
for i = 1 : len
	part = sp{i};
	tok = regexp(part, expr, 'tokens', 'once');
	try
		name = tok{1};
		cond = tok{2};
		cpath(i, :) = {name, cond};
	catch
		cpath(i, :) = {'', ''};
	end
end

if onlyname
	cpath = cpath{:, 1};
end

end %F-main
