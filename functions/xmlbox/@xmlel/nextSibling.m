% nextSibling: 取得下一个兄弟元素
% 若无，则返回空 []
% 自已须是标量对象才能调用
function next = nextSibling(obj)

if numel(obj) > 1
	error('This method can be called by scalar object!');
end

idx = obj.indexChild;
if idx == 0
	next = [];
else
	chlist = obj.parent.child;
	if idx >= numel(chlist)
		next = [];
	else
		next = chlist(idx + 1);
	end
end

end %F-main
