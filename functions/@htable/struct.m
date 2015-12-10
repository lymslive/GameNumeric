% cell@htable: convert to struct array or a struct scalar
%
% option: ToScalar (default false)
% false: s is m*1 struct array, have n fields
% true:  s is sacalar struct, have n fields, each field have m rows
%
% suppose me is m*n table
%
% maintain: lymslive / 2015-12-09
function s = struct(me, ToScalar)

if nargin < 2
    ToScalar = false;
end

if ToScalar
    s = table2struct(me.tab_, 'ToScalar', true);
else
    s = table2struct(me.tab_);
end

end %F
