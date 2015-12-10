% row@htable: get or get some row(s)'s value in table
%
% useage, similar as col@htable:
% 1. m = me.row();
% 2. var = me.row(i); var = me.row(rowname);
% 3. vars = me.row([indices]); vars = me.row({rownames});
% 4. me = me.row(index, value); me = me.row(indices, varargin)
% 5. in the 3rd form, multiply argouts are also accpectable
% 6. use inner table{index}, require each col-var has the same type.
%
% maintain: lymslive / 2015-12-08
function varargout = row(me, varargin)

if numel(me) > 1
    error('col@htable can only called by scalar object!');
end

if nargin < 2
    varargin = {};
end

switch length(varargin)
case 0
    m = height(me.tab_);
    varargout = {m};

case 1
    index = varargin{1};
    if isempty(index)
        error('row@hable expects at least one index/name!');
    elseif ischar(index) && strcmpi(index, '-names')
        varargout = {me.tab_.Properties.RowNames};
        return;
    end

    var = me.tab_{index, :};
    if nargout <= 1
        varargout = {var};
    else
        varargout = cell(1, nargout);
        for i = 1 : min(length(varargout), size(var, 2))
            varargout{i} = var(:,i);
        end
    end

otherwise
    index = varargin{1};
    value = varargin(2:end);
    if isempty(index)
        error('row@hable expects at least one index/name!');
    elseif isnumeric(index) || iscellstr(index)
        lenidx = length(index);
    else
        lenidx = 1;
    end

    if length(value) == 1
        if size(value{1}, 1) == 1
            me.tab_{index, :} = repmat(value{1}, lenidx, 1);
        elseif size(value{1}, 1) == lenidx
            me.tab_{index, :} = value{1};
        else
            error('col@htable: the assigned row height dismatch!')
        end
    else
        for i = 1 : min(lenidx, length(value))
            if iscell(index)
                me.tab_{index{i}, :} = value{i};
            else
                me.tab_{index(i), :} = value{i};
            end
        end
    end

    varargout = {me};
end %S

end %F
