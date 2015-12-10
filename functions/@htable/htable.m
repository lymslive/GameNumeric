% htable: A encapsulated handle class for table
% use just as the builtin table, but pass argument by refence in function
% call.
%
% maintain: lymslive / 2015-12-08
classdef htable < handle

properties (Access = protected)
tab_;
end

methods

function me = htable(varargin)

if nargin == 0
    me.tab_ = table();
elseif nargin == 1
    arg = varargin{1};
    if istable(arg)
        me.tab_ = arg;
    elseif isa(arg, 'htable')
        me.tab_ = arg.table();
    else
        try
            me.tab_ = htable.totable(arg);
        catch
            error('htable: cannot construct object from the input argument');
        end
    end
else
    me.tab_ = table(varargin{:});
end

end %F-constructor

function val = table(me)
val = me.tab_;
end%F

end %M

methods (Static)
out = excelStyle(in, varargin);
out = letter(index);
tab = totable(var, varargin);
end %M

end %C
