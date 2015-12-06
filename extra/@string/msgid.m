% msgid: used for error or warning id
% prefix is 'user:string'
% and if provided a input subid, return 'user:strin:$subid'
%
% maintain: lymslive / 2012-12-06
function str = msgid(subid)
str = 'user:string';
if nargin > 0
    str = [str, ':', subid];
end
end %F
