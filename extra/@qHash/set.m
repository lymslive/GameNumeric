% 设定一个键
% 自动添加不存在的键，自动扩容
function obj = set(obj, key, val)

if ~sHash.isstrkey(key)
	key = sHash.tostrkey(key);
end
if nargin < 3
	val = [];
end

if obj.capacity == 0 || obj.factor > qHash.overload
	obj.enlarge();
end

code = qHash.hashcode(key);
idx = mod(code, obj.capacity);
if idx == 0
	idx = obj.capacity;
end

obj.hlist(idx).set(key, val);

end %F-main
