% 设定一个键的值，若无，则添加到末尾
% 要求 key 是或能转化至标量字符串，否则 error
function obj = set(obj, key, val)

if nargin < 2
	error('Too less input to sHash.set(key, val)!');
end
if nargin < 3
	val = [];
end

if ~sHash.isstrkey(key)
	key = sHash.tostrkey(key);
end

done = false;
i = 0;
len = size(obj.pairs, 2);
while i < len
	i = i + 1;
	if strcmp(key, obj.pairs{1, i})
		obj.pairs{2, i} = val;
		done = true;
		break;
	end
end

if ~done
	obj.pairs{1, i+1} = key;
	obj.pairs{2, i+1} = val;
end

end
