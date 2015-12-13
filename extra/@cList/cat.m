function v = cat(me)
% cat@cList: concatenate the list in a homogeneous row vector, or empty if fails.
%
% maintain: lymslive / 2015-12-09

try
    v = [me.list_{:}];
catch
    v = [];
end

end %F
