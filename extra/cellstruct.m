% 将多个 struct 放入 cell 中
% 可变输入参数，允许 struct 及其向量或矩阵，单个 struct，其他 cellstruct
% 返回列向量 cell，每个 cell 一个标量 struct
% struct 数组只允许域名相同的串接在一起，且不会自动扩展域名，赋值会自动扩展
% 因此，用 cell 分别存储 struct 更通用
function c = cellstruct(varargin)

	c = cell(0, 1);
	for i = 1 : nargin
		arg = varargin{i};
		if isstruct(arg)
			for j = 1 : numel(arg)
				c = [c; {arg(j)}];
			end
		elseif iscellstruct(arg)
			c = [c; arg(:)];
		else
			error('cellstruct only accept struct input!');
		end
	end

end %-of main
