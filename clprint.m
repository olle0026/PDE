function clprint(Y, name, decimals)
%Input
% Y = list
% name = name of list
% decimals = amount of decimals

N = length(Y);
fprintf("%s = [", name)
for i = 1:N
    tempR = round(real(Y(i)), decimals);
    tempC = round(imag(Y(i)), decimals);

    if tempR ~= 0
        fprintf("%g", tempR)
    end
    
    if tempR ~= 0 && tempC > 0
        fprintf("+")
    end

    if tempC ~= 0
        fprintf("%gi", tempC)
    end

    if tempC == 0 && tempR == 0
        print("0")
    end

    if i ~= N
        fprintf(", ")
    end
end
fprintf("]\n")