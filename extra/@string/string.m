% string:
% a string object for char array or cellstr.
% char row vector --> string scalar object
% cellstr --> string object array with same shape size
% char rows --> string object column vector
%
% scalar_obj(): get char at pos or string slice, as use char vector
% array_obj{}: get the scalar object in pos, as use cellstr
%
% maintain: lymslive / 2015-12-6
classdef string

properties (Access = private)
str_;
end %P

properties (Dependent)
len;
end %P

methods
% constructor:
% string(): a empty string
% string(char): a scalar string object
% string(other): try convert argin to char
% string(cellstr): a string object array
% string(str1, str2, ...): each arg must be sacalar string
function me = string(varargin)

if nargin < 1
    me.str_ = '';

elseif nargin == 1
    arg = varargin{1};
    if ischar(arg)
        if size(arg, 1) == 1
            me.str_ = arg;
        else
            for i = size(arg, 1) : -1 : 1
                me(i).str_ = arg(i, :);
            end
        end
    elseif iscellstr(arg)
        for i = numel(arg) : -1 : 1
            me(i).str_ = arg{i};
        end
        me = reshape(me, size(arg));
    else
        try
            me.str_ = char(arg);
        catch
            error(me.msgid('ctor'), 'expect a char or cellstr');
        end
    end

else
    for i = nargin : -1 : 1
        arg = varargin{i};
        if ischar(arg) && size(arg, 1) == 1
            me(i).str_ = arg;
        else
            error(me.msgid('ctor'), 'expect a scalar string list');
        end
    end
end %if nargin
end %F ctor

function len = get.len(me)
len = length(me.str_);
end %F get

function me = set.str_(me, newstr)
if ischar(newstr) && size(newstr,1) <= 1
    me.str_ = newstr;
else
    error(me.msgid('set'), 'Expect a scalar char vector');
end
end %F
end %M

methods (Static)
tf = isscalar(arg);
str = msgid(subid);
end %M

end %C
