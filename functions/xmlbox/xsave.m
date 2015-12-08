% xsave: 将 matlab 变量保存为 xml 格式
% 可变输入输出，典型用法：
%  1. xsave(file, root, var, name, atname, ...)
%  2. xmlstr = xsave(root, var, name, atname, ...)
% 如果有接收返回参数，则转化为字符串变量，否则提供文件名将 xml 保存于文件中
% 调用函数 mat2xfrag 做主体工作
% 输入参数：
%   file: 待写入文件名，字符串，如果接收返回值，则不需该参数
%   root: xml 的根元素名
%   var: 待转化保存的变量
%   name: 变量名
%   atname: 属性名，或列名
%   可变参数每三个一组，var, name, atname
%
% see also: mat2xfrag.m
% lymslive / 2015-1

function varargout = xsave(varargin)

if nargout > 0 
	root = varargin{1};
	args = varargin(2:end);
else
	file = varargin{1};
	root = varargin{2};
	args = varargin(3:end);
	[fid message] = fopen(file, 'w');
	if ~isempty(message)
		error(message);
	end
end

xmlstr = '';
if isempty(root)
	root = 'Matlab';
end
head = sprintf('<%s>\n', root);
foot = sprintf('</%s>\n', root);
body = '';
leader = 1;

narg = length(args);
carg = 1;
while carg <= narg
	var = args{carg};
	if carg + 1 <= narg
		name = args{carg+1};
	else
		name = '';
	end
	if isempty(name)
		% give a default and different element name
		name = sprintf('var%d', ceil(carg/3));
	end
	if carg + 2 <= narg
		atname = args{carg+2};
	else
		atname = '';
	end

	cstr = mat2xfrag(leader, var, name, atname);
	body = [body cstr];
	carg = carg + 3;
end

xmlstr = [head body foot];
if nargout > 0
	varargout{1} = xmlstr;
else
	fprintf(fid, '<!-- gen by xsave -->\n%s', xmlstr);
	fclose(fid);
end

end %-of main
