function hitor = iterator(me, direction)
% create an iterator for my list.
% provide optional direction = -1 to iterate backward, top to bottom,
% otherwise default to interate forward, bottom to top.
% return a function handle as list iterator,
% which return a element sequentially at each call, and when reach the end,
% return a empty element.
%
% Useage:
%   next = me.iterator();
%   val1 = next(); val2 = next();
%   while val = next(); do(some, thing); end
%
%   prev = me.iterator(-1);
%   valn = prev();
%
% maintain: lymslive / 2015-12-10

if me.isemptied()
    error('iterator@cList: can not create iterator on empty list');
end

n = me.count;

if nargin > 1 && direction == -1
    backward = true;
    i = n;
else
    backward = false;
    i = 1;
end

function val = next()
    if i > n
        val = [];
    else
        val = me.top(i);
        i = i + 1;
    end
end %F nest next

function val = prev()
    if i < 1
        val = [];
    else
        val = me.top(i);
        i = i - 1;
    end
end %F nest prev

if backward
    hitor = @prev;
else
    hitor = @next;
end

end %F
