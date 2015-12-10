function tab = totable(var, varargin)
% convert other variable array to table, using
% array2table, struct2table or cell2table with the corresponding type.
% when cell2table, a smart judge to determine if treate the first row as
% columns' variableNames
%
% attention: the returned value is table, not htable
%
% maintain: lymslive / 2015-12-10

if isnumeric(var)
    tab = array2table(var, varargin{:});

elseif isstruct(var)
    tab = struct2table(var, varargin{:});

elseif iscell(var)
    if s_isheadingcell(var)
        tab = cell2table(var(2:end,:), varargin{:});
        tab.Properties.VariableNames = var(1,:);
    else
        tab = cell2table(var, varargin{:});
    end

elseif istable(var)
    warning('is already a table');
    tab = var;
elseif isa(var, 'htable')
    tab = var.table();
else
    error('can not convet to table');
end

end %F

%% sub function
% determine whether a cell is contained a heading row:
% the first row are all scalar string, and valid Matlab variable
% and the next row are not all string
function tf = s_isheadingcell(c)

[m, n] = size(c);
if m < 2
    tf = false;
else
    tf = true;
end

secondall = true;
for j = 1 : n
    first = c{1, j};
    if ~isvarname(first)
        tf = false;
        return;
    end

    if secondall
        second = c{2, j};
        if ~isvarname(second)
            secondall = false;
        end
    end
end

if secondall
    tf = false;
end

end %F
