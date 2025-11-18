function case_studies
fs = 48000; dur = 2.0;
t = (0:fs*dur-1)/fs;

sig1 = 0.8*sin(2*pi*40*t) + 0.15*pink_noise(numel(t), fs);
sig2 = 0.5*sin(2*pi*5500*t) + 0.10*pink_noise(numel(t), fs);
raw  = pink_noise(numel(t), fs);
bl   = bandpass_filt(raw, fs, 100, 800, 4);
sig3 = bl .* (1 + 0.6*sin(2*pi*4*t));

disp(compute_metrics(sig1, fs));
disp(compute_metrics(sig2, fs));
disp(compute_metrics(sig3, fs));
end

function y = pink_noise(N, fs)
x = randn(1,N);
X = rfft(x);
f = (0:(numel(X)-1))*(fs/(2*(numel(X)-1))); if numel(f)>=2, f(1)=f(2); end
X = X ./ sqrt(f);
y = irfft(X, N);
y = y ./ (max(abs(y)) + 1e-12);
end

function y = bandpass_filt(x, fs, f1, f2, order)
if nargin < 5, order = 4; end
[b,a] = butter(order, [f1/(fs/2), f2/(fs/2)], 'bandpass');
y = filtfilt(b,a,x);
end

function X = rfft(x); X = fft(x); X = X(1:floor(numel(X)/2)+1); end
function x = irfft(X, Nfull)
if nargin < 2, Nfull = (numel(X)-1)*2; end
Xfull = [X, conj(X(end-1:-1:2))]; x = real(ifft(Xfull, Nfull));
end
