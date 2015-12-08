% 显示格式：
% 首行打印容量、当前元素个数及填充系数
% 接着为每个非空链表打印一行键值对，并加前缀数组索引
function display(obj)

fprintf('hash capacity = %d; element count = %d; overload factor = %g\n', ...
	obj.capacity, obj.count, obj.factor);

for i = 1 : obj.capacity
	sh = obj.hlist(i);
	if ~isempty(sh) && sh.count > 0
		fprintf('[%d]: %s\n', i, sh.char());
	end
end

end %
