% hisarea: add history area
% ���һ����Ŀ��¼����ʷ�б����ڱ�������򿪵���Ŀ
% 
% Input:
%   @basedir: ��Ŀ����Ŀ¼
%   @prjfile: ��Ŀ�ļ� *_ar.mat
%
%  Output:
%    @status: �����ʷ��¼��ɹ�
%
%  ����������
%  �ڱ���������Ŀ¼�±���һ�� areas_ls.mat �ļ�������������У�
% .capacity: ��ౣ�漸�������Ŀ��Ĭ���� 5
% .area: cellstr, n * 2 ��������ʽ��ÿ��Ԫ������Ŀ·��������Ŀ�ļ�
%  �����ղ��� {basedir, prjfile} ���뵽 area �б�����һ��
%  �������������������Ƴ�����ļ�¼���� area(1,:) ��һ��
%  ��Ȼ���жϲ����Ƿ������һ�м�¼��ͬ�������ظ����
%
% maintain: lymslive / 2015-11
function status = hisarea(basedir, prjfile)

status = false;
if ~ischar(basedir) || ~ischar(prjfile)
	disp('hisares(): expects a string as full path');
	return;
end
if 2 ~= exist([basedir filesep prjfile], 'file')
	disp(['directory not exist: ', basedir]);
	return;
end

thisfile = mfilename('fullpath');
pathstr = fileparts(thisfile);
matfile = [pathstr filespe 'areas_ls.mat'];

if 2 == exist(matfile, 'file')
	list = load(matfile);
else
	list = struct;
end

if ~isfield(list, 'capacity') || ~isnumeric(list.capacity)
	list.capacity = 5;
end

if ~isfield(list, 'area')
	list.area = {basedir, prjfile};
end

% ���ظ�������һ����Ŀ
if strcmp(list.area{end, 1}, basedir)
	len = size(list.area, 1);
	if len < list.capacity
		list{len + 1, 1} = basedir;
		list{len + 1, 2} = prjfile;
	else
		list([1 : len-1], :) = list([2 : len], :);
		list{len, 1} = basedir;
		list{len, 2} = prjfile;
	end
end

save(matfile, '-struct', 'list');

status = true;

end %-of main
