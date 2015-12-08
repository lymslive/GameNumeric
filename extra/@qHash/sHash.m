% 将 qHash 转为简单紧凑的 sHash 对象
function sh = sHash(obj)

hcell = {};
for i = 1 : obj.capacity
	hi = obj.hlist(i);
	if isempty(hi) || hi.count == 0
		continue;
	else
		hcell = [hcell hi.get()];
	end
end

sh = sHash(hcell);

end %F-main
