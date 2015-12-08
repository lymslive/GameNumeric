% value: 属性子结点的值
% 只取第一组元素的属性值矩阵
% 默认输出 cellstr 矩阵
% output='double' 则试图转化为数值矩阵
function matrix = value(obj, output)

first = obj(1);
if first.isTextNode() || first.isEmptyNode() || isempty(first.at)
	matrix = [];
	return;
end

% node = obj.getElement(first.name);
cmatrix = obj(1).vector;
for i = 2 : numel(obj)
	if ~strcmp(obj(i).name, first.name)
		break;
	end
	cmatrix = [cmatrix; obj(i).vector];
end

if nargin < 2
	matrix = cmatrix;
else
	if strcmp(output, 'double')
		matrix = xmlel.tonumval(cmatrix);
	else
		matrix = cmatrix;
	end
end

end %F
