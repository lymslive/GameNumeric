% 取出由元素数组的属性值构成的矩阵
% 返回 double 矩阵，或 cell 矩阵(不能全转化为数值时)
% 默认行为：
% 如果obj全是同名元素，返回一个矩阵
% 如果有不同元素，返回 cell(m, 3)
%   第一列 cell 是元素名
%   第二列 cell 是由对应元素构成的属性值矩阵，每个元胞一个矩阵
%   第三列 是对应元素的属性名，另一个 cellstr
% 可选参数：
%   filter: 标量字符串，表示筛选元素名，只返回该元素的属性值矩阵
%   withHead: 如果 true，同时返回属性名作为表头，必须是 cell 矩阵，且多一行
%   可将 fileter 置空跳过参数位置指定 withHead，而不筛选元素名
% 重要假设规范：
%   假设同名元素的属性名排序一致，个数一致，属性值类型一致
% 注意：
%   忽略空元素与文本元素
function mat = atMatrix(obj, filter, withHead)

mat = [];
if nargin < 2
	filter = '';
end
if nargin < 3
	withHead = false;
end

names = {};
at = struct;
vec = struct;

for i = 1 : numel(obj)
	if obj(i).isTextNode() || obj(i).isEmptyNode()
		continue;
	end

	name = obj(i).name;
	if ~ismember(name, names)
		names{end+1} = name;
		if isempty(obj(i).at)
			at.(name) = {};
		else
			at.(name) = fieldnames(obj(i).at);
		end
		vec.(name) = obj(i).vector;
	else
		vec.(obj(i).name) = s_vcat(vec.(obj(i).name), obj(i).vector);
	end
end

len = numel(names);
for i = 1 : len
	if withHead
		vec.(names{i}) = s_vcat(at.(names{i}), vec.(names{i}));
	else
		try
			vec.(names{i}) = xmlel.tonumval(vec.(names{i}));
		end
	end
end

if filter
	try
		mat = vec.(filter);
	catch
		mat = [];
	end
else
	if len == 1
		try
			mat = vec.(obj(1).name);
		catch
			mat = [];
		end
	else
		mat = cell(len, 3);
		for i = 1 : len
			mat{i, 1} = names{i};
			mat{i, 2} = vec.(names{i});
			mat{i, 3} = at.(names{i});
		end
	end
end

end %F-main

% 将两个矩阵纵向连接，可能是数值矩阵与简单元胞矩阵混用
% 输出数值矩阵或元胞矩阵
function c = s_vcat(a, b)

if isnumeric(a) && isnumeric(b)
	c = [a; b];
elseif iscell(a) && iscell(b)
	c = [a; b];
else
	if isnumeric(a)
		a = xmlel.tostrval(a, true);
	end
	if isnumeric(b)
		b = xmlel.tostrval(b, true);
	end
	c = [a; b];
end

end %F- sub
