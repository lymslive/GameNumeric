% 重载点号索引与 {} 索引
% obj.key obj{key} 根据键索引值，key 为标量字符串
function sref = subsref(obj, subst)

if numel(obj) > 1
	sref = builtin('subsref', obj, subst);
	return;
end

first = subst(1);
switch first.type
case '.'
	name = first.subs;
	if ismember(name, [properties(obj); methods(obj)])
		sref = builtin('subsref', obj, subst);
		return;
	else
		key = name;
		sref = obj.get(key);
	end

case '{}'
	index = first.subs;
	if numel(index) == 1
		key = index{1};
		sref = obj.get(key);
	else
		error('sHash{key} exepcts a scalar index as key!');
	end

case '()'
    sref = builtin('subsref', obj, subst);
	return;

otherwise
	error('unkown or unspported subsref type!');
end

if numel(subst) > 1
	sref = builtin('subsref', sref, subst(2:end));
end

end %F
