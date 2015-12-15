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
% Seealso:
%  cell2mat dose nearly the same thing.
%  cellin, it may do the oposite thing as cellout
%
%  maintain: lymslive / 2015-12-15

if ~iscell(c)
    error('cellout expect a cell array');

elseif iscellstr(c)
    n = size(c, 1);
    if n > 1
        row = cell(n, 1);
        for i = 1 : n-1
            row{i} = sprintf('%s\n', [c{i,:}]);
        end
        row{n} = [c{n,:}];
        v = [row{:}];
    else
        v = [c{1, :}];
    end

else
    try
        v = cell2mat(c);
    catch
        disp('the cell has different datatype and cannot be cellout');
        v = [];
    end

end

end %F
