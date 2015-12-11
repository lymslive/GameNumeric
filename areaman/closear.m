% closear: close area project
% 关闭当前项目的脚本
%
% 约定通过 openar 打开的项目，在当前工作区添加一个 Area_ 变量，
% closear 则根据 Area_ 作清理工作:
% 1. 调用 colsear_fun 恢复搜索路径
% 2. 调用 savear 自动保存工作区与项目文件
% 3. 清查当前工作区
%
% 不需要在当前项目的基目录下就可执行关闭项目命令
%
% maintain: lymslive / 2015-11
%

if 1 == exist('Area_', 'var')
    closear_fun(Area_);
    savear;
    clear all;
else
    disp('No area seems opened');
end
