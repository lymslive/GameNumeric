% openar_: open area project
% ����Ŀ�ļ�
%
% һ���� openar �ű����á�
% �������Ϊ _ar.mat ��Ŀ�ļ�����
% �������Ϊ��ʾ�����Ŀ�Ľṹ�� struct
%
% maintain: lymslive / 2015-11 
%
function area = openar_fun(prjfile)

prj = load(prjfile);

% ������Ŀ·��
if ~strcmp(prj.base, pwd)
	cd(prj.base);
end

% ����Ŀ�� .subpath ����Ŀ¼����� Matlab ����·�� path
if isfield(prj.subpath) && iscellstr(prj.subpath)
	for i = 1 : length(prj.subpath)
		sub = prj.subpath{i};
		fullpath = [prj.base, filesep, sub];
		addpath(fullpath);
	end
end

area = prj;

end %-of main
