% 统计对象数组有多少个元素
% 如果所有元素都是同名的，返回一个整数，表示有多少人这种元素，即数组长度
% 如果不都是相同元素，则返回一个 1*2 cell array
% cell{1} 是所有元素名，cellstr 类型
% cell{2} 是对应元素的个数，整数列向量
% 但是可选参数 output 可改变输出类型
% 1 或 'names' 返回 cell{1} 中的元素名
% 2 或 'number' 返回 cell{2} 中的个数
% 0 或 'default' 按上述规则返回一个整数标量或 1*2 cell
% 注意：
% 空元素的元素名用 'NONE'
% 文本元素的名称用 'TEXT'
% 假设正常 xml 文件一般不用这两个标鉴名
function result = count(obj, output)

if nargin < 2
	output = 0;
end
result = 0;

if ischar(output)
	switch output
	case 'names'
		output = 1;
	case 'number'
		output = 2;
	case 'default'
		output = 0;
	otherwise
		error('xmlel.count: invalid output type. (1=names 2=number 0=default');
	end
end

none = 'NONE';
text = 'TEXT';
names = {};
number = 0;
st = struct;

for i = 1 : numel(obj)
	name = obj(i).name;
	if isempty(name)
		name = none;
	elseif strcmp(name, '#Text')
		name = text;
	end
	if ~ismember(name, names)
		names{end+1} = name;
		st.(name) = 1;
	else
		st.(name) = st.(name) + 1;
	end
end

len = numel(names);
for i = 1 : len
	number(i) = st.(names{i});
end

if 0 == output
	if len > 1
		result = {names, number};
	else
		result = number;
	end
elseif 1 == output
	result = names;
elseif 2 == output
	result = number;
else
	error('xmlel.count: invalid output type. (1=names 2=number 0=default');
end

end %F-main
