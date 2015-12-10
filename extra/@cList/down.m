function me = down(me, index, quick)
% fall down the element at index postion to the bottom of list, first place.
% if provide optional `quick' as ture, only swap the element with top element.
% if ommit `index' input too, swap the most topest two element.
%
% See also: up.m
% Requirement:
%   the list should have at least two element.
%   index should be scalar number between 1 and me.count
%
% maintain: lymslive / 2015-12-10

n = me.count;
if n < 2
    warning('down@cList: too few element, no need such operation');
    return;
end

if nargin < 2
    index = 2;
end

if numel(index) > 1 || index < 1 || index > n
    error('up@cList: expects a valid scalar index!');
end

if nargin < 3
    quick = false;
end

if index == 2 || quick
    [me.list_(1), me.list_(index)] = deal(me.list_(index), me.list_(1));
    return;
end

cnode = me.list_(index);
me.list_(2 : index) = me.list_(1 : index - 1);
me.list_(1) = cnode;

end %F
