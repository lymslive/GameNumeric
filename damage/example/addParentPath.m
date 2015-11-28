% 获得当前脚本文件名，将父目录添加到 path 中
% 以便能用上层目录中的函数，测试父目录提供的工具
% 返回父目录，用 .. 表示的父目录
	
function parent = addParentPath()

	parent = [pwd, filesep, '..'];
	addpath(parent);

end %-of main
