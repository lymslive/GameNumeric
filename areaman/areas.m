% areas: 
% 查看最近打开的 area 项目列表，或取得某个项目记录
%
% 最近打开的项目保存在 areas_ls.mat (须在搜索路径中)
% 其包含的变量有：
% .capacity: 最多保存几个最近项目，默认是 5
% .area: cellstr, n * 2 列向量形式，每个元胞是项目路径，与项目文件
%
% Input:
%   @rindex: 最近第几个，默认0表示最近那个，指定获取哪个项目
% Ouput:
%   @basedir: 项目目录
%   @prjfile: 项目文件
%
% Remark:
%   如果没有返回参数，则在命令窗打印历史项目列表，最近的先打印
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
