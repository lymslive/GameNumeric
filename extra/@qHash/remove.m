% 根据键删除一个元素，返回被删除的那个值
% 空参则清空所有元素，初始化 hash table，返回空
function val = remove(obj, key)

if nargin < 2
	obj.hlist = sHash.empty(0,1);
	val = [];
	return;
end

if ~sHash.isstrkey(key)
	key = sHash.tostrkey(key);
end

code = qHash.hashcode(key);
idx = mod(code, obj.capacity);
if idx == 0
	idx = obj.capacity;
end

val = obj.hlist(idx).remove(key);

end %F-main
