% letter: Translate between number and letter for column indicator.
% see also excelStyle.
%
% letter call excelStyle(index) with only column names,
% but support a series list of column names or indices.
% excelStyle([1 2]) = 'B1'
% letter([1 2]) = {'A'; 'B'}
% letter([1 2 3]) = {'A'; 'B'; 'C'}
%
% maintain: lymslive / 2015-12-08
function out = letter(in)

if isnumeric(in)
    n = numel(in);
    out = cell(n, 1);
    for i = 1 : n
        out{i} = htable.excelStyle(in(i));
    end

elseif ischar(in) && size(in, 1) <= 1
    if ~isempty(regexp(in, '\d'))
        error('letter@htable: only support single colmun index');
    end
    if length(in) > 3
        error('letter@htable: a single colmun name has max length of 3');
    end
    out = htable.excelStyle(in);
    
elseif iscellstr(in)
    out = zeros(1, numel(in));
    for i = 1 : numel(in)
        out(i) = htable.letter(in{i});
    end

else
    error('letter@htable: wrong input argument, expect number or 3 letters or less');
end

end %F
