% 判断是否一个空对象，所有域为初始化值 []
function tf = isEmptyNode(obj)

tf = true;
for i = 1 : numel(obj)
	iobj = obj(i);
	if isempty(iobj.name)
		tf(i, 1) = true;
	else
		tf(i, 1) = false;
	end
end

end %F-main
