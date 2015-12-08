% 增加子元素结点
% 只能由一个标量元素对象调用，但可插入多个子元素，即对象数组
function obj = pushChild(obj, subxml, pos)

if numel(obj) > 1
	error('xmlel.pushChild can be called by scalar object!');
end

if obj.isTextNode()
	error('Text element node can not have child !');
end

if ~isa(subxml, 'xmlel')
	error('xmlel.pushChild expects xmlel objects as inputs!');
end

obj.parentas(subxml);
add = numel(subxml);

len = numel(obj.child);
if len == 0
	obj.child = subxml;
	return;
end


if nargin < 3
	pos = len;
end

if pos >= len
	% pos = len;
	newchild = [obj.child; subxml];
elseif pos <= 0
	% pos = 0;
	newchild = [subxml; obj.child];
else
	newchild = [obj.child(1:pos); subxml; obj.child(pos+1:end)];
end

obj.child = newchild;

end
