function val = pop(me, index)
% remove the last element or the one at specific position.
% and return the just removed element.
%
% usage:
% * me.pop(); remove the last
% * me.pop(1); remove the first
% * me.pop(i); remove the ithe element
%
% requirement:
%   index, if provided, should between in 1 and me.count;
%
% maintain: lymslive / 2015-12-09

if nargin < 2
    index = me.count;
end

if ~isnumeric(index) || numel(index) ~= 1
    error('push@cLisst: the position expects a scalar number ');
end

val = me.top(index);
me.list_(index) = [];

end %F
