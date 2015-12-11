% openar: open area project
% 打开当前目录下可能存在的项目文件的脚本
%
% 运行在当前工作区中的脚本:
% 1. 寻找当前目录中的 _ar.mat 项目文件，然后打开之
% 2. 如果有多个 _ar.mat 文件，只打开第一个
% 3. 如果当前目录没有，则试图打开最近曾打开过的项目
% 
% 打开项目所做的工作有：
% 0. 检查是否已有 Area_ 已被打开，须手动 closear 才能打开新的 area
%    工作区原有变量会被 clear all
% 1. 将 .subpath 子目录添加至搜索路径，方便调用放在各子目录中的 m 函数。
%    .subpath 是 cellstr 类型，可手动添加新子目录
% 2. 恢复 .workspace 中保存的变量，加载进当前工作区。
%    .workspace 保存的是 _wsp.mat 文件路径名
% 3. 将当前项目路径添加到最近打开项目列表 areas_ls.mat
% 4. 如果当前目录没有项目文件，则尝试打开最近的历史项目
%
% maintain: lymslive / 2015-11 
%

if 1 == exist('Area_', 'var')
    disp('A project is open already!')
    disp('check and close the current project using `closear` first!')

else

    a_list = dir('*_ar.mat');
    if length(a_list) > 0

        % 打开当前目录下的项目
        clear all;

        a_list = dir('*_ar.mat');
        a_prjname = a_list(1).name;
        Area_ = openar_fun(a_prjname);
        load(Area_.workspace);

        disp(['Area is opend: ', Area_.name]);
        hisarea(Area_.base, Area_.project);
        clear -regexp ^a_;

    else

        % 寻找历史项目记录
        disp('No any *_ar.mat project file found in pwd!');
        disp('Try project file in history list');

        [a_dir, a_file] = areas(1);

        if 2 == exist([a_dir, filesep, a_file], 'file')
            clear all;
            [a_dir, a_file] = areas(1);
            cd(a_dir);
            Area_ = openar_fun(a_file);
            load(Area_.workspace);
            disp(['Area is opend: ', Area_.name]);
            clear -regexp ^a_;
        else
            disp('Open area fails!');
        end

    end

    % 换用 Area 类管理
    if exist('Area_', 'var') == 1 && exist('Area', 'class')
        Area_ = Area(Area_);
    end

end
