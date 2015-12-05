% set: alternative way of dot subasgn
% �ú���������������������ڳ�Ա����������
% �ޱ�������
%
% ���������
% @me: ��������
% @field: �ַ�������
% @value: �趨ֵ
%
% ���������
% @old: ��ֵ
%
% ��ȱʡ��������ʱ���൱�� get ȡֵ
%
% maitain: lymslive / 2015-12-05
function old = set(me, field, value)

if nargin < 2
	disp(me.fieldnames());
	old = [];
	return;
elseif nargin < 3
	if nargout < 1
		disp(me.get(field));
	else
		old = me.get(field);
	end
	return;
end

if ~ischar(field) || numel(me) > 1
	error('user:hstruct:get', 'only support set scalar object field by name');
end

st.type = '.';
st.subs = field;

old = me.get(field);
me = subsasgn(me, st, value);

end %F
