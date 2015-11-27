% hisarea: add history area
% 添加一个项目记录到历史列表，用于保存最近打开的项目
% 
% Input:
%   @basedir: 项目所在目录
%   @prjfile: 项目文件 *_ar.mat
%
%  Output:
%    @status: 添加历史记录否成功
%
%  所做工作：
%  在本函数所在目录下保存一个 areas_ls.mat 文件，其包含变量有：
% .capacity: 最多保存几个最近项目，默认是 5
% .area: cellstr, n * 2 列向量形式，每行元胞是项目路径，与项目文件
%  将接收参数 {basedir, prjfile} 插入到 area 列表的最后一行
%  如果超过最大行数，则推出最早的记录，是 area(1,:) 第一行
%  当然会判断参数是否与最后一行记录相同，避免重复添加
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

% 不重复添加最近一个项目
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
