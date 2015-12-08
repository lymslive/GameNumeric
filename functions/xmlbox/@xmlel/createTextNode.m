% 创建一个文本元素
function obj = createTextNode(str)
obj = xmlel('#Text');
obj.child = str;
end %F
