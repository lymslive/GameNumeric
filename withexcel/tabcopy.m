% 将可矩阵化数据拷入系统剪切板（无返回值，但修改了系统剪切板）
% clipboard('copy', data) 用 mat2str 转化字符拷贝
% 产生如 [8 1 6;3 5 7;4 9 2] 的字符，方便作为 matlab 的语句重用
% 该方法将矩阵转化为的 \t \n 分隔的字符块拷贝，方便粘贴入 excel 等外部应用
%
% 如果为 excel 安装了 Spreadsheet Link EX 插件
% 从 excel 中一般能较好地直接从 matlab 工作区导入数据
% 然后该方法利用剪切板还能方便地粘贴到其他应用程序中
%
% 目前支持类型：二维矩阵，cell table
% logical 转为数字 0/1
%
% maintain: lymslive / 2015-12-07
function tabcopy(data)

if nargin < 1
	error('请至少输入一个参数');
end

cstr = '';
TAB = 9;
CR = 10;
% TF = {'false', 'true'};

if isnumeric(data) || islogical(data)
	[m, n] = size(data);
	for i = 1 : m
		for j = 1 : n - 1
			cstr = [cstr num2str(data(i,j)) TAB];
		end
		cstr = [cstr num2str(data(i, end))];
		cstr = [cstr CR];
	end

elseif iscell(data)
	[m, n] = size(data);
	for i = 1 : m
		for j = 1 : n
			val = data{i, j};

			sval = '';
			if isnumeric(val) || islogical(val)
				sval = num2str(val);
			elseif ischar(val)
				sval = val;
			else
				try
					sval = char(val);
				catch
					sval = class(val);
				end
			end

			if j < n
				cstr = [cstr sval TAB];
			else
				cstr = [cstr sval];
			end
		end
		cstr = [cstr CR];
	end

elseif istable(data)
	tabcopy(table2cell(data));
end %if numeric

% 调用系统剪切板
clipboard('copy', cstr);

end %of main
