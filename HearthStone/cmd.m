C = ones(11, 2);
for i = 1 : 11
    p = 0.5 + (i-1) * 0.01;
    C(i, 1) = p;
    C(i, 2) = avg5top_rec(p);
end
