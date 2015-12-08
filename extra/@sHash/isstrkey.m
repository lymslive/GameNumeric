function tf = isstrkey(key)
tf = true;
if ~ischar(key) || size(key, 1) > 1
	tf = false;
end
end

