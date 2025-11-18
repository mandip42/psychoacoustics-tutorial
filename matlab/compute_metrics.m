function results = compute_metrics(sig, fs)
% Compute psychoacoustic proxies (tutorial-style)
env = abs(hilbert(sig));
[bp_b,bp_a] = butter(4,[15 300]/(fs/2),'bandpass');
mod_env = filtfilt(bp_b,bp_a,env);
[lp_b,lp_a] = butter(4,20/(fs/2),'low');
slow_env = filtfilt(lp_b,lp_a,env);
[pxx,f] = pwelch(sig,4096,[],[],fs);
baseline = movmedian(pxx,41);

Loud = rms(sig);
Sharp = spectralCentroid(sig, fs)/1000;
Rough = rms(mod_env);
Fluct = var(slow_env);
Tonality = max(pxx./baseline);
Annoy = Loud*(1 + 0.25*Sharp + 0.2*Rough + 0.15*Fluct);

results = struct('Loudness',Loud,'Sharpness',Sharp,'Roughness',Rough, ...
    'Fluctuation',Fluct,'Tonality',Tonality,'Annoyance',Annoy);
end

function sc = spectralCentroid(x, fs)
X = abs(fft(x));
X = X(1:floor(numel(X)/2)+1);
f = (0:(numel(X)-1))*(fs/(2*(numel(X)-1)));
wsum = sum(X) + 1e-12;
sc = sum(f .* X) / wsum;
end
