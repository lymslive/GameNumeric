% sxmlval, 提取已经转为 matlab-struct 的 xml 数据的有效值
% 基于 xml2struct 与 struct2xml 函数工具
% 主要用于将存储于元素属性中的值取出，或定位设新值，类似 qxml 做法
%
% 输入参数：
%   st, 表示xml的结构struct，须包含路径，如var.root.element.subele.subsub
%       是一个变量名，除叶结点外，中间路径须是单元素
%       只支持最后一层有多个元素
%   attr, 表示元素的属性（组），字符串或字串元胞
%   newval, 要修改的新值，矩阵或元胞矩阵
% 输出参数：
%   val, 提取的值或原值，返回数值矩阵或字串元胞矩阵
%
% 算法说明：
%   st变量表示xml的元素，每个元素一行，元素的每个属性表示一列
%   xml2struct 的规则，元素要么不一个struct，要么一列cell，每个放一个struct
%   要提取的主要数据放在 <element>.Attributes 结构中
%   qxml 基于 xpath，每次取一列数据，本函数便于取矩阵
%   输入元胞矩阵的内容只允许数字或单字符串
%
% 潜在问题：
%   属性未指定时，取第一个元素的所有属性
%   struct 按值传递，不能达到修改的目的，除非改用句柄对象
%
% see also: xml2struct, struct2xml, qxml
% lymsive/2015-01
%

function val = sxmlval(st, attr, newval)

% set flag
setit = 1;
if nargin < 3 
	newval = [];
	setit = 0;
else
	newval = s_wrapCell(newval);
end

if nargin > 1 && ~isempty(attr)
	if ischar(attr)
		attr = cellstr(attr);
	end
	if ~iscellstr(attr)
		error('Attribute name as string required!');
	end
else
	attr = [];
	if isstruct(st)
		attr = fieldnames(st.Attributes);
	elseif iscell(st) && isstruct(st{1})
		attr = fieldnames(st{1}.Attributes);
	else
		error('A struct or struct cell required!');
	end
end

m = numel(st);
n = numel(attr);
val = cell(m, n);

for i = 1 : m
	% current struct element
	if isstruct(st)
		this = st(i);
	elseif iscell(st)
		this = st{i};
	end
	if ~isstruct(this)
		error('Cannot get a struct!');
	end

	for j = 1 : n
		name = attr{j};
		if isfield(this.Attributes, name)
			val{i, j} = this.Attributes.(name);
		else
			val{i,j} = [];
			warning('Unknow attribute field ignored!');
		end
		
		if setit == 1
			if isstruct(st)
				st(i).Attributes.(name) = newval{i,j};
			else
				st{i}.Attributes.(name) = newval{i,j};
			end
		end
	end
end

% try to simplefy the cell matrix
val = s_stripCell(val);

end %-of main


%% -------------------------------------------------- %%
% copy from qxml.m

% 剥除一层 cell
% 输入：c, a cell array or matrix
% 输出：d, possible double matrix, or single string, else return c itself
function d = s_stripCell(c)

if numel(c) == 1 && ischar(c{1})
	d = c{1};
	return;
end

%Try to convert everything to numeric
onlyNumeric = str2double(c);

if any(isnan(onlyNumeric))
	%all were not numeric, so return txtdata after injecting the actual numbers into it
	d = c;
	for i = 1:numel(onlyNumeric)
		if ~isnan(onlyNumeric(i))
			d{i} = onlyNumeric(i);
		end
	end
else
	d = onlyNumeric;
end

end %-of s_stripCell

% performs different from qxml.m
% 转换为简单 cell，内容要求数字或字符串

function c = s_wrapCell(d)

if iscellstr(d)
	c = d;
	return
end

if ischar(d)
	c = cellstr(d);
	return;
end

[m, n] = size(d);

if isnumeric(d)
	c = cell(m, n);
	for i = 1 : m
		for j = 1 : n
			c{i, j} = d(i, j);
		end
	end
	return;
end

if iscell(d)
	c = d;

	for i = 1 : m
		for j = 1 : n
			if ~ischar(d{i,j}) && ~isnumeric(d{i,j})
				error('Simple cell content required!');
			end
		end
	end

	return;
end

c = [];
disp('Warning: can not warp input as cell-string');

end %-of s_wrapCell
