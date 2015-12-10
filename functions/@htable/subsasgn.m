% subsasgn: mainly redirect the subsasgn syntax to inner table
%
% maintain: lymslive / 2015-12-08
function me = subsasgn(me, index, value)

if numel(me) > 1
    error('subsasgn@htable: Only support sacalar object!');
end

stype = index(1).type;
subs = index(1).subs;

switch stype
case '.'
    me.tab_ = subsasgn(me.tab_, index, value);
    if ismember(subs, methods(htable)) || ismember(subs, methods(table))
        warning('subsasgn@htable: the column variable name conficts with table methods: %s', subs);
    end

case '()'
    me.tab_ = subsasgn(me.tab_, index, value);

case '{}'
    me.tab_ = subsasgn(me.tab_, index, value);

otherwise
    error(['subsasgn@htable, unexpected index type: ', stype]);
end %S

end %F
