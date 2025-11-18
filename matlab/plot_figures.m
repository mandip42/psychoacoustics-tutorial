function plot_figures
fs = 48000; dur = 2.0; t = (0:fs*dur-1)/fs;
sig1 = 0.8*sin(2*pi*40*t) + 0.15*pn(numel(t), fs);
sig2 = 0.5*sin(2*pi*5500*t) + 0.10*pn(numel(t), fs);
raw  = pn(numel(t), fs); bl = bp(raw, fs, 100, 800, 4);
sig3 = bl .* (1 + 0.6*sin(2*pi*4*t));

plot_wave(sig1, fs, '5a Engine Boom – Waveform', 'fig5a_waveform.png');
plot_psd(sig1, fs, '5a Engine Boom – Spectrum', 'fig5a_spectrum.png');
plot_wave(sig2, fs, '5b Wind Whistle – Waveform', 'fig5b_waveform.png');
plot_psd(sig2, fs, '5b Wind Whistle – Spectrum', 'fig5b_spectrum.png');
plot_wave(sig3, fs, '5c Road Noise – Waveform', 'fig5c_waveform.png');
plot_psd(sig3, fs, '5c Road Noise – Spectrum', 'fig5c_spectrum.png');
end

function plot_wave(sig, fs, ttl, fname)
tt=(0:numel(sig)-1)/fs; figure('Position',[100 100 760 280],'Color','w');
plot(tt,sig,'LineWidth',1.0); xlabel('Time (s)'); ylabel('Amplitude');
title(ttl); grid on; exportgraphics(gcf,fname,'Resolution',200); close;
end

function plot_psd(sig, fs, ttl, fname)
[pxx,f]=pwelch(sig,4096,[],[],fs);
figure('Position',[100 100 760 280],'Color','w'); semilogy(f, pxx);
xlabel('Frequency (Hz)'); ylabel('PSD'); title(ttl); grid on;
exportgraphics(gcf,fname,'Resolution',200); close;
end

function y = pn(N, fs); x=randn(1,N); X=rfft(x);
f=(0:(numel(X)-1))*(fs/(2*(numel(X)-1))); if numel(f)>=2, f(1)=f(2); end
X=X./sqrt(f); y=irfft(X,N); y=y./(max(abs(y))+1e-12); end

function y = bp(x, fs, f1, f2, order)
if nargin<5, order=4; end; [b,a]=butter(order,[f1/(fs/2), f2/(fs/2)],'bandpass'); y=filtfilt(b,a,x);
end

function X=rfft(x); X=fft(x); X=X(1:floor(numel(X)/2)+1); end
function x=irfft(X,Nfull); if nargin<2, Nfull=(numel(X)-1)*2; end
Xfull=[X, conj(X(end-1:-1:2))]; x=real(ifft(Xfull,Nfull)); end
