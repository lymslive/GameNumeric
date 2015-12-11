% newpar_fun: new area function
% ��������Ŀ
%
% Input:
%   @name: ��Ŀ���ƣ��ַ������ͣ����� name Ϊ�����ڵ�ǰĿ¼�´�����Ŀ¼��
%    ���� name ���ǺϷ���Ŀ¼������ matlab ��������
%    ʡ��ʱ������ͼ�ڵ�ǰĿ¼�´�����Ŀ���Ե�ǰĿ¼����Ϊ��Ŀ���ơ�
%
% output:
%   @area: ���˳����������һ����ʾ��Ŀ�Ķ��󣨽ṹ�壩
%    ������ĿĿ¼�±���һ����Ŀ��Ϣ�ļ� ${name}_ar.mat��
%    �������������ļ� ${name}_ws.mat
%
% struct: ��Ŀ�ļ����� area ��������Ϣ
%   .base: Ŀ¼��·��
%   .name: ��Ŀ����
%   .project: ������Ŀ���ļ��� *_ar.mat
%   .subpath: ��Ҫ���뵽 Matlab ����·������Ŀ��Ŀ¼��cellstr
%   .workspace: ������Ŀ���������ļ����� *_ws.mat
%   .filter: ��Ҫ����Ĺ������ı�������������ʽ����
%            Ĭ���� 4 ����ĸ���ϴ���ĸ����
%
% maintain: lymslive / 2015-11

function area = newar_fun(name)

prj = struct;

if nargin >= 1

    if ~isdir(name)
        [status, message] = mkdir(name);
        if ~status
            error(message);
        end
    end

    cd(name);
    prj.base = pwd;
    prj.name = name;

else
    prj.base = pwd;
    [pathstr, name, ext] = fileparts(prj.base);
    prj.name = name;
end

prj.project = [name, '_ar.mat'];

% ��ǰ·��Ҳ����·������ Matlab ������Ŀ¼ʱ�Կ���
prj.subpath = {};
prj.subpath{1} = '.';

% �����Ŀ¼�� .m �� .mat ������ӵ� .subpath
% ֻ����ֱ����Ŀ¼�����ݹ�
sublist = dir();
for i = 1 : length(sublist)
    sub = sublist(i);
    if sub.isdir && ~strcmp(sub.name, '.') && ~strcmp(sub.name, '..')
        if length( dir([sub.name, filesep, '*.m']) ) > 0 ... 
            || length( dir([sub.name, filesep, '*.mat']) ) > 0 
            prj.subpath{end+1} = sub.name;
        end
    end
end

prj.workspace = [name, '_ws.mat'];
prj.filter = '^[a-zA-Z]{4,}$';

% ������Ŀ��Ϣ�ļ� 
save(prj.project, '-struct', 'prj');
disp(['Create and saved: ', prj.project]);

% ���湤���������ļ�������Ŀ��ʼֻ��ʾ�� ans ����
ans = ['New area: ' name];
save(prj.workspace, 'ans');
disp(['Create and saved: ', prj.workspace]);

area = prj;

end %-of main
