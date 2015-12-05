% display: 
% 显示对象
%
% 只显示标量对象，否则调用内置 display
%
% maintain: lymslive / 2015-12-04
function display(me)

if numel(me) == 1
	disp(me.stin_);
else
	builtin('disp', me);
end

end %F
