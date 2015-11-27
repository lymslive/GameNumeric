% savear: save area project
% ������Ŀ�ű�
%
% 1. ���湤����
% 2. ������Ŀ��Ϣ�ļ�
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
