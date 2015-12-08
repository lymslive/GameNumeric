% 查找一个键，若无，抛出 error
% 空参，返回所有键值对，即内置 cell
function val = get(obj, key)

val = [];
if nargin < 2
	val = obj.pairs;
	return;
end

if ~sHash.isstrkey(key)
	key = sHash.tostrkey(key);
end

done = false;
for i = 1 : size(obj.pairs, 2)
	if strcmp(key, obj.pairs{1, i})
		val = obj.pairs{2, i};
		done = true;
		break;
	end
end

if ~done
	error('sHash cannot find key: (%s)!', key);
end

end %F
