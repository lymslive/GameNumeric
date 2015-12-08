% 判断是否标量数字或字符串
function tf = isscalarval(val)

tf = true;
if isnumeric(val)
	if numel(val) > 1
		tf = false;
	end
elseif ischar(val)
	if size(val, 1) > 1
		tf = false;
	end
else
	tf = false;
end

end %F
