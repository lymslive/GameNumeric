% pathseg: 路径分隔
% 将 xpath 解析为片断，输出 cellstr
% 第一列，路径中各级元素名，如 root element subelement
% 第二列，条件，如 [1] [@id=100]
% onlyname，只返回第一列，默认 false，即返回全部两列
function cpath = pathseg(obj, onlyname)

sp = regexp(obj.xpath, '/', 'split');
if isempty(sp{1})
	sp(1) = [];
end

len = numel(sp);
cpath = cell(len, 2);
expr = '^(.+)\[(.*)]$';
for i = 1 : len
	part = sp{i};
	tok = regexp(part, expr, 'tokens', 'once');
	name = tok{1};
	cond = tok{2};
	cpath(i, :) = {name, cond};
end

end %F-main
