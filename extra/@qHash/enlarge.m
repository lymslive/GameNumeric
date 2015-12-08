function obj = enlarge(obj)

cold = obj.capacity;
if cold == 0
	cnew = 10;
	sh = [];
else
	cnew = cold * 2;
	sh = obj.sHash();
end
obj.hlist = sHash();
obj.hlist(cnew, 1) = sHash();

if isempty(sh)
	return;
end

keys = sh.keys;
for i = 1 : sh.count
	key = keys{i};
	val = sh.get(key);
	obj.set(key, val);
end

end %F-main
