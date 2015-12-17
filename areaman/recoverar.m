% recoverar: recover area project
% 恢复项目文件，在 Area_ 特殊变量被清除时重新加载
% 参考 openar，仅加载项目文件 .mat，不作其他处理
%
% maintain: lymslive / 2015-12 
%

if 1 == exist('Area_', 'var')
    disp('The project is open already!')

else

    a_list = dir('*_ar.mat');
    if length(a_list) > 0

        % 在当前项目目录
        a_prjname = a_list(1).name;
        Area_ = load(a_prjname);

        disp(['Area is recovered: ', Area_.name]);
        clear -regexp ^a_;

    else

        % 寻找历史项目记录

        [a_dir, a_file] = areas(1);

        if 2 == exist([a_dir, filesep, a_file], 'file')
            Area_ = load([a_dir, filesep, a_file]);
            disp(['Area is recovered: ', Area_.name]);
            clear -regexp ^a_;
        else
            disp('Recover area fails!');
        end

    end

    % 换用 Area 类管理
    if exist('Area_', 'var') == 1 && exist('Area', 'class')
        Area_ = Area(Area_);
    end

end
