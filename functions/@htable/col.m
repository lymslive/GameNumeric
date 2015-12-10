% col@htable: get or set some column(s)'s in table
%
% useage:
% 0. names = me.col('-names'); get the column VariableNames
% 1. n = me.col(); get the count of columns, same as width
% 2. var = me.col(i); get the ith column
%    var = me.col(name); get the column with name
% 3. vars = me.col([indices vector])
%    vars = me.col({cellstr of names})
%    get multiply columns by int indices or string names,
%    return numeric matrix, or cell matrix, but can't mix type var.
% 4. me = me.col(index, value); or me = me.col(index, value-of-varargin)
%    replace the column or columns with value or each values,
%    value must have the same columns as specified by index, and
%    each value must have the same length(height) and type as the origin table.
%    However, one value can also be set to multiply indexed columns;
% 5. [varargout] = me.col(...); 
%    if multiply out arguments in the 3rd form, return each column
%    respectively, and ignor the longer end.
% 6. in the 2nd and 3rd form, the return var(s) in only value, 
%    not table type any more. That is call table{index}, not talbe(index).
% 7. the column name can be excel-style as 'A', 'B' ...
%    if fails to find the column name literally.
%    excel-style 'AB' can only use for get, but not for set.
%    call me.col('AB', val) will add a column named 'AB', not add 28th column.
%
% maintain: lymslive / 2015-12-08
function varargout = col(me, varargin)

if numel(me) > 1
    error('col@htable can only called by scalar object!');
end

if nargin < 2
    varargin = {};
end

switch length(varargin)
case 0
    n = width(me.tab_);
    varargout = {n};

case 1
    index = varargin{1};
    if isempty(index)
        error('col@hable expects at least one index/name!');
    elseif ischar(index) && strcmpi(index, '-names')
        varargout = {me.tab_.Properties.VariableNames};
        return;
    end

    index = s_uniform(me, index);
    var = me.tab_{:, index};
    if nargout <= 1
        varargout = {var};
    else
        varargout = cell(1, nargout);
        for i = 1 : min(length(varargout), size(var, 2))
            varargout{i} = var(:,i);
        end
    end

% case 2
otherwise
    index = varargin{1};
    value = varargin(2:end);
    if isempty(index)
        error('col@hable expects at least one index/name!');
    elseif isnumeric(index) || iscellstr(index)
        lenidx = length(index);
    else
        lenidx = 1;
    end

    if length(value) == 1
        if size(value{1}, 2) == lenidx
            me.tab_{:, index} = value{1};
        elseif size(value{1}, 2) == 1
            me.tab_{:, index} = repmat(value{1}, 1, lenidx);
        else
            error('col@htable: the assigned column width dismatch!')
        end
    else
        for i = 1 : min(lenidx, length(value))
            if iscell(index)
                me.tab_{:, index{i}} = value{i};
            else
                me.tab_{:, index(i)} = value{i};
            end
        end
    end
    varargout = {me};
end %S

end %F

%% sub function
% make the index in uniform type of number array,
% that covnert column name to column index,
% and if fails, try convert excel-letter to column index.
function uindex = s_uniform(me, index)

if isnumeric(index)
    uindex = index(:)';

elseif ischar(index) && size(index, 1) <= 1
    uindex = s_memberat(index, me.col('-names'));
    if uindex <= 0
        try
            uindex = htable.letter(index);
        catch
            error('col@htable: no such column name: %s', index);
        end
    end

elseif iscellstr(index)
    uindex = zeros(1, numel(index));
    for i = 1 : numel(index)
        uindex(i) = s_uniform(me, index{i});
    end

else
    error('col@htable: expects number or scalar string for column index');
end

end %F

% find the string element index at a cellstr list
% return 0 if fails
function rindex = s_memberat(index, list)

rindex = 0;
for i = 1 : numel(list)
    if strcmp(list{i}, index)
        rindex = index;
    end
end

end %F
