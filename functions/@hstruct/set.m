% set: alternative way of dot subasgn
% 用函数方法代替点索引，用于成员方法更方便
% 限标量对象
%
% 输入参数：
% @me: 标量对象
% @field: 字符串域名
% @value: 设定值
%
% 输出参数：
% @old: 旧值
%
% 若缺省第三参数时，相当于 get 取值
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
