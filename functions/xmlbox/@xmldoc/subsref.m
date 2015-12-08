% 索引重载，转化为 xpath 解析
% 结果返回另一个 xmlmod 对象，扩展原对象的 xpath 路径
function result = subsref(obj, subst)

result = [];
if numel(obj) > 1
	result = builtin('subsref', obj, subst);
	return;
end

first = subst(1);
if ~strcmp(first.type, '.')
	result = builtin('subsref', obj, subst);
	return;
end

firstName = first.subs;
if ismember(firstName, [properties(obj); methods(obj)])
	result = builtin('subsref', obj, subst);
	return;
end

newobj = obj.copy();
i = 1;
sublen = numel(subst);
while i <= sublen

	if ~isa(newobj.self, 'xmlel')
		result = builtin('subsref', newobj.self, subst(i:end));
		return;
	end

	switch subst(i).type
	case '.'
		name = subst(i).subs;
		index = 0;
		if i < sublen
			nextsub = subst(i);
			if strcmp(nextsub.type, '()')
				index = nextsub.subs{1};
				i = i + 1;
			end
		end
		try
			newobj.cdchild(name, index);
		catch
			if ismember(name, [properties('xmlel'); methods('xmlel')])
				if index == 0
					leftsub = subst(i:end);
				else
					leftsub = subst(i-1:end);
				end
				result = builtin('subsref', newobj.self, leftsub);
				return;
			else
				error('%s: nuknown child or method!', name);
			end
		end
	otherwise
		error('unexpected subs type!');
	end

	i = i + 1;
end

% node = obj.eval(path);
result = newobj;

end %F-main
