% get: alternative way of dot subsref
% 用函数方法代替点索引，用于成员方法更方便
% 限标量对象
%
% 输入参数：
% @me: 标量对象
% @field: 字符串域名
%
% 输出参数：
% @out: 即所获取的值，不存在的域返回空
%
% 若缺省第二参数，则相当于 fieldnames 取域名
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
