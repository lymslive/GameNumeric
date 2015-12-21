function index = weigthfall(pvector, rate)
% determine where a rand number will fall, given a probability vector.
% each element has the corresponding change to the value in the vector.
%
% Input:
%  pvector: a probability vector, no matter row or column vector,
%    but if any element larger then 1, it is treated as weight vector,
%    and whill normalize to probability vector.
%    The inputed pvector may sum less than 1,
%    but the converted one from weight vector must sum to 1.
%  rate: a float number between 0 and 1, 
%    if it is ommited, call rand() to generate one.
%
% Output:
%  index: the selected index.
%
% maintain: lymslive / 2015-12-21

if any(pvector > 1)
    pvector = pvector ./ sum(pvector);
end

if nargin < 2
    rate = rand();
end

index = find(rate <= cumsum(pvector));

if ~isempty(index)
    index = index(1);
end

end %F main
