% get: alternative way of dot subsref
% �ú���������������������ڳ�Ա����������
% �ޱ�������
%
% ���������
% @me: ��������
% @field: �ַ�������
%
% ���������
% @out: ������ȡ��ֵ�������ڵ��򷵻ؿ�
%
% ��ȱʡ�ڶ����������൱�� fieldnames ȡ����
%
% maitain: lymslive / 2015-12-05
function out = get(me, field)

if nargin < 2
	if nargout < 1
		disp(me.fieldnames());
	else
		out = me.fieldnames();
	end
	return;
end

if ~ischar(field) || numel(me) > 1
	error('user:hstruct:get', 'only support get scalar object field by name');
end

st.type = '.';
st.subs = field;

out = subsref(me, st);

end %F
