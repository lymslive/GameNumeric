% 根据标鉴名取得元素对象
function list = getElement(obj, name)

list = [];
if nargin < 2 || ~ischar(name)
	return;
end

n = 0;
for i = 1 : numel(obj)
	if strcmp(obj(i).name, name)
		n = n + 1;
		if n == 1 
			list = obj(i);
		else
			list(n, 1) = obj(i);
		end
	end
end

end %F-main
