% 静态方法
% 将一个 struct (array) 转化为数值矩阵
% 可自定义 fields 顺序，否则按默认顺序
% 每个 struct 展成一行
% 全数值的话，返回 double，否则返回 cell 矩阵
function d = struct2matrix(st, fields)
	
	if ~isstruct(st)
		error('struct2double require strct(array) input!');
		return;
	end
	if nargin < 2 || isempty(fields)
		fields = fieldnames(st);
	end
	if ischar(fields)
		fields = cellstr(fields);
	end

	m = numel(st);
	n = numel(fields);
	c = cell(m, n);
	alldouble = true;
	for i = 1 : m
		s = st(i);
		for j = 1 : n

			if isfield(s, fields{j})
				c{i,j} = s.(fields{j});
			else
				c{i,j} = 0;
			end

			if ~isnumeric(c{i,j})
				if ischar(c{i,j})
					tryd = str2double(c{i,j});
					if ~isnan(tryd)
						c{i,j} = tryd;
					end
				end
				if ~isnumeric(c{i,j})
					alldouble = false;
				end
			end

		end
	end

	if alldouble
		d = zeros(m, n);
		for i = 1 : m
			for j = 1 : n
				d(i, j) = c{i, j};
			end
		end
	else
		d = c;
	end

end %-of main
