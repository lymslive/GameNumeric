function index = of(me, val, cmpfun)
% find the index of val in my list, return 0 if not in my list.
% `of` means position of, or offset
%
% Input:
%   val, the element to find
%   cmpfun, default =, a function handle or name for compare eq
%
% Output:
%   index, the inner index of list, last(top) is count
%
% maintain: lymslive / 1025-12-13

index = 0;
for i = 1 : me.count
    try
        if nargin < 2
            if val == me.top(i)
                index = i;
                break;
            end

        else
            if feval(cmpfun, val, me.top(i))
                index = i;
                break;
            end
        end
    catch
        disp('of@cList: cannot compare element with the one in list');
        break;
    end
end

end %F main
