% 解析 xpath
% 调用 obj.root 的 queryset 方法
% subpath 与 atnames 都可省略，默认用对象保存的 obj.xpath
function obj = queryset(obj, subpath, atnames, val)

if nargin < 2
	error('Too less input to xmldoc.queryset!');
end

if nargin < 3
	fullpath = obj.xpath;
	val = subpath;
	obj.root.queryset(fullpath, val); 
	return;
else
	if subpath(1) == '/'
		fullpath = subpath;
	else
		if obj.xpath(end) == '/'
			fullpath = [obj.xpath subpath];
		else
			fullpath = [obj.xpath '/' subpath];
		end
	end

	if nargin == 3
		obj.root.queryset(fullpath, atnames); 
	elseif nargin == 4
		obj.root.queryset(fullpath, atnames, val); 
	else
		error('Too many input to xmldoc.queryset!');
	end
end

end %F-main

