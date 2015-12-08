% 复制对象副本
function newobj = copy(obj)
newobj = xmldoc(obj.root);
newobj.file = obj.file;
newobj.xpath = obj.xpath;
newobj.self = obj.self;
end
