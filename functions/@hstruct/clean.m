% clean: clean some variable in struct
% 清理某些变量，默认是末尾_ 的注入变量
%
% 输入参数：
% @pattern: 以正则表达式指定变量，默认 '_$'
%
% 输出参数：
% 返回自己原对象，内部的 stin_ 的某些域可能已被移除
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
