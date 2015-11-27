% openar_: open area project
% 打开项目文件
%
% 一般由 openar 脚本调用。
% 输入参数为 _ar.mat 项目文件名；
% 输出参数为表示这个项目的结构体 struct
%
% maintain: lymslive / 2015-11 
%
function area = openar_fun(prjfile)

prj = load(prjfile);

% 进入项目路径
if ~strcmp(prj.base, pwd)
	cd(prj.base);
end

% 将项目的 .subpath 各子目录添加至 Matlab 搜索路径 path
if isfield(prj.subpath) && iscellstr(prj.subpath)
	for i = 1 : length(prj.subpath)
		sub = prj.subpath{i};
		fullpath = [prj.base, filesep, sub];
		addpath(fullpath);
	end
end

area = prj;

end %-of main
