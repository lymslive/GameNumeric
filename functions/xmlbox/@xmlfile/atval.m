% ȡ��Ԫ�ص�����ֵ�����ؾ���
% ÿ��Ԫ���Ǿ����һ�У�ÿ��������һ��
% ����������ֵ���󣬷���Ԫ������
% ���������
%   xpath, /�ָ���Ԫ��·������.�ָ�����ֱ���� obj.sroot.element.sub... �ṹ
%   colseq, ��ѡ�������������˳��cellstr
% �ο� struct2matrix ��д��������
function matrix = atval(obj, xpath, colseq)
	
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

	m = numel(st);

	for i = 1 : m
		if ~isfield(st(i), 'AT')
			error('Struct have no AT value!');
		end
		if i == 1
			newst = st(i).AT;
		else
			newst(i) = st(i).AT;
		end
	end

	if isempty(newst)
		matrix = [];
		return;
	end

	if nargin >= 3
		matrix = struct2matrix(newst, colseq);
	else
		matrix = struct2matrix(newst);
	end
end
