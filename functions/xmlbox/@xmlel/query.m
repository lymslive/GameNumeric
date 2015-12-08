% 解析 xpath
% 输入参数：
%   subpath: 以 / 认为是绝对路径，否则是相对路径
%   atnames: {属性名列表}, cellstr
% 输出参数：
%   node: xmlel 列表，如果路径以 @ 结束，返回的是属性值组成的 cellstr
% 注：
%   subpath 的最后一部分可用 /@name 或多个列表 /[@name, @name, ...]
%   [] 可选，属性名分隔符可用,或空格等非字母符号
%   该表示法比第三参数 atnames 的优先级高
function node = query(obj, subpath, atnames)

if nargin < 2 || isempty(subpath)
	node = obj;
	return;
end

if nargin < 3
	atnames = {};
end

if subpath(1) == '/'
	start = obj.getRoot();
	if isempty(start)
		node = [];
		return;
	end
else
	start = obj;
end

cpath = xmlel.pathseg(subpath);
if isempty(cpath)
	node = start;
	return;
end

if subpath(1) == '/' && strcmp(cpath{1,1}, start.name)
	% skip the right /rootName
	cpath(1, :) = [];
	if isempty(cpath)
		node = start;
		return;
	end
end

% strip the last part if only @attribute list
if isempty(cpath{end, 2})
	last = cpath{end, 1};
	tok = regexp(last, '@(\w+)', 'tokens');
	if ~isempty(tok)
		atnames = {};
		for i = 1 : numel(tok)
			atnames = [atnames, tok{i}];
		end
		cpath(end, :) = [];
	end
end

len = size(cpath, 1);
node = start;

haserror = false;
for i = 1 : len
	name = cpath{i, 1};
	cond = cpath{i, 2};
	newset = xmlel.empty();

	for j = 1 : numel(node)
		je = node(j);

		jchild = je.child.getElement(name);
		if isempty(jchild)
			haserror = true;
			node = [];
			return;
		end
		if ~isempty(cond)
			% strip out [] around
			tok = regexp(cond, '\[(.+)\]', 'tokens', 'once');
			if ~isempty(tok)
				cond = tok{1};
			end
			subel = jchild.filterat(cond);
		else
			subel = jchild;
		end

		newset = [newset; subel];
	end

	node = newset;
end

if ~isempty(atnames)
	m = numel(node);
	n = numel(atnames);
	atval = cell(m, n);
	for i = 1 : m
		for j = 1 : n
			try
				atval{i,j} = node(i).at.(atnames{j});
			catch
				haserror = true;
				node = [];
				return;
			end
		end
	end
	node = atval;
end

end %F-main
