% 显示对象
% 额外参数 preview 表示打印预览多少对 key=val
% 默认 10 对，0 全部显示。
function display(obj, preview)

if nargin < 2
	preview  = 10;
end

fprintf('sHash table with pairs %d:\n', obj.count);
if obj.count > preview || preview == 0
	newobj = sHash(obj.pairs(:, 1:preview));
	str = newobj.char();
	fprintf('%s\n... and more\n', str);
else
	str = obj.char();
	fprintf('%s\n', str);
end
end %F
