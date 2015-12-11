% savear: save area project
% 保存项目脚本
%
% 1. 保存工作区
% 2. 保存项目信息文件
%
% maintain: lymslive / 2015-11

if 1 == exist('Area_')

    a_workspace = [Area_.base, filesep, Area_.workspace];
    try
        save(a_workspace, '-regexp', Area_.filter);
        disp(['save workspace to:', a_workspace]);
    catch
        disp('No variables in  workspace need to save');
    end

    if strcmp(class(Area_), 'Area')
        Area_.save();
    else
        a_project = [Area_.base, filesep, Area_.project];
        save(a_project, '-struct', 'Area_');
    end

    clear -regexp ^a_;
else
    disp('No area seems opened');
end
