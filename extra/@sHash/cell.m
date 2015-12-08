% 将 hash table 转为 cell
function rc = cell(obj)

if numel(obj) > 1
	error('qHash to cell can only called by scalar object!');
end

rc = obj.pairs;

end %F-main
