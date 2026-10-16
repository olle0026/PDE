function z = dccoeff(N, f)
% In data
% N: number of terms
% f: function
% Out data
% z: complex Fourier transform
    y = zeros(1,N);

    for i = 1:N
        temp = 2.*pi.*(i-1)./N;
        y(i) = f(temp);
    end

    z = mydft(y);
end