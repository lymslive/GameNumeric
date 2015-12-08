% 删除子元素
% pos 是索引位置，可多索引，整数（数组）
% 默认删除最后一个子元素
% 返回被移出子元素的对象（数组）
function old = popChild(obj, pos)

if numel(obj) > 1
	error('This method can be called by scalar object!');
end

if obj.isTextNode()
	error('Text element node can not have child !');
end

len = numel(obj.child);
if len == 0
	old = [];
	return;
end

if nargin < 2
	pos = len;
end

old = obj.child(pos);
obj.child(pos) = [];

end %F-main
