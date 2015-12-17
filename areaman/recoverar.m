% recoverar: recover area project
% �ָ���Ŀ�ļ����� Area_ ������������ʱ���¼���
% �ο� openar����������Ŀ�ļ� .mat��������������
%
% maintain: lymslive / 2015-12 
%

if 1 == exist('Area_', 'var')
    disp('The project is open already!')

else

    a_list = dir('*_ar.mat');
    if length(a_list) > 0

        % �ڵ�ǰ��ĿĿ¼
        a_prjname = a_list(1).name;
        Area_ = load(a_prjname);

        disp(['Area is recovered: ', Area_.name]);
        clear -regexp ^a_;

    else

        % Ѱ����ʷ��Ŀ��¼

        [a_dir, a_file] = areas(1);

        if 2 == exist([a_dir, filesep, a_file], 'file')
            Area_ = load([a_dir, filesep, a_file]);
            disp(['Area is recovered: ', Area_.name]);
            clear -regexp ^a_;
        else
            disp('Recover area fails!');
        end

    end

    % ���� Area �����
    if exist('Area_', 'var') == 1 && exist('Area', 'class')
        Area_ = Area(Area_);
    end

end
