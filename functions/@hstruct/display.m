% display: 
% ��ʾ����
%
% ֻ��ʾ�������󣬷���������� display
%
% maintain: lymslive / 2015-12-04
function display(me)

if numel(me) == 1
	disp(me.stin_);
else
	builtin('disp', me);
end

end %F
