% 根据属性筛选对象
% obj.filterat(index)
% obj.filterat(atname, [val, relation])
% obj.filterat(condition expr)
% atname, 属性名，如果只提供这个参数，则选出含有该属性的元素
% val, 属性值，标量
% relation, 关系判断，可选值: == = < > <= >=，默认相等判断
% 注：
%   如果只有唯一参数，可写成表达式 @name=val
%   唯一参数也可以是数字索引
function node = filterat(obj, atname, val, relation)

if nargin < 2
	node = obj;
	return;
end

if nargin < 4
	relation = '==';
end
if nargin < 3
	val = '';
end

if nargin == 1 && atname(1) = '@'
	str = atname(2:end);
	tok = regexp(str, '(\S+)\s*([<=>]*)\s*(\S*)', 'once');
	if ~isempty(tok)
		atname = tok{1};
		relation = tok{2};
		val = tok{3};
	end
end

if isnumeric(atname)
	index = atname;
	node = obj(index);
	return;
end

if strcmp(relation, '=')
	relation = '==';
end

if ~isscalarval(val)
	error('expects a salar number or string!');
end

node = xmlel.empty();
for i = 1 : numel(obj)
	ie = obj(i);
	at = ie.at;
	field = fieldnames(at);
	if ~isfield(at, atname)
		continue;
	end

	if nargin < 3 || isempty(val)
		node = [node; ie];
	elseif s_check(at.(atname), val, relation)
		node = [node; ie];
	end
end

end %F-main

function tf = s_check(atval, val, relation)

if isempty(relation)
	relatione = '==';
end

tf = true;
if isnumeric(val)
	dval = str2double(atval);
	if isnan(dval)
		tf = false;
		return;
	end

	switch relation
	case '=='
		if atval == val
			tf = true;
		else
			tf = false;
		end
	case '<'
		if atval < val
			tf = true;
		else
			tf = false;
		end
	case '>'
		if atval > val
			tf = true;
		else
			tf = false;
		end
	case '>='
		if atval >= val
			tf = true;
		else
			tf = false;
		end
	case '<='
		if atval <= val
			tf = true;
		else
			tf = false;
		end
	otherwise
		tf = false;
	end

elseif ischar(val)
	switch relation
	case '=='
		if strcmp(atval, val)
			tf = true;
		else
			tf = false;
		end
	otherwise
		tf = false;
	end
else
	tf = false;
end

end %subF
