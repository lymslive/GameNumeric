% 索引赋值重载，用于快捷修改属性值矩阵
function obj = subsasgn(obj, subst, val)

first = subst(1);
if ~strcmp(first.type, '.')
	obj = builtin('subsasgn', obj, subst);
	return;
end

firstName = first.subs;
if ismember(firstName, [properties(obj); methods(obj)])
	obj = builtin('subsasgn', obj, subst);
	return;
end

newobj = obj.subsref(subst);
node = newobj.self;

m = numel(node);
atnames = fieldnames(node(1).at);
n = numel(atnames);
[vm vn] = size(val);
if m ~= vm || n ~= vn
	error('matrix dementions in inconsistent with atrribute values!');
end

if ~iscellstr(val)
	val = xmlel.tostrval(val);
end

newat = struct;
for i = 1 : m
	for j = 1 : n
		newat.(atnames{j}) = val{i,j};
	end
	node(i).at = newat;
end

end %F-main
