% plus: she = me + he
% concat two string
% me and she are string object, but he can also be char vector.
%
% maintain: lymslive / 2015-12-06
function she = plus(me, he)

if numel(me) > 1
    if ~isa(he, 'string')
        he = string(he);
    end
    if numel(he) == 1
        for i = numel(me) : -1 : 1
            she(i) = me(i).plus(he);
        end
        she = reshape(she, size(me));
    else
        if any(size(me) ~= size(he))
            error(me.msgid('plus'), ...
            'string me + he, should have the same size');
        end
        for i = numel(me) : -1 : 1
            she(i) = me(i).plus(he(i));
        end
        she = reshape(she, size(me));
    end
    return;
end

% for scalar me part:
if isa(he, 'string')
    longstr = [me.str_, he.str_];
else
    longstr = [me.str_, he];
end

she = string(longstr);
end %F
