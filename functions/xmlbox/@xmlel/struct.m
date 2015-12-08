% 将 xmlel 转化为 struct （数组）
% 假设能忽略当前层的属性值，将子元素转化为 struct 域
function st = struct(obj)

len = numel(obj);
for i = 1 : len
	if isempty(obj(i).child)
		st(i) = [];
	else
		subname = obj(i).child.count('names');
		for j = 1 : numel(subname)
			subelem = obj(i).child.getElement(subname{j});
			st(i).(subname{j}) = subelem.tomat();
		end
	end
end

end %F-main
