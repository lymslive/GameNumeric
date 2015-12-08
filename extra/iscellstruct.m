% 判断一个 cell 是否只包含 struct 标量
function tf = iscellstruct(c)

	tf = true;

	if ~iscell(c)
		tf = false;
		return;
	end

	for i = 1 : numel(c)
		if ~isstruct(c{i})
			tf = false;
			break;
		elseif numel(c{i}) > 1
			tf = false;
			break;
		end
	end

end
