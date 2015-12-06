% function me = set(me, index, value, varargin)
% set the string text in objcet
%
% for scalar me:
% 1) me.set(value): set the whole string (str_ field)
% 2) me.set(index, value): change substring, can't change string length
% 3) me.set([], value): same as me.st(value)
%
% for array we:
% 1) at most 2 extra inputs, set for each me as above
% 2) me.set(index, value1, value2, ...)
%    more value input, set each me with individual value at the same index,
%    the number of values no need to match the number of we.
%
% Attention:
% 1) value should be a scalar char vector,
% 2) the length of value should match index expcet index is empty or ommited,
% 3) use me = me.set(...) to change self as string isn't handle class
%
% maintain: lymslive / 2015-12-06
function me = set(me, index, value, varargin)

if numel(me) == 1
    if nargin < 2
        error(me.msgid('set'), 'Too few input argument');
    elseif nargin == 2
        value = index;
        me.str_ = value;
    elseif nargin == 3
        if isempty(index)
            me.str_ = value;
        else
            me.str_(index) = value;
        end
    end

else
    nme = numel(me);
    if nargin < 2
        error(me.msgid('set'), 'Too few input argument');
    elseif nargin == 2
        value = index;
        for i = 1 : nme
            me(i).str_ = value;
        end
    elseif nargin == 3
        for i = 1 : nme
            if isempty(index)
                me(i).str_ = value;
            else
                me(i).str_(index) = value;
            end
        end
    else
        value = [{value}, varargin];
        for i = 1 : min(nme, numel(value))
            if isempty(index)
                me(i).str_ = value{i};
            else
                me(i).str_(index) = value{i};
            end
        end
    end

end %if me

end %F
