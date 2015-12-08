% 将数值矩阵转化的为字符元胞矩阵
% 输入：
%   d, 普通数值矩阵
%   keep, logical, 保持 cell 内保存数字，默认 false，即转为字符串
% 输出：
%   c, 元胞矩阵，每个元胞是一个标量字符串或标量数值(keep=true)
function c = tostrval(d, keep)

if nargin < 2
	keep = false;
else
	keep = true;
end

if ~isnumeric(d)
	error('expects a numeric matrix!');
	return;
end

[m n] = size(d);
c = cell(m, n);
for i = 1 : m
	for j = 1 : n

		val = d(i, j);
		if ~keep
			c{i, j} = num2str(val);
		else
			c{i, j} = val;
		end

	end
end

end %F-main
