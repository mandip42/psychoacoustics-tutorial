import numpy as np
from scipy.signal import butter, filtfilt
from compute_metrics import compute_all

def pink_noise(N, fs):
    x = np.random.randn(N)
    X = np.fft.rfft(x)
    f = np.fft.rfftfreq(N, 1/fs)
    f[0] = f[1]
    X = X/np.sqrt(f)
    y = np.fft.irfft(X, n=N)
    return y/np.max(np.abs(y)+1e-12)

def bandpass(x, fs, f1, f2, order=4):
    b,a = butter(order, [f1, f2], fs=fs, btype='band')
    return filtfilt(b,a,x)

def engine_boom(fs=48000, dur=2.0):
    t = np.arange(0,dur,1/fs)
    sig = 0.8*np.sin(2*np.pi*40*t) + 0.15*pink_noise(len(t), fs)
    return sig, fs

def wind_whistle(fs=48000, dur=2.0):
    t = np.arange(0,dur,1/fs)
    sig = 0.5*np.sin(2*np.pi*5500*t) + 0.1*pink_noise(len(t), fs)
    return sig, fs

def road_noise(fs=48000, dur=2.0):
    t = np.arange(0,dur,1/fs)
    raw = pink_noise(len(t), fs)
    bl  = bandpass(raw, fs, 100, 800)
    mod = (1 + 0.6*np.sin(2*np.pi*4*t))
    sig = bl*mod
    return sig/np.max(np.abs(sig)+1e-12), fs

if __name__ == "__main__":
    for name, gen in [("Engine Boom", engine_boom), ("Wind Whistle", wind_whistle), ("Road Noise", road_noise)]:
        sig, fs = gen()
        print(name, compute_all(sig, fs))
