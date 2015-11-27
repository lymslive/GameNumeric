% savear: save area project
% 保存项目脚本
%
% 1. 保存工作区
% 2. 保存项目信息文件
%
% maintain: lymslive / 2015-11

if 1 == exist('Area_')

	a_workspace = [Area_.base, filesep, Area_.workspace];
	save(a_workspace, '-regexp', Area_.filter);
	a_project = [Area_.base, filesep, Area_.project];
	save(a_project, '-struct', 'Area_');

	clear -regexp ^a_;
else
	disp('No area seems opened');
end
