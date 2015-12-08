% 进入根元素内，/rootName
function obj = cdroot(obj)

if ~isempty(obj.root)
	obj.xpath = ['/' obj.root.name];
else
	obj.xpath = '';
end

obj.self = obj.root;

end %F-main
