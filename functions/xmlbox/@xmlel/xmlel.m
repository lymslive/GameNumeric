% xmlel, xml 元素结点类
% 设计为对象数组整合使用
classdef xmlel < handle

properties (Access = public)
% 元素名, string 标量
name;
% 属性, struct，值统一储存字符串，标量 string
at;
end %P

properties (SetAccess = protected)
% 子元素，xmlel 本身类对象的有序数组
% 文本内容作为一个特殊子元素，name='#Text', at=[]
% 当文本元素时，child 储存文本字符串
child;
end %P

properties (Transient, SetAccess = protected)
% 父元素指针，根元素为空
parent;
end %P

properties (Constant)
% 作为父指针的特殊值，根元素的父元素是 RealRoot，悬元素的父元素是 NoneRoot
RealRoot = true;
NoneRoot = false;
% 字符变量转为文本元素而非属性值的长度阈值
MaxCharAt = 50;
end

properties (Dependent)
% 元素的属性名 cellstr
atname
% 由属性值构成的向量 cellstr
vector
end %P

methods %M-basic

% 构造函数
% xmlel(): 无参数构造空对象，可用 isempty 判断；或在load时重建父指针
% xmlel(n): 单数字参数，构造 n 个空对象列向量
% xmlel(name): 构造一个标鉴名为 name 的元素
% xmlel(name, n):构造 n 个标鉴名为 name 的元素 
% xmlel(variable): 其他单参数（非标量数字或字符串）将变化转化为 xmlel 对象
function obj = xmlel(varargin)

if nargin == 0
	return;

elseif nargin == 1
	arg = varargin{1};
	if ischar(arg) && size(arg, 1) == 1
		obj.name = arg;
	elseif isnumeric(arg) && isscalar(arg)
		obj(arg, 1) = xmlel();
	else
		obj = xmlel.cast(arg);
	end
	return;

elseif nargin == 2
	name = varargin{1};
	number = varargin{2};
	if ~(isnumeric(number) && isscalar(name))
		error('useage: xmle(tagName, numbers)');
	elseif ~(ischar(name) && size(name, 1) == 1)
		error('useage: xmle(tagName, numbers)');
	end
	for i = number : -1 : 1
		obj(i, 1) = xmlel(name);
	end

else
	error('Invalid input argument to construct xmlel object!');
end

end %F-contructor

% 元素名规范：标志符，字母开头，后面可接字母或数字
function set.name(obj, val)


if ~ischar(val) || size(val, 1) > 1
	error('The element tag name expects a scalar string!');
end
if strcmp(val, '#Text')
	obj.name = val;
	return;
end

pat  = '^[a-zA-Z][a-zA-Z0-9_]*(:[a-zA-Z][a-zA-Z0-9_]*)?$';
if ~isempty(regexp(val, pat, 'once'))
	obj.name = val;
else
	error('"%s" is not a valid element tag name!', val);
end

end %F-set.name

% 属性规范：一个标量 struct，每个域的值也应是标量 string
% 其他类型变量宜转化为字符串赋给属性的值
function set.at(obj, val)

if isempty(val)
	obj.at = [];
	return;
end

if ~isstruct(val) || numel(val) > 1
	error('The attribute of element expects a scalar struct!');
end

fd = fieldnames(val);
for i = 1 : length(fd)
	fval = val.(fd{i});
	if ~ischar(fval) || size(fval, 1) > 1
		error('The attribute value expects a scalar string!');
	end
end

obj.at = val;

end %F-set.at

% 子元素规范：子元素也是相同的 xmlel 对象实例，可以是数组，要求是列向量
% 特殊情况：文本元素的 child 是字符串，也可为空
function set.child(obj, val)

if isempty(val)
	obj.child = [];
	return;
end

if strcmp('#Text', obj.name)
	if ~ischar(val) || size(val, 1) > 1
		error('The text content of a element expects a scalar string!');
	end
else
	if ~isa(val, 'xmlel')
		error('The child of element expects a element also!');
	elseif size(val, 2) > 1
		error('Multy children expects stored in a column xmlel array!');
	end
end

obj.child = val;
if isa(val, 'xmlel') && val(1).parent ~= obj
	obj.parentas(val);
end

end %F-set.child

% 父元素规范：指向另一个元素，可空
% 特殊情况：可指向逻辑值
function set.parent(obj, val)

if isempty(val)
	obj.parent = [];
	return;
end
if islogical(val)
	pass = true;
elseif ~isa(val, 'xmlel') || numel(val) > 1
	error('The parent of element expects a scalar element!');
end

obj.parent = val;

end %F-set.parent

% 取出对象元素的属性名与属性值
% 若无属性 atname = {}
% 仅可由标量对象调用
function val = get.atname(obj)

if ~isscalar(obj)
	error('obj.atname is valid only for saclar xmlel object!');
end

if isempty(obj.at)
	val = {};
else
	val = fieldnames(obj.at);
end

end
% 如果属性值可全转为数字，则返回 double 向量，否则返回 cellstr 行向量
function val = get.vector(obj)

if ~isscalar(obj)
	error('obj.vector is valid only for saclar xmlel object!');
end

atname = obj.atname;
if isempty(atname)
	val = [];
	return;
end

len = numel(atname);
cval = cell(1, len);

for i = 1: len
	cval{i} = obj(1).at.(atname{i});
end

val = cval;

end %F

end %M-basic

% 非公有方法
methods (Access = protected)

number = parentas(obj, child)
number = parentto(obj, parent)

end %M-protected

methods (Static)
% 将其他类型变量转为 xml 元素对象
obj = cast(var, name, atname)
obj = createTextNode(str)
cpath = pathseg(pathstr, onlyname)
tf = isscalarval(val)
c = tostrval(d, keep)
d = tonumval(c)
end %M-Static

end %C
