function she = plus(me, he)
% plus@htable she = me + he 
%
% union the column, with stable order
% add the column for the same column variable
%
% me must be htable, but he can also be ordinary table
%
% return another new htable, so as to add continous a+b+c+..

if istable(he)
    he = htable(he);
end

mycol = me.col('-names');
hiscol = he.col('-names');
fields = union(mycol, hiscol, 'stable');

tab = array2table(zeros(me.row(), numel(fields)), 'VariableNames', fields);

for i = 1 : numel(fields)
    var = fields{i};
    if ismember(var, mycol) && ismember(var, hiscol)
        tab.(var) = me.col(var) + he.col(var);
    elseif ismember(var, mycol)
        tab.(var) = me.col(var);
    else
        tab.(var) = he.col(var);
    end
end

she = htable(tab);

end %F main
