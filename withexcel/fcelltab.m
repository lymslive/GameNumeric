% T = fcelltab(C)
% convert cell array with (m+1)*n size to table with size m*n
% make the first row of cell as VariableNames of the table T.
%
% The first row of C should be valid variable names.
% 
% maintain: lymslive / 2015-12-07
function T = fcelltab(C)

T = cell2table(C(2:end, :));
T.Properties.VariableNames = C(1,:);

end %F
