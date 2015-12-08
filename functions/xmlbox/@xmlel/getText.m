% 获取文本结点的文本
% 对象数组时，拼接所有文本元素的文本字符
function str = getText(obj)

str = '';
for i = 1 : numel(obj)
	if obj(i).isTextNode
		str = [str obj(i).child];
	end
end

end
