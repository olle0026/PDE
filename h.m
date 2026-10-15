function p = h(x)

n = length(x);
p = zeros(size(x));
for i = 1:n
    if (x(i)==0 || x(i)==pi || x(i)==2*pi)
        p(i) = 0;
    elseif x(i) > 0 && x(i) < pi
        p(i) = 1;
    elseif x(i) > pi && x(i) < 2*pi
        p(i) = -1;
    end
end
end