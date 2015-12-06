% function me = setslice(index, varargin)
% set the string slice in objcet
%
% see also set.m
% me.set() can't change the string length
% me.setslice can change the string length
%
% @index requirement:
% [start, stop], or
% [start : stop]
% both means the substr between in start and stop.
% actually only use the index(1) and index(end).
% so don't use uncontinous index such as [1, 3, 5]
%
% @varargin values:
% replace the substring within index with another value.
% for scalar me, a single value:
% empty char vector ''
% scalar char vector
%
% for array we, multiply values:
% list of scalar char vector
% a cellstr
% the length of me and values don't need match, ommite the longer one
% and if input a value, replace all string in me
%
% if me is array object, varargin can provided multiply values
%
% maintain: lymslive / 2015-12-06
function me = setslice(me, index, varargin)

if isempty(index)
    error(me.msgid('setslice'), 'setslice expect a index');
end

nvar = length(varargin);
if nvar == 0
    value = '';
elseif nvar == 1
    value = varargin{1};
else
    value = varargin;
end

if numel(me) == 1
    me.str_ = slice_(me.str_, index, value);

else
    if iscell(value)
        for i = 1 : min(numel(me), length(value))
            me(i).str_ = slice_(me(i).str_, index, value{i});
        end
    else
        for i = 1 : numel(me)
            me(i).str_ = slice_(me(i).str_, index, value);
        end
    end
end %if me

end %F

%% sub function
% replace the `index` part of `str` with another `value`, and then
% return `newstr`.
function newstr = slice_(str, index, value)

if ~string.isscalar(value)
    error(me.msgid('setslice'), 'expect a scalar string');
end

start = index(1);
stop = index(end);
if stop < start
    error(me.msgid('setslice'), 'wrong slice index, expcet [star <= stop]');
end

if start <= 1
    head = '';
else
    head = str(1: start-1);
end

if stop >= length(str)
    tail = '';
else
    tail = str(stop+1 : end);
end

newstr = [head, value, tail];

end %F sub
