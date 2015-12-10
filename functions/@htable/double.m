% double@htable: convert to numeric(mainly double) type
% collect all numeric columns as a matrix,
% and others as a cell matrix;
%
% output:
% d:  numeric matrix
% c:  cell matrix
% dn: column variable names put into d
% cn: column variable names put into c
%
% usually use ans = me.double() extract the valid double matrix
%
% maintain: lymslive / 2015-12-09
function [d, c, dn, cn] = double(me)

names = me.col('-names');
try
    d = table2array(me.tab_);
    c = {};
    dn = names;
    cn = {};
catch
    m = me.row();
    n = me.col();

    d = zeros(m, 0);
    c = cell(m, 0);
    isd = false(1, n);
    isc = false(1, n);

    for i = 1 : n
        var = me.tab_.(i);
        if isnumeric(var)
            d = [d, var];
            isd(i) = true;
        elseif iscell(var)
            c = [c, var];
            isc(i) = true;
        else
            cvar = cell(m, 1);
            for j = 1 : m
                cvar{j} = var(j);
            end
            c = [c, cvar];
            isc(i) = true;
        end
    end

    dn = names(isd);
    cn = names(idc);

end

end %F
