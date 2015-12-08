% cdchild(): 进入第一个子元素
% cdchild(index)：进入第 index 个子元素（暂不支持）
% cdchild(name)：进入名为 name 的第一个子元素
% cdchild(name, index)：进入 name 元素的第 index 个
function obj = cdchild(obj, varargin)

arglen = numel(varargin);
switch arglen
case 0
	self = obj.self;
	name = self(1).child(1).name;
	index = 1;
case 1
	name = vargin{1};
	index = 0;
case 2
	name = varargin{1};
	index = varargin{2};
otherwise
	error('Too many input argument to xmldoc.cdchild!');
end

if ~ischar(name) || size(name, 1) > 1
	error('child name expects a scalar string!');
end

node = obj.self.getChild(name, index);
if ~isempty(node)
	obj.self = node;
	if obj.xpath(end) ~= '/'
		subpath = ['/' name];
	end
	if index > 0
		subpath = sprintf('%s[%d]', index);
	end
	obj.xpath = [obj.xpath subpath];
else
	error('child(%s) not exists!', name);
end

end %F-main
