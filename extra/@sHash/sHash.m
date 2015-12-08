classdef sHash < handle

properties (Access = private)
pairs;
end %P

properties (Dependent)
keys;
count;
end %P

methods

function obj = sHash(varargin)

if nargin == 0
	obj.pairs = {};
	return;
end

if nargin == 1
	arg = varargin{1};
	if ~iscell(arg) || size(arg, 1) ~= 2
		error('sHash expects a 2*n cell array!');
	end
	for i = 1 : size(arg, 2)
		key = arg{1, i};
		if ~sHash.isstrkey(key)
			error('SHash expects scalar string as key!');
		end
	end
	obj.pairs = arg;
	return;
end

len = numel(varargin);
i = 1;
n = 1;
obj.pairs = cell(ceil(len/2), 2);
while i <= len
	key = varargin{i};
	if ~sHash.isstrkey(key)
		error('SHash expects scalar string as key!');
	end
	i = i + 1;
	if i <= len
		val = varargin{i};
	else
		val = [];
	end

	obj.pairs{1, n} = key;
	obj.pairs{2, n} = val;

	i = i + 1;
	n = n + 1;
end

end %F

function keys = get.keys(obj)
if isempty(obj.pairs)
	keys = {};
else
	keys = obj.pairs(1, :);
end
end %F

function cnt = get.count(obj)
cnt = size(obj.pairs, 2);
end %F

end %M-basic

methods (Static)
tf = isstrkey(key)
key = tostrkey(arg)
end %M

methods (Access = public)
obj = set(obj, key, val)
val = get(obj, key)
end %M

end %C
