% 判断一个变量是否为标量字符串
function tf = isscalarstring(val)

tf = true;
if ~ischar(val) || size(val, 1) > 1
	tf = false;
end

end %F main
