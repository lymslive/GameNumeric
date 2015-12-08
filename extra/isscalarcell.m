% 判断一个变量是否为只包含标量的元胞矩阵
% 标量字符串，或标量数值
function tf = isscalarcell(c)

tf = true;
if ~iscell(c)
	tf = false;
	return;
end

[m n] = size(c);
for i = 1 : m
	for j = 1 : n

		val = c{i, j};
		if ischar(val)
			if size(val, 1) > 1
				tf = false;
				return;
			end

		elseif isnumeric(val)
			if numel(val) > 1
				tf = false;
				return;
			end

		else
			tf = false;
			return;
		end
	end
end

end
