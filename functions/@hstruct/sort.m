function perm = sort(me)
% sort the field names in ASCII dictionary order, call to orderfields(struct);
% perm output is optional, which means
% a permutation vector representing the change in order.
%
% seealse: orderfields
%
% maintain: lymslive / 2015-12-10

if nargout >= 1
    [me.stin_, perm] = orderfields(me.stin_);
else
    me.stin_ = orderfields(me.stin_);
end

end %F
