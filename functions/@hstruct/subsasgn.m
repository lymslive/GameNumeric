% subsasgn:
% 重载赋值索引，将点赋值转为内部 stin_ 赋值
%
% 点索引不支持对象数组，因为每个对象内部的 struct 可能完全不同
% 按 struct 机制，可直接为不存在的域赋值，新增域
% 如果为某个域赋值为 []，则删除域
%
% maintain: lymslive / 2015-12-04
function me = subsasgn(me, index, value)

switch index(1).type

case '.'
    if numel(me) > 1
        error('user:hstruct:subsref', ...
        'dot index only support scalar object');
    end

    name = index(1).subs;
    if strcmp(name, 'stin_')
        error('usr:hstrcut:subsref', 'Private property');
    elseif ismember(name, methods(class(me)))
        error('user:hstruct:subsref', ...
        'method called, not asignment');
    else
        if length(index) == 1
            if isempty(value)
                me.stin_ = rmfield(me.stin_, name);
            else
                % me.stin_ = subsasgn(me.stin_, index, value);
                me.stin_.(name) = value;
            end
        else
            % me.stin_ = subsasgn(me.stin_, index, value);
            me.stin_ = builtin('subsasgn', me.stin_, index, value);
            % me.stin_.(name) = value;
        end
    end

case '()'
    if length(index) == 1
        me = builtin('subasgn', me, index, value);
    else
        subme = me(index(1).subs{:});
        subme = subasgn(subme, index(2:end), value);
        me(index(1).subs{:}) = subme;
    end

case '{}'
    error('user:hstruct:subsref', ...
    'hstrcut objects, not a cell array');

otherwise
    error('user:hstruct:subsref', ...
    'Unexpected index.type of %s', index(1).type);

end %S

end %F
