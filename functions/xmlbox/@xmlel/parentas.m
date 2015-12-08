% parentas: 将自己作为另一组对象的父元素
% obj 自己必须是标量
% child 也必须是 xmlel 对象，将其父指针链接到自己
% 返回成功设定父指针的个数，一般即是 child 参数的个数
% 如果省略 child 参数，则修复或重构自己子元素的父指针属性
% 且递归重建所有子孙元素的父指针
function number = parentas(obj, child)

number = 0;

if ~isscalar(obj)
	error('xmlel.parentas(child) expects a sacalar element!');
elseif obj.isTextNode()
	error('A TextNode element cannot contain children!');
end

if nargin < 2
	if isempty(obj.child)
		return;
	else
		child = obj.child;
		for i = 1 : numel(child)
			thisNumber = child(i).parentas();
			number = number + thisNumber;
		end
	end
end

if ~isa(child, 'xmlel')
	error('xmlel.parentas(child) expects xmlel objects as children!');
end

len = numel(child);
for i = 1 : len
	child(i).parent = obj;
end

number = number + len;

end
