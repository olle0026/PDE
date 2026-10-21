function clprint(Y, name, decimals)
%Input
% Y = list
% name = name of list
% decimals = amount of decimals

N = length(Y);
fprintf("%s = [", name)
for i = 1:N
    fprintf("%g%+gi", round(real(Y(i)), decimals), round(imag(Y(i)), decimals))
    if i ~= N
        fprintf(", ")
    end
end
fprintf("]\n")