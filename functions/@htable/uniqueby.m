function tab = uniqueby(me, key, select)
% uniqueby@htable remove the repeated row indicated by the key column
% while the builtin unique lookup the whole row,
% this method noly lookup the key column
%
% tab = me.uniqueby(key, select)
%
% Input:
%   key; the index of column varible, can be variable name or number index
%   select; 'last' or 'first', the optional argument passed to builtin unique
%     default is 'last', that means retain the last one when repeated key.
% Output:
%   tab; another new table, not htable
%
% lymslive / 2015-12-17

if nargin < 3
    select = 'last';
end

[~,ia] = unique(me.tab_.(key), 'last', 'legacy');
tab = me.tab_(ia, :);

end %F main
