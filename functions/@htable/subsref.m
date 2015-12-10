% subsref: mainly redirect the subsref syntax to inner table
%
% usage:
% 1. me.name:
%    search methods(htable), methods(table), 
%    and last column variable in the table.
% 2. me(index):
%    translate to me_tab(index) if scalar me.
%    but for Nonscalar we, get scalar me first.
% 3. me{index}:
%    translate to me_tab(index) if scalar me.
%    error for Nonscalar we.
%
% maintain: lymslive / 2015-12-08
function varargout = subsref(me, index)

nme = numel(me);
lenidx = length(index);
varargout = cell(1, max(1, nargout));

switch index(1).type

case '.'
    if nme > 1
        error('subsref@htable, dot index to Nonscalar objcet is not allowed');
    end

    name = index(1).subs;
    % call htable's method
    if ismember(name, methods(me))
        [varargout{:}] = builtin('subsref', me, index);

    % call table's method, func(me.tab_, arg-list)
    elseif ismember(name, methods(table))
        if lenidx == 1
            args = {};
        elseif lenidx == 2 && strcmp(index(2).type, '()')
            args = index(2).subs;
        else
            error('subsref@htable, wrong called to table methed: %s', name);
        end
        [varargout{:}] = feval(name, me.tab_, args{:});

    % get column variable in table
    else
        try
            [varargout{:}] = me.col(name);
        catch
            error('subsref@htable: unknown name: %s', name);
        end
    end

case '()'
    if nme > 1
        subs = index(1).subs;
        subme = me(subs{:});
        if lenidx == 1
            varargout = {subme};
        else
            [varargout{:}] = subsref(subme, index(2 : end));
        end

    else
        index = s_extendIndex(index);
        [varargout{:}]= subsref(me.tab_, index);
    end %If nme

case '{}'
    if nme > 1
        error('subsref@htable: %s not cell but object array', inputname(1));
    end
    index = s_extendIndex(index);
    values = subsref(me.tab_, index);
    if nargout <= 1
        varargout{1} = values;
    else
        for i = 1 : min(nargout, size(values, 1))
            varargout{i} = values(i, :);
        end
    end

otherwise
    error(['subsref@htable, unexpected index type: ', index(1).type]);
end %S

end %F

%% sub-functions
% extend me(i) to me(i,:); me{i} to me{i, :}
function index = s_extendIndex(index)

subs = index(1).subs;
if length(subs) == 1
    subs{2} = ':';
    index(1).subs = subs;
end

end %F
