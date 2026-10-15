function y = myidft(z)
% Compute the IDFT of a vector z of length N
% y_n = sum_{j=0}^{N-1} z_j exp(2 pi i j n/N)
z = z(:);
N = length(z);
omega = exp(2*pi*1i/N);
j = (0:N-1)';
y = zeros(N,1);
for n = 0:N-1
    y(n+1) = sum(z .* omega.^(n*j));
end
end