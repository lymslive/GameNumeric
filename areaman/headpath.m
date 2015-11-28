% headpath: manage the header part of path
% 管理 path 的前部分
%
% 一般情况下，在命令窗运行 path 会打印太长的列表
% 故增加该函数查看或删除位于前面位置的部分 path
%
% 输入参数：
% 如果 n 是正数，表示显示前 n 个 path
% 如果 n 是负数，表示删除第 n 个 path
% 如果 n 是 0，则运行内置 path 命令
% 如果省略参数，默认是 +10，显示前10个 path
%
% 如果有输出参数，则将部分 path 保存到 out 中
% 返回值 out 是 cellstr 类型, n*1 列向量
% 注意内置 p = path 返回的是以 ; 分隔的长串字符串
%
% maintain: lymslive / 2015-11
function out = headpath(n)

if nargin < 1
	n = 10;
end

list = path();
list = strsplit(list, pathsep);

if n > 0
	if nargout > 0
		out = list(1 : n);
		out = out';
	else
		for i = 1 : n
			disp([num2str(i), ' : ', list{i}]);
		end
	end

elseif n < 0
	list(-n) = [];
	n = -n + 1;
	if nargout > 0
		out = list(1 : n);
		out = out';
	else
		for i = 1 : n
			disp([num2str(i), ' : ', list{i}]);
		end
	end
	list = strjoin(list, pathsep);
	path(list);

else
	if nargout > 0
		out = list';
	else
		path();
	end
end

end %-of main
