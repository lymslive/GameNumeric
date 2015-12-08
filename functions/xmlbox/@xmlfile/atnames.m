% 取出元素的属性名列表，返回 cellstr
% 如果有多个同名元素，按第一个元素的属性提取
%
% 参考 atval 提取属性值
function names = atnames(obj, xpath)
	
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

	if numel(st) > 1
		st = st(1);
	end

	names = fieldnames(st.AT);

end
