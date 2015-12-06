% function varargout = subsref(me, index)
% customize the () and {} subsref, but dot ref unchanged
%
% scalar_obj(): get char at pos or string slice, as use char vector
% array_obj{}: get the scalar object in pos, as use cellstr
%
% maintain: lymslive / 2015-12-6
function varargout = subsref(me, index)

switch index(1).type
case '.'
    if nargout == 0
        builtin('subsref', me, index);
    else
        if isempty(me)
            varargout = cell(0);
        else
            varargout = cell(1, max(numel(me), nargout));
            [varargout{:}] = builtin('subsref', me, index);
        end
    end

case '()'
    subs = index(1).subs;
    if length(subs) > 1
        error(me.msgid('subsref'), 'string is only row vector');
    end
    varargout = cell(1, max(numel(me), nargout));
    if numel(me) == 1
        if isempty(subs)
            substr = me.str_;
        else
            substr = me.str_(subs{:});
        end
        if length(index) == 1
            varargout{1} = substr;
        else
            [varargout{:}] = subsref(substr, index(2:end));
        end
    else
        for i = 1 : numel(me)
            if isempty(subs)
                varargout{i} = me(i).str_;
            else
                varargout{i} = me(i).str_(subs{:});
            end
        end
        if length(index) > 1
            for i = 1 : length(varargout)
                if ~isempty(varargout{i})
                    varargout{i} = subsref(varargout{i}, index(2:end));
                end
            end
        end
        if nargout <= 1 && length(varargout) > 1
            varargout = {reshape(varargout, size(me))};
        end
    end

case '{}'
    if numel(me) <= 1
        error(me.msgid('subsref'), '{} can only index string object array');
    end
    subs = index(1).subs;
    subme = me(subs{:});
    varargout = {subme};
    if length(index) > 1
        varargout{1} = subsref(subme, index(2:end));
    end

otherwise
    error(['??? Unexpected index.type of ', index(1).type]);
end %S

end %F
