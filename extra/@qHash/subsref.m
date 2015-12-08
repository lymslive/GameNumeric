% 重载点号索引与 {} 索引
% obj.key obj{key} 根据键索引值，key 为标量字符串
% obj(idx) 得到第 idx 个 sHash 对象，即所有映射到 idx 位置的元素
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
		error('qHash{key} exepcts a scalar index as key!');
	end

case '()'
	index = first.subs;
	if numel(index) == 1
		sref = obj.hlist(index);
	else
		error('qHash(idx) expects a single index to get a sHash!');
	end

otherwise
	error('unkown or unspported subsref type!');
end

if numel(subst) > 1
	sref = builtin('subsref', sref, subst(2:end));
end

end %F
