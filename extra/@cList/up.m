function me = up(me, index, quick)
% float up the element at index posision to the top of list.
% if provide optional `quick' as ture, only swap the element with top element.
% if ommit `index' input too, swap the most topest two element.
%
% Requirement:
%   the list should have at least two element.
%   index should be scalar number between 1 and me.count
%
% Algorithm:
%   me.up(i) has the same effect as me.push(me.pop(i)),
%   but the later change the list size tow times.
%
% maintain: lymslive / 2015-12-10

n = me.count;
if n < 2
    warning('up@cList: too few element, no need such operation');
    return;
end

if nargin < 2
    index = n - 1;
end

if numel(index) > 1 || index < 1 || index > n
    error('up@cList: expects a valid scalar index!');
end

if nargin < 3
    quick = false;
end

if index == n - 1 || quick
    [me.list_(n), me.list_(index)] = deal(me.list_(index), me.list_(n));
    return;
end

cnode = me.list_(index);
me.list_(index : n - 1) = me.list_(index + 1 : n);
me.list_(n) = cnode;

end %F
