function key = tostrkey(arg)

if sHash.isstrkey(arg)
	key = arg;

elseif isnumeric(arg)
	if numel(arg) == 1
		key = num2str(arg);
	else
		error('can not convert to scalar string key!');
	end

elseif islogical(arg)
	if numel(arg) == 1
		TF = {'false', 'true'};
		key = TF(double(arg) + 1);
	else
		error('can not convert to scalar string key!');
	end

else
	try
		key = char(arg);
	catch
		error('can not convert to scalar string key!');
	end
end

end
