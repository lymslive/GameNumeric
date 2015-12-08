% 格式化 xml ，转化为字符串
% deep，缩进层次，默认 0
% lead，缩进字符串，默认制表符 9
function str = char(obj, deep, lead)

if nargin < 3
	lead = 9;
end
if nargin < 2
	deep = 0;
end

newline = 10;
leading = repmat(lead, 1, deep);

str = '';
m = numel(obj);
if m > 1
	for i = 1 : m
		onestr = obj(i).char(deep, lead);
		str = [str onestr];
	end
	return;
end

% 文本元素
if obj.isTextNode()
	str = [leading obj.getText() newline];
	return;
end

% 属性字符串
atstr = '';
if ~isempty(obj.at)
	names = fieldnames(obj.at);
	for i = 1 : length(names)
		name = names{i};
		value = obj.at.(name);
		atstr = sprintf('%s %s="%s"', atstr, name, value);
	end
end

% 开标签
head = [leading '<' obj.name atstr];

% 自封闭元素
if isempty(obj.child)
	str = [head '/>' newline];
	return;
end

head = [head '>'];

% 唯一文本元素
if numel(obj.child) == 1 && obj.child.isTextNode()
	text = obj.child.getText();
	str = sprintf('%s%s</%s>\n', head, text, obj.name); 
	return;
end

% 其他情况，有子元素
deep = deep + 1;
for i = 1 : numel(obj.child)
	substr = obj.child(i).char(deep, lead);
	str = [str substr];
end

foot = [leading '</' obj.name '>'];
str = [head newline str foot newline];

end %F
