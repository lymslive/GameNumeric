% display: display this object in command winodw
% default disp the inner table
%
% maintain: lymslive / 2015-12-08
function ST = display(me)

ST = false;
disp(me.tab_);
ST = true;

end%F
