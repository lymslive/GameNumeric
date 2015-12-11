% openar: open area project
% �򿪵�ǰĿ¼�¿��ܴ��ڵ���Ŀ�ļ��Ľű�
%
% �����ڵ�ǰ�������еĽű�:
% 1. Ѱ�ҵ�ǰĿ¼�е� _ar.mat ��Ŀ�ļ���Ȼ���֮
% 2. ����ж�� _ar.mat �ļ���ֻ�򿪵�һ��
% 3. �����ǰĿ¼û�У�����ͼ��������򿪹�����Ŀ
% 
% ����Ŀ�����Ĺ����У�
% 0. ����Ƿ����� Area_ �ѱ��򿪣����ֶ� closear ���ܴ��µ� area
%    ������ԭ�б����ᱻ clear all
% 1. �� .subpath ��Ŀ¼���������·����������÷��ڸ���Ŀ¼�е� m ������
%    .subpath �� cellstr ���ͣ����ֶ��������Ŀ¼
% 2. �ָ� .workspace �б���ı��������ؽ���ǰ��������
%    .workspace ������� _wsp.mat �ļ�·����
% 3. ����ǰ��Ŀ·����ӵ��������Ŀ�б� areas_ls.mat
% 4. �����ǰĿ¼û����Ŀ�ļ������Դ��������ʷ��Ŀ
%
% maintain: lymslive / 2015-11 
%

if 1 == exist('Area_', 'var')
    disp('A project is open already!')
    disp('check and close the current project using `closear` first!')

else

    a_list = dir('*_ar.mat');
    if length(a_list) > 0

        % �򿪵�ǰĿ¼�µ���Ŀ
        clear all;

        a_list = dir('*_ar.mat');
        a_prjname = a_list(1).name;
        Area_ = openar_fun(a_prjname);
        load(Area_.workspace);

        disp(['Area is opend: ', Area_.name]);
        hisarea(Area_.base, Area_.project);
        clear -regexp ^a_;

    else

        % Ѱ����ʷ��Ŀ��¼
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

    % ���� Area �����
    if exist('Area_', 'var') == 1 && exist('Area', 'class')
        Area_ = Area(Area_);
    end

end
