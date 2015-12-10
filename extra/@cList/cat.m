function v = cat(me)
% cat@cList: concatenate the list in a homogeneous vector, or empty if fails.
%
% maintain: lymslive / 2015-12-09

v = me.top(1);
for i = me.count : -1 : 2
    try
        v(i,1) = me.top(i);
    catch
        v = [];
        return;
    end
end

end %F
