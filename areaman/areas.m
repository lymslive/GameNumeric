% areas: 
% �鿴����򿪵� area ��Ŀ�б���ȡ��ĳ����Ŀ��¼
%
% ����򿪵���Ŀ������ areas_ls.mat (��������·����)
% ������ı����У�
% .capacity: ��ౣ�漸�������Ŀ��Ĭ���� 5
% .area: cellstr, n * 2 ��������ʽ��ÿ��Ԫ������Ŀ·��������Ŀ�ļ�
%
% Input:
%   @rindex: ����ڼ�����Ĭ��0��ʾ����Ǹ���ָ����ȡ�ĸ���Ŀ
% Ouput:
%   @basedir: ��ĿĿ¼
%   @prjfile: ��Ŀ�ļ�
%
% Remark:
%   ���û�з��ز��������������ӡ��ʷ��Ŀ�б�������ȴ�ӡ
%
% maintain: lymslive / 2015-11

function [basedir, prjfile] = areas(rindex)

basedir = '';
prjfile = '';

if 2 == exist('areas_ls.mat', 'file')
	list = load('areas_ls.mat');
	if isfield(list, 'area') 
		len = size(list.area, 1);
		if len > 0
			if nargout > 0
				if nargin < 1
					rindex = 0;
				end
				lindex = len - rindex;
				if lindex < 1
					lindex = 1;
				end
				basedir = list.area{lindex, 1};
				prjfile = list.area{lindex, 2};
			else
				disp('recent area project:');
				for i = len : -1 : 1
					disp([list.area{i, 1}, filesep, list.area{i,2}]);
				end
			end
		end % len(area) > 0
	end %-of exist .area
end %-of exist .mat

end %-of main
