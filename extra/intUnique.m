function [elements, counts] = intUnique(a)
% faset than unique use accumarray
%
% http://www.ilovematlab.cn/thread-1493-1-1.html
%  maintain: lymslive / 2015-12-13

a = a(:);

if sum((a)~=round(a))>0
	error('a must be int!');
end


offsetA = min(a)-1;
a = a-offsetA;
counts = accumarray(a, 1);

elements = find(counts);
counts = counts(elements);
elements = elements+offsetA;

end

