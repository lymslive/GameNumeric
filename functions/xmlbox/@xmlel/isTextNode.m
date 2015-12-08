% 判断一个元素是否文本结点
function tf = isTextNode(obj)

for i = 1 : numel(obj)
	if strcmp(obj(i).name, '#Text')
		tf(i) = true;
	else
		tf(i) = false;
	end
end

end %F
