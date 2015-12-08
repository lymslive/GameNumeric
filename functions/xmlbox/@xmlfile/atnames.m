% ȡ��Ԫ�ص��������б����� cellstr
% ����ж��ͬ��Ԫ�أ�����һ��Ԫ�ص�������ȡ
%
% �ο� atval ��ȡ����ֵ
function names = atnames(obj, xpath)
	
	if nargin < 2
		error('xmlfile.atvel require a path as input, string or struct!');
	end

	if ischar(xpath)
		xpath = regexprep(xpath, '^/*', '');
		xpath = regexprep(xpath, '/', '.');
		st = eval(['obj.sroot.' xpath]);
	elseif isstruct(xpath)
		st = xpath;
	else
		error('argument type error! a string path or struct required!');
	end

	if numel(st) > 1
		st = st(1);
	end

	names = fieldnames(st.AT);

end
