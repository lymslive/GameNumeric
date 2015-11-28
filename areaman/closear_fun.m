% closear_fun: close area function 
% 关闭项目的函数，一般由 closear 脚本调用
% 
% 主要工作：
% 移除添加的 .subpath, 恢复 Matlab 路径
%
% maintain: lymslive / 2015-11
function closear(prj)

if isfield(prj, 'subpath') && iscellstr(prj.subpath)
	for i = 1 : length(prj.subpath)
		sub = prj.subpath{i};
		fullpath = [prj.base, filesep, sub];
		warning('off','MATLAB:rmpath:DirNotFound');
		rmpath(fullpath);
		warning('on','MATLAB:rmpath:DirNotFound');
	end
end

end %-of main
