% uminus: she = -me
% reverse the string
%
% maintain: lymslive / 2015-12-06
function she = uminus(me)

if numel(me) > 1
    for i = numel(me) : -1 : 1
        she(i) = me(i).uminus();
    end
    she = reshape(she, size(me));
    return;
end

she = string(me.str_(me.len : -1 : 1));
end %F
