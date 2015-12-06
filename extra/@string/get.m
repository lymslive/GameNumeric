% function varargout = get(me, index)
% get string or substring from object, return a char vector
%
% if me is objcetor array
% then return cellstr or unpacked string list
%
% if no outpunt argument receive result, then display them.
%
% maintain: lymslive / 2015-12-06
function varargout = get(me, index)

if numel(me) == 1
    if nargin < 2 || isempty(index)
        out = me.str_;
    else
        out = me.str_(index);
    end

    if nargout == 0
        disp(out);
    elseif nargout == 1
        varargout = {out};
    else
        error(me.msgid('get'), 'Too many argout');
    end

else
    out = cell(1, max(numel(me), nargout));
    if nargin < 2
        index = [];
    end
    for i = 1 : numel(me)
        out{i} = me(i).get(index);
    end

    if nargout == 0
        for i = 1 : numel(out)
            disp(out{i});
        end
    elseif nargout == 1
        varargout{1} = reshape(out, size(me));
    else
        varargout = out;
    end
end

end %F
