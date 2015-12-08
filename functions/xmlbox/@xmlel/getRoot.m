% 上溯查找根元素
% 如果是对象数组，也查找第一个对象的根元素
% 找不到则返回空
function r = getRoot(obj)

r = obj(1);
while isa(r, 'xmlel') && ~r.isroot()
	r = r.parent;
end

if ~isa(r, 'xmlel')
	r = [];
end

end
