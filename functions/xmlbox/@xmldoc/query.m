% 解析 xpath
% 调用 obj.root 的 query 方法
function node = query(obj, subpath, atnames)

if nargin < 2
	fullpath = obj.xpath;
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
end

if nargin < 3
	atnames = {};
end

node = obj.root.query(fullpath, atnames);

end %F-main
