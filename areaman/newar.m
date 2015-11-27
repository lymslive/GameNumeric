% newpar: new area
% 创建新项目脚本
% 
% 在当前目录新建一个 area，调用 newar_fun() 完成大部分工作
% 然后打开该项目
%
% 新建项目会在当前目录下生成两个文件
% *_ar.mat, *_ws.mat, * 前缀就是当前目录名
%
% 打开项目，会在当前工作区增加一个 Area_ 变量
%
% 如果当前目录已经有 *_ar.mat ，则不会新建项目
%
% maintain: lymslive / 2015-11

if length(dir('*_ar.mat')) > 0
	disp('Area already exists, use `openar` to open it');
else
	newar_fun();
	openar;
end
