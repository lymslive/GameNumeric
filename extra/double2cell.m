% 将数值矩阵转化的为元胞矩阵
% 输入：
%   d, 普通数值矩阵
%   tochar, logical, 是否将每个数值转化为字符串，默认不转化
% 输出：
%   c, 元胞矩阵，每个元胞是一个标量字符串(tochar=true)或标量数值
function c = double2cell(d, tochar)

if nargin < 2
	tochar = false;
else
	tochar = true;
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
		if tochar
			c{i, j} = num2str(val);
		else
			c{i, j} = val;
		end

	end
end

end %F-main
