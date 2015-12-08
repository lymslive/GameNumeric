% 将 hash 表中所有的键值对转化为字符表示
% key=val, key=val, ..., key=val
% 如果 val 不是简单数字或字符串，转表示为 {class[size]}，显示类型与大小
function str = char(obj, sep)

if nargin < 2
	sep = ', ';
end

str = '';
for i = 1 : size(obj.pairs, 2)
	key = obj.pairs{1, i};
	val = obj.pairs{2, i};

	try
		valstr = sHash.tostrkey(val);
	catch
		name = class(val);
		dems = size(val);
		valstr = sprintf('{%s%s}', name, mat2str(dems));
	end

	pairstr = sprintf('%s=%s', key, valstr);
	if isempty(str)
		str = pairstr;
	else
		str = [str sep pairstr];
	end
end

end %F
