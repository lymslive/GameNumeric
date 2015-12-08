% queryset: 根据 xpath 筛选元素或属性赋值
% 参考 query
% 第二个参数 atnames 可省略，或留空，省略的话，第二参数视为要设的新值
function obj = queryset(obj, subpath, atnames, val)

if nargin < 3
	return;
end

if nargin == 3
	val = atnames;
	atnames = {};
end

if ~isempty(subpath)
	cpath = xmlel.pathseg(subpath);
	if isempty(cpath{end, 2})
		last = cpath{end, 1};
		tok = regexp(last, '@(\w+)', 'tokens');
		if ~isempty(tok)
			atnames = {};
			for i = 1 : numel(tok)
				atnames = [atnames, tok{i}];
			end
			cpath(end, :) = [];
			sep = strfind(subpath, '/');
			if numel(sep) > 1
				subpath(sep(end):end) = [];
			end
		end
	end
end
node = query(obj, subpath);

if isempty(atnames)
	atnames = fieldnames(node(1).at);
end

m = numel(node);
n = numel(atnames);
[vm vn] = size(val);
if m ~= vm || n ~= vn
	error('matrix dementions in inconsistent with atrribute values!');
end

if ~iscellstr(val)
	val = xmlel.tostrval(val);
end

for i = 1 : m
	newat = node(i).at;
	for j = 1 : n
		newat.(atnames{j}) = val{i,j};
	end
	node(i).at = newat;
end

end %F-main
