% function me = subsasgn(me, index, varargin)
% customize the () and {} subsref, but dot ref unchanged
%
% scalar_obj(): set char at pos or string slice, as use char vector
% array_obj{}: set the scalar object in pos, as use cellstr
%
% see asle: me.set(), me.setslice()
%
% maintain: lymslive / 2015-12-6
function me = subsasgn(me, index, varargin)

switch index(1).type
case '.'
    error(me.msgid('subsasgn'), 'string has no fields to assignment');

case '()'
    subs = index(1).subs;
    if length(subs) > 1
        error(me.msgid('subsasgn'), 'string is only row vector');
    end
    if numel(me) == 1
        if isempty(subs)
            me = me.set(varargin{1});
        else
            me = me.setslice(subs{:}, varargin{1});
        end
    else
        if isempty(subs)
            me = me.set([], varargin{:});
        else
            me = me.setslice(subs{:}, varargin{:});
        end
    end

case '{}'
    if numel(me) <= 1
        error(me.msgid('subasgn'), '{} can only index string object array');
    end
    subs = index(1).subs;
    if length(index) == 1
        value = varargin{1};
        if ~isa(value, 'string')
            value = string(value);
        end
        me(subs{:}) = value;

    else
        subme = subsasgn(me(subs{:}), index(2:end), varargin{:});
        me(subs{:}) = subme;
    end

otherwise
    error(['??? Unexpected index.type of ', index(1).type]);
end %S

end %F
