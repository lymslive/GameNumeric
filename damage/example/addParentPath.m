% 获得当前脚本文件名，将父目录添加到 path 中
% 以便能用上层目录中的函数，测试父目录提供的工具
	
function parent = addParentPath()

	filename = mfilename('fullpath');
	[pathstr, name, ext] = fileparts(filename);
	parent = regexprep(pathstr, '\w+$', '');
	addpath(parent);

end %-of main
