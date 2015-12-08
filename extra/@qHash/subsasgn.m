% 重载点号索引与 {} 索引赋值
% obj.key obj{key} 根据键索引值，key 为标量字符串
% obj(idx) 不支持赋值
function obj = subsasgn(obj, subst, val)

if numel(obj) > 1
	sref = builtin('subsref', obj, subst);
	return;
end

first = subst(1);
switch first.type
case '.'
	name = first.subs;
	if ismember(name, properties(obj))
		obj = builtin('subsasgn', obj, subst, val);
		return;
	else
		key = name;
	end

case '{}'
	index = first.subs;
	if numel(index) == 1
		key = index{1};
	else
		error('qHash{key} exepcts a scalar index as key!');
	end

case '()'
	error('qHash(idx) support subsref but not subsasgn!');

otherwise
	error('unkown or unspported subsref type!');
end

try
	sref = obj.get(key);
	if numel(subst) > 1
		sref = builtin('subsasgn', sref, subst(2:end), val);
	else
		sref = val;
	end
catch
	sref = val;
end

obj.set(key, sref);

end %F
