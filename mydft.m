function z = mydft(y)
% Compute the DFT of a vector y of length N
% z n = 1/N sum {j=0}ˆ{N-1}y j exp(-2 pi j n/N)
y = y(:);
N = length(y);
omega = exp(2*pi*1i/N);   % here i is the imaginary unit
j = (0:N-1)';             % MATLAB index k corresponds to j = k-1
z = zeros(N,1);
for n = 0:N-1
    % omega^(-n*j), exponent reduced mod N for accuracy
    z(n+1) = sum(y .* omega.^(-n*j)) / N;
end
end