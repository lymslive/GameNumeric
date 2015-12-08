% 将 xmlel 转化为 cell （数组）
% 假设能忽略当前层的属性值，将其子元素转化为 matlab 变量保存在 cell 中
function sc = cell(obj)

len = numel(obj);
for i = 1 : len
	if isempty(obj(i).child)
		sc{i} = [];
	else
		sc{i} = obj(i).child.tomat();
	end
end

end %F-main
