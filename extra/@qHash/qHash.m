classdef qHash < handle

properties (Access = private)
% colum array of sHash
hlist;
end %P

properties (Dependent)
count;
capacity;
factor;
end %P

properties (Constant)
overload = 1.5;
end %P

methods

function obj = qHash(varargin)

if nargin == 0
	obj.hlist = sHash.empty(0,1);
	return;
end

if nargin == 1
	arg = varargin{1};
	if isa(arg, 'sHash')
		arg = arg.cell();
	end

	if iscell(arg)
		for i = 1 : size(arg, 2)
			obj.set(arg{1,i}, arg{2,i});
		end
	end
elseif nargin >= 2
	sh = sHash(varargin{:});
	obj = qHash(sh);
end

end %F

function val = get.count(obj)
val = 0;
for i = 1 : numel(obj.hlist)
	val = val + obj.hlist(i).count;
end
end %F

function val = get.capacity(obj)
val = numel(obj.hlist);
end

function val = get.factor(obj)
if obj.capacity ~= 0
	val = obj.count / obj.capacity;
else
	val = 0;
end
end

end %M-basic

methods (Static)
code = hashcode(key, base)
ST = main()
end

end %C-main
