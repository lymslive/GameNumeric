% 决断一个元素是否根元素
% 必须是标量对象，且无父元素
function tf = isroot(obj)
tf = true;
if numel(obj) > 1
	tf = false;
elseif isempty(obj.parent)
	tf = false;
elseif obj.parent ~= xmlel.RealRoot
	tf = false;
end
end %F-main
