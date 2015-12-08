% 将一个 struct 格式化为 xml 文本
% 返回 cell strings 列向量
% 输入：struct 变量、变量名即元素标签名，缩进层次
function cs = fst2xml(stlist, name, deep)

	if nargin >= 3
		leading = repmat(xmlfile.sindent, 1, deep);
		leading = char(leading);
	else
		deep = 0;
		leading = '';
	end

	cs = cell(0,1);
	for k = 1 : numel(stlist)
		st = stlist(k);

		atstr = '';
		if ~isempty(st.AT)
			fds = fieldnames(st.AT);
			for i = 1 : length(fds)
				aname = fds{i};
				value = st.AT.(aname);
				if isnumeric(value)
					value = num2str(value);
				end
				spair = sprintf('%s="%s"', aname, value);
				atstr = [atstr ' ' spair];
			end
		end

		fds = fieldnames(st);
		if length(fds) <= 2 % only .AT .TT no subelement
			if isempty(st.TT) % no Text either
				line = sprintf('%s<%s%s/>', leading, name, atstr);
			else
				line = sprintf('%s<%s%s>%s</%s>', leading, name, atstr, st.TT, name);
			end
			cs = [cs; {line}];
		else
			head = sprintf('%s<%s%s>', leading, name, atstr);
			foot = sprintf('%s</%s>', leading, name);
			body = cell(0, 1);
			for i = 3 : length(fds)
				subel = xmlfile.fst2xml(st.(fds{i}), fds{i}, deep+1);
				body = [body; subel];
			end
			cs = [cs; {head}; body; {foot}];
		end
	end

end
