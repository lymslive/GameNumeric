% 删除子元素
% tag 是元素名，表示要删除的元素，标量字符串
% 默认删除所有子元素
% 返回被移出子元素的对象（数组）
function old = deleteChild(obj, tag)

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
	old = obj.child;
	obj.child = [];
	return;
end

if ~ischar(tag) || size(tag, 1) > 1
	error('xmlel.deleteChild() expects a scalar string as tag name!');
end

pos = [];
for i = 1 : len
	if strcmp(tag, obj(i).name)
		pos = [pos; i];
	end
end

old = obj.child(pos);
obj.child(pos) = [];

end %F-main
