% 试图将一个元胞矩阵转化为数值矩阵
% 要求每个元胞内容为一个数值标量，或可转化为数值的字符串
% 逻辑值或 true/false 字符串将转化为 1/0
% 字符串 'nan' 也可转为 double NaN
% 如果任一元胞转化失败，则抛出异常出错
function d = cell2double(c)

if ~iscell(c)
	error('expects a cell matarix!');
end

[m n] = size(c);
d = zeros(m, n);

for i = 1 : m
	for j = 1 : n
		val = c{i, j};

		if isnumeric(val)
			d(i,j) = val;
		elseif islogical(val)
			d(i,j) = double(val);
		elseif isscalarstring(val)

			if strcmpi(val, 'true')
				val = 1;
			elseif strcmpi(val, 'false')
				val = 0;
			elseif strcmpi(val, 'nan')
				val = nan;
			else
				val = str2double(val);
				if isnan(val)
					d = [];
					error('can not convert some string to double!');
					return;
				end
			end

			d(i, j) = val;
		else
			error('can not convert cell to double!');
			d = [];
			return;
		end

	end
end

end %F-main
