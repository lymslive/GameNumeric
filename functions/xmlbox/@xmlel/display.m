% 标量对象，直接格式化 xml
% 对象数组，统计包含各种元素的数目
function display(obj)

if isempty(obj)
	fprintf('%s empty xmlel array\n', mat2str(size(obj)));
	return;
end

nobj = numel(obj);

if nobj == 1
	if isEmptyNode(obj)
		disp('1*1 Empty xml element object');
	else
		disp(obj.char());
	end
	return;
end

ecount = obj.count();
if length(ecount) == 1
	number = ecount;
	names = {obj(1).name};
else
	names = ecount{1};
	number = ecount{2};
end

str = sprintf('%d xml element:', nobj);
for i = 1 : length(names)
	if isempty(names{i}) || strcmp(names{i}, 'NONE')
		name = 'Empty Element';
	else
		name = names{i};
	end
	str = sprintf('%s\n%d * <%s>', str, number(i), name);
end

disp(str);

end %F-main
