classdef xmldoc < handle

properties (Access = private)
root = [];
end %P

properties (Access = public)
file = '';
end

properties (Transient, SetAccess = private)
xpath = '/';
self = [];
end

methods

% constructor, possbile styles:
% xmldoc(), xmldoc(root), xmldoc(file)
function obj = xmldoc(varargin)

switch nargin
case 0
	return;
case 1
	arg = varargin{1};
	if isa(arg, 'xmlel')
		obj.root = arg;
	elseif ischar(arg)
		obj.file = file;
		obj.read();
	else
		error('unexpected input to xmldoc constructor!');
	end
otherwise
	error('Too many argument to construct xmlmod!');
end

end %F-construct

function set.root(obj, val)

if isempty(val)
	obj.root = [];
	obj.xpath = '';
	obj.slef = [];
else
	if ~isa(val, 'xmlel') || numel(val) > 1
		error('xmlmod expects a scalar root element!');
	end
	if ~isroot(val)
		val.rootas();
	end
	obj.root = val;
	obj.cdroot();
end

end %F-set.root

% 全路径，必须以 / 开始，末尾无 /
function set.xpath(obj, val)

if isempty(val)
	obj.xpath = '';
else
	if ~ischar(val) || size(val, 1) > 1
		error('xmlmod expect a scalar string as xpath!');
	end
	if val(1) ~= '/'
		val = ['/' val];
	end
	if val(end) == '/'
		val(end) = [];
	end
	obj.xpath = val;
end

end %F-set.xpath

end %M-basic

end %C-main
