%% Task 1
clear; close all; clc;

y = [0,3,-2*sqrt(3),6,2*sqrt(3),3];

z = mydft(y);
w = myidft(y);

clprint(z,"z", 2)
clprint(w,"w", 2)

%% Task 2
clear; close all; clc;

% a
f = @(x) 3 - 2*cos(15*x) + 4*sin(20*x);

for N = [2^5, 2^8]
    z = dccoeff(N,f);
    [a0, a, b] = myfouriercoeff(z);

    fprintf('\nN = %d\n', N);
    fprintf('a0 = %.6f\n', a0);
    tol = 1e-6;
    ia = find(abs(a) > tol);
    ib = find(abs(b) > tol);
    for k = ia(:)', fprintf('a_%d = %.6f\n', k, a(k)); end
    for k = ib(:)', fprintf('b_%d = %.6f\n', k, b(k)); end
end

% b
clear;

g = @(x) abs(cos(x));

N = 2^10;
z = dccoeff(N,g);

[a0, a, ~] = myfouriercoeff(z);

nmax = 10;
a0exact = 2/pi;
aexact = zeros(1, nmax);
for n = 1:nmax/2
    aexact(2*n) = -4/pi * (-1)^n / (4*n^2 - 1);
end

figure()
stem([a0 a],'*')% plot computed Fourier cosine coefficients
hold on
stem([a0exact aexact],'or')% plot exact Fourier cosine coefficients
xlim([1 10])
hold off
xlabel('n'); ylabel('Fourier cosine coefficients a_n');
title('Exact and computed Fourier coefficients')
legend('Computed','Exact')

%% Task 3
clear; close all; clc;

% a
N = 2^10;
x = linspace(0,2*pi,N);
y = h(x);                       
z = mydft(y);
[a0, a, b] = myfouriercoeff(z); 

t = linspace(0, 2*pi, 10000);
Ms = [3 5 10];
S = zeros(length(Ms), length(t));

for m = 1:length(Ms)
    M = Ms(m);                  
    s = a0*ones(size(t));
    for k = 1:M
        s = s + a(k)*cos(k*t) + b(k)*sin(k*t);
    end
    S(m,:) = s;
end

figure();
plot(t, h(t), 'k', t, S(1,:), t, S(2,:), t, S(3,:));
xlabel('x'); ylabel('y'); grid on
legend('h(x)', 's_3(x)', 's_5(x)', 's_{10}(x)');
title('h(x) and partial Fourier sums (N = 2^{10})');

left = t > 0 & t < pi;
for m = 1:length(Ms)
    fprintf('Overshoot for M = %2d: %.4f\n', Ms(m), max(S(m,left)) - 1);
end

% b
t = linspace(0, pi, 10000);
t = t(2:end-1); % open interval                       
Mmax = 100;

n = 1:Mmax;
bex = 2./(pi*n) .* (1 - (-1).^n);

E_comp  = zeros(1, Mmax);
E_exact = zeros(1, Mmax);
s_comp  = a0*ones(size(t));
s_exact = zeros(size(t));
for M = 1:Mmax
    s_comp  = s_comp  + a(M)*cos(M*t) + b(M)*sin(M*t);
    s_exact = s_exact + bex(M)*sin(M*t);
    E_comp(M)  = max(s_comp  - 1);
    E_exact(M) = max(s_exact - 1);
end

figure();
plot(1:Mmax, E_comp, 'b-', 1:Mmax, E_exact, 'r--', 'LineWidth', 1.2); hold on
hold off; grid on
xlabel('M'); ylabel('E(M)');
legend('Computed coefficients (N = 2^{10})', 'Exact coefficients', ...
       'Location', 'southeast');
title('Maximum overshoot E(M) of s_M on 0<x<\pi');

for i = [3,5,10,100]
    fprintf('\nE(%d)  = %.4f (computed), %.4f (exact)',i, E_comp(i),  E_exact(i));
end
%% Task 4
%a
clear; close all; clc;

fid = fopen("filtre.data");
Y = fscanf(fid,'%f',[1 inf]);
fclose(fid);
figure(), plot(Y)
Z = fft(Y);
wcut = 1;
N = length(Z);
for j=1:N
    if (abs(Z(j)) <  wcut)
        Z(j) = 0;
    end
end
T = ifft(Z);
figure(), plot(T)

%% b

clear
load('handel');% load sound, e.g: 'splat','gong','handel','train'
sound(y,Fs); % play sound
Y = fft(y);% fft from Matlab
W=Y;
M=max(abs(Y));
wr = 0.25; % specify the relative threshold value
N = length(y);
for j=1:N
    if (abs(Y(j)) <  wr*max(abs(Y))) % compress
        W(j) = 0;
    end
end
% compressed signal and original signal expressed as a sparse array
WS = sparse(W);
YS = sparse(Y);

% compare size before-after
before = whos('YS');
after = whos('WS');
comprRatio = before.bytes/after.bytes

% play back the sound
pause(2);% delay in order to finish playing original sound
disp('Play compressed signal');
w= real(ifft(full(WS)));
sound(w, Fs)