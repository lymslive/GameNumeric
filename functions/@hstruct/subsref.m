% subsref:
% ������������������ת�����ڲ� stin_
%
% ��������֧�ֶ������飬��Ϊÿ�������ڲ��� struct ������ȫ��ͬ
% ���ò����ڵ��򣬷��ؿ�[]
%
% maintain: lymslive / 2015-12-04
function out = subsref(me, index)

switch index(1).type

case '.'
	if numel(me) > 1
		error('user:hstruct:subsref', ...
		'dot index only support scalar object');
	end

	name = index(1).subs;
	if strcmp(name, 'stin_')
		error('usr:hstrcut:subsref', 'Private property');
	elseif ismember(name, methods(class(me)))
		out = builtin('subsref', me, index);
	else
		try
			out = me.stin_.(name);
		catch
			out = [];
		end
		if length(index) > 1
			out = subsref(out, index(2:end));
		end
	end

case '()'
	subme = me(index(1).subs{:});
	if length(index) == 1
		out = subme;
	else
		out = subsref(subme, index(2:end));
	end

case '{}'
	error('user:hstruct:subsref', ...
	'hstrcut objects, not a cell array');

otherwise
	error('user:hstruct:subsref', ...
	'Unexpected index.type of %s', index(1).type);

end %S

end %F
