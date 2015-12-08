% 返回一个键
% 键不存在报错
% 空参返回所有键值对，2*n cell
function val = get(obj, key)

if nargin < 2
	sh = obj.sHash();
	val = sh.get();
end

if ~sHash.isstrkey(key)
	key = sHash.tostrkey(key);
end

code = qHash.hashcode(key);
idx = mod(code, obj.capacity);
if idx == 0
	idx = obj.capacity;
end

val = obj.hlist(idx).get(key);

end %F-main
