% rootto: 将自身挂在一个根元素下
% 输入参数 root 是一个 xmlel 标量，或元素名字符串标量
% 若省略，则默认创建一个名为 'root' 的根元素
% 该方法会将 root 元素的父元素指向真根 RealRoot
function ST = rootto(obj, root)

ST = 1;

if nargin < 2
	root = xmlel('root');
elseif ischar(root) && size(root, 1) == 1
	root = xmlel(root);
elseif isa(root, 'xmlel') && isscalar(root)
	pass = true;
else
	error('xmlel.root() expects a root name or root element object!');
end

root.pushChild(obj);
root.parent = xmlel.RealRoot;

ST = 0;

end
