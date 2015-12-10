function me = push(me, index, val)
% push an element to the end of list or insert to the specific position.
% accpect at most tow extra input argumet.
% push only one element in each call.
%
% usage:
% * me.push(val); add to the end of list.
% * me.push(1, val); add to the front of list, 1st position of list.
% * me.push(i, val); insert to the ith position of list.
% * me.push(); repeat push the top element.
%
% requirement:
%   the index should be a scalar number between 1 and me.count + 1,
%   or the index will be cutted if to small or too large.
%   the val shoul not be empty.
%
% maintain: lymslive / 2015-12-09

switch nargin
case 1
    index = me.count + 1;
    val = me.top();

case 2
    index = me.count + 1;
    val = index;

case 3
    if ~isnumeric(index) || numel(index) ~= 1
        error('push@cLisst: the position expects a scalar number ');
    end
    if index < 1
        index = 1;
    end
    if index > me.count + 1
        index = me.count + 1;
    end

otherwise
    error('push@cList: to many input argumnet');
end %S

if isempty(val)
    error('push@cList: refuse to push emtpy element');
end

if me.isemptied()
    me.list_ = {val};
    return;
end

list = cell(me.count + 1, 1);

if index > 1
    list(1 : index-1) = me.list_(1 : index-1);
end

list(index) = {val};

if index <= me.count
    list(index+1 : end) = me.list(index : end);
end

me.list_ = list;

end %F
