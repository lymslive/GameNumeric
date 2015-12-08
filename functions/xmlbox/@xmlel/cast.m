% 将 matlab 变量转化为 xmlel 元素对象
% var：变量
% name: xmlel 元素名，标量字符串
% atname: 属性名，可选，用于可转为矩阵的列名，cellstr
function obj = cast(var, name, atname)

if nargin < 2
	name = [];
end
if nargin < 3
	atname = [];
end
if ischar(atname)
	atname = cellstr(atname);
end

[m n] = size(var);

if isnumeric(var)
	scvar = cell(m, n);
	for i = 1 : m
		for j = 1 : n
			scvar{i,j} = num2str(var(i,j));
		end
	end
	if isempty(name)
		obj = s_fromMatrix(scvar, 'double', atname);
	else
		obj = s_fromMatrix(scvar, name, atname);
	end

elseif iscell(var)
	scvar = cell(m, n);
	flag = false;

	FT = {'false', 'true'};
	for i = 1 : m
		if flag
			break;
		end
		for j = 1 : n
			value = var{i, j};
			if isnumeric(value) && isscalar(value)
				scvar{i,j} = num2str(value);
			elseif islogical(value) && isscalar(value)
				scvar{i,j} = FT(double(value) + 1);
			elseif ischar(value) && size(value, 1) == 1
				scvar{i, j} = value;
			else
				flag = true;
				break;
			end
		end
	end

	if isempty(name)
		name = 'cell';
	end

	if flag % 被打断，复杂cell
		obj = s_fromCell(var, name);
	else    % 未被打断，简单cell矩阵
		obj = s_fromMatrix(scvar, name, atname);
	end

elseif isstruct(var)
	obj = s_fromStruct(var, name);

elseif ischar(var)
	obj = s_fromChar(var, name);

elseif islogical(var)
	obj = s_fromLogical(var, name, atname)

else
	try
		obj = var.xmlel();
	catch
		obj = [];
		error('can not cast variable to xmlel object!');
	end
end

end %F-main

%% --- sub function ---%%

% 简单矩阵，转化为元素列向量
% 每行一个元素，每列一个属性，默认列名 ABC...Z
% var 是 cell matrix，每个 cell 内容为标量字符串
% 其他矩阵都转为该种格式
function obj = s_fromMatrix(var, name, atname)

if nargin < 2 || isempty(name)
	name = 'row';
end

[m n] = size(var);
AZ = ['A' : 'Z'];

for i = 1 : m
	obj(i, 1) = xmlel();
	obj(i).name = name;
	at = struct;

	for j = 1 : n
		try
			field = atname{i};
		catch
			field = [];
		end
		if isempty(field)
			if j < 27
				field = AZ(j);
			else
				field = ['c' num2str(j)];
			end
		end
		at.(field) = var{i,j};
	end

	obj(i).at = at;
end

end %F

function obj = s_fromLogical(var, name, atname)

[m n] = size(var);
scvar = cell(m, n);

for i = 1 : m
	for j = 1 : n
		if var(i,j)
			scvar{i,j} = 'true';
		else
			scvar{i,j} = 'false';
		end
	end
end

if nargin < 2 || isempty(name)
	name = 'logical';
end

obj = s_fromMatrix(scvar, name, atname);

end %F

% 长字符串转为文本元素，短字符保存于属性值内
function obj = s_fromChar(var, name)

if nargin < 2 || isempty(name)
	name = 'char';
end

if size(var, 2) < xmlel.MaxCharAt
	scvar = cellstr(var);
	obj = s_fromMatrix(scvar, name);
else
	for i = 1 : size(var, 1)
		obj(i, 1) = xmlel(name);
		str = var(i, :);
		text = xmlel.createTextNode(str);
		obj(i, 1).pushChild(text);
	end
end

end %F

% 转化 cell array
% 每个 cell 转化为 一个 <cell> ... </cell>
function obj = s_fromCell(var, name)

if nargin < 2 || isempty(name)
	name = 'cell';
end

for i = 1 : numel(var)
	obj(i, 1) = xmlel(name);
	subxml = xmlel.cast(var{i});
	% obj(i).child = subxml;
	% obj(i).parentas(subxml);
	obj(i).pushChild(subxml);
end

end %F

% 转化 struct 变量（数组）
% 每个 struct 转为一个 <strct> ... </struct>
% struct 的域名转为子元素
function obj = s_fromStruct(var, name)

if nargin < 2 || isempty(name)
	name = 'struct';
end

field = fieldnames(var);
for i = 1 : numel(var)
	obj(i, 1) = xmlel(name);
	for j = 1 : length(field)
		atname = field{j};
		subxml = xmlel.cast(var.(atname), atname);
		obj(i).pushChild(subxml);
	end
end

end %F
