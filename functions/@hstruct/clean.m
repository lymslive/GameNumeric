% clean: clean some variable in struct
% ����ĳЩ������Ĭ����ĩβ_ ��ע�����
%
% ���������
% @pattern: ��������ʽָ��������Ĭ�� '_$'
%
% ���������
% �����Լ�ԭ�����ڲ��� stin_ ��ĳЩ������ѱ��Ƴ�
%
% maintain: lymslive / 2015-12-05
function me = clean(me, pattern)

if nargin < 2
	pattern = '_$';
end

if ~ischar(pattern) || size(pattern, 1) > 1
	error('user:hstruct:clean', 'expect a string as regexp');
end

names = me.get();

for i = 1 : numel(names)
	name = names{i};
	if ~isempty(regexp(name, pattern))
		me.set(name, []);
	end
end

end %F
