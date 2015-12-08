% 根据键删除一个元素，返回被删除的那个值
% 空参则清空所有元素，初始化 hash table，返回空
% 
function val = remove(obj, key)

if nargin < 2
	obj.pairs = {};
	val = [];
	return;
end

if ~sHash.isstrkey(key)
	key = sHash.tostrkey(key);
end
for i = 1 : size(obj.pairs, 2)
	if strcmp(key, obj.pairs{1, i})
		val = obj.pairs{2, i};
		obj.pairs(:, i) = [];
		break;
	end
end
end %F-main
