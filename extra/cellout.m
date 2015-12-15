function v = cellout(c)
% try to strip out a cell wrapper, to convert the cell into a array or vector.
% it will fail if not all the content in cells have the same type, 
% then return [].
%
% Useage:
%  v = cellout(c);
%    c, is a cell variable
%    v, is a array with the same size as c, or [] if can't to convert c
%
% Remark:
%  if c is cellstr, cellout will jion each row string with a extra '\n'
%
%  maintain: lymslive / 2015-12-15

if ~iscell(c)
    error('cellout expect a cell array');

elseif iscellstr(c)
    n = size(c, 1);
    row = cell(n, 1);
    for i = 1 : n
        row{i} = sprintf('%s\n', [c{i,:}]);
    end
    v = [row{:}];

else
    n = numel(c);
    for i = n :-1 : 1
        v(i) = c{i};
    end
    v = reshape(v, size(c));

end

end %F
