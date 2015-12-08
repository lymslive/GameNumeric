% 退回到父元素，cd ..
% 移除最后一 / 之后的路径字符串
function obj = cdparent(obj)

sep = strfind(obj.xpath, '/');
if numel(sep) <= 1
	return;
end
obj.xpath(sep(end):end) = [];
obj.self = obj.root.query(obj.xpath);

end
