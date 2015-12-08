% indexChild: 确定自己在父元素的子元素列表中的位置
% 返回一个整数索引，或 0
% 只由标量对象调用
function idx = indexChild(obj)

idx = 0;

if numel(obj) > 1
	error('This method can be called by scalar object!');
end

if ~isa(obj.parent, 'xmlel')
	return;
end

chlist = obj.parent.child;
if ~isa(chlist, 'xmlel')
	return;
end

for i = 1 : numel(chlist)
	if chlist(i) == obj
		idx = i;
		return;
	end
end

end %F-main
