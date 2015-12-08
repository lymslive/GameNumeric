% 将 hash table 转为 cell
function rc = cell(obj)

if numel(obj) > 1
	error('qHash to cell can only called by scalar object!');
end

rc = cell(obj.capacity, 1);
for i = 1 : obj.capacity
	hi = obj.hlist(i);
	if isempty(hi) || hi.count == 0
		rc{i} = {};
	else
		rc{i} = hi.cell();
	end
end

end %F-main
