% 取出元素的属性值，返回矩阵
% 每个元素是矩阵的一行，每个属性是一列
% 尽量返回数值矩阵，否则元胞矩阵
% 输入参数：
%   xpath, /分隔的元素路径，或.分隔。或直接用 obj.sroot.element.sub... 结构
%   colseq, 可选，定制输出列名顺序，cellstr
% 参考 struct2matrix 自写基础工具
function matrix = atval(obj, xpath, colseq)
	
	if nargin < 2
		error('xmlfile.atvel require a path as input, string or struct!');
	end

	if ischar(xpath)
		xpath = regexprep(xpath, '^/*', '');
		xpath = regexprep(xpath, '/', '.');
		st = eval(['obj.sroot.' xpath]);
	elseif isstruct(xpath)
		st = xpath;
	else
		error('argument type error! a string path or struct required!');
	end

	m = numel(st);

	for i = 1 : m
		if ~isfield(st(i), 'AT')
			error('Struct have no AT value!');
		end
		if i == 1
			newst = st(i).AT;
		else
			newst(i) = st(i).AT;
		end
	end

	if isempty(newst)
		matrix = [];
		return;
	end

	if nargin >= 3
		matrix = struct2matrix(newst, colseq);
	else
		matrix = struct2matrix(newst);
	end
end
