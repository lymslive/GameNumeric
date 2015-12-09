function t = type(me)
% type@cList: get the data type in the list, or empty char if mixed type
%
% maintain: lymslive / 2015-12-09

t = class(me.top(1));
for i = 2 : me.count
    if ~strcmp(t, class(me.top(i)))
        t = '';
        return;
    end
end

end %F
