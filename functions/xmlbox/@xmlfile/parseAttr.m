% 静态方法，解析一个"属性=值"串
% 返回一个 struct
% 其域名即各个属性，值尽量转化为double，或保留 char
% 若额外参数 notrans 为 ture, 则不转化属性值
function st = parseAttr(str, notrans)

	if nargin < 2
		notrans = false;
	end

	tok = regexp(str, xmlfile.patAttris, 'tokens');
	if isempty(tok)
		st = [];
		return;
	else
		for i = 1 : length(tok)
			pair = tok{i};
			name = pair{1};
			value = pair{2};

			if ~notrans
				dval = str2double(value);
				if ~isnan(dval)
					value = dval;
				end
			end

			st.(name) = value;
		end
	end
end
