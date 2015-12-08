% parentto: 将自己的父元素指针指向其他一个元素对象
% parent 输入参数必须是标量 xmlel 对象
% 省略的话，将父元素指针指向 false，即 NoneRoot 常量
function number = parentto(obj, parent)

number = 0;

if nargin < 2
	parent = xmlel.NoneRoot;
elseif islogical(parent)
	pass = true;
elseif isa(parent, 'xmlel')
	if ~iscalar(parent)
		error('xmlel.parentto(parent) expects a scalar parent!');
	elseif parent.isTextNode()
		error('A TextNode element cannot contain children!');
	end
else
	error('xmlel.parentto(parent) expects also a xmlel parent!');
end

len = numel(obj);
for i = 1 : len
	obj(i).parent = parent;
end

number = len;

end %F-main
