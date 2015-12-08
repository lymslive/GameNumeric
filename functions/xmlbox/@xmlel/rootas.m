% rootas: 将自身设为根元素
% 如果提供一个额外输入参数，则将这些元素挂为自己的直接子元素
function ST = rootas(obj, element)
ST = 1;

if ~isscalar(obj)
	error('xmlel.rootas() expects a sacalar element object!');
end

obj.parent = xmlel.RealRoot;

if nargin >= 2
	obj.pushChild(element);
end

ST = 0;
end %F-main
