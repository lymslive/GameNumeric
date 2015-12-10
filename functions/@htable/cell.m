% cell@htable: convert to cell matrix
%
% option:
% head: add column variable names to the top of cell matrix.
%
% maintain: lymslive / 2015-12-09
function c = cell(me, head)

c = table2cell(me.tab_);

if nargin > 1 && head
    c = [me.col('-names'); c];
end

end %F
