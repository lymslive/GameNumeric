function val = top(me, index)
% top@cList: get the top element, or the element in specific position.
% the index support multiply indices or any array index.
%
% usage:
% * me.top(); get the last element of list
% * me.top(1); get the first element of list
% * me.top(i); get the ith element of list
%
% requirement:
%   the index should be a scalar number between 1 and me.count,
%   otherwise throw a error.
%
% trigger error when top on a empty list.
%
% maintain: lymslive / 2015-12-09

if me.isemptied()
    error('top@cList: try to operate on empty list with no element at all');
end

if nargin < 2
    val = me.list_{end};
else
    val = me.list_{index};
end
end %F
