function tf = empty(me)
% empty the list, that remove all element in it.
% if requrie output, return ture when operate success.
%
% maintain: lymslive / 2015-12-10

me.list_ = {};
if nargout > 0
    tf = true;
end

end %F
