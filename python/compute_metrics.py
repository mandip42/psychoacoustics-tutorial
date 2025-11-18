import numpy as np
from scipy.signal import hilbert, butter, filtfilt, welch

def loudness_bs1770(sig, fs):
    # Placeholder: integrate pyloudnorm in your pipeline
    return float(np.sqrt(np.mean(sig**2)))

def sharpness_proxy(sig, fs):
    X = np.fft.rfft(sig)
    f = np.fft.rfftfreq(len(sig), 1/fs)
    mag = np.abs(X)
    return float((f*mag).sum()/(mag.sum()+1e-12)/1000.0)

def roughness_proxy(sig, fs):
    env = np.abs(hilbert(sig))
    b,a = butter(4, [15,300], fs=fs, btype='band')
    mod = filtfilt(b,a,env)
    return float(np.sqrt(np.mean(mod**2)))

def fluctuation_proxy(sig, fs):
    env = np.abs(hilbert(sig))
    b,a = butter(4, 20, fs=fs, btype='low')
    slow = filtfilt(b,a,env)
    return float(np.var(slow))

def tonality_proxy(sig, fs):
    f,pxx = welch(sig, fs, nperseg=4096)
    base = np.convolve(pxx, np.ones(41)/41, mode='same')
    return float((pxx/base).max())

def annoyance(loud, sharp, rough, fluct):
    return float(loud*(1 + 0.25*sharp + 0.2*rough + 0.15*fluct))

def compute_all(sig, fs):
    L = loudness_bs1770(sig, fs)
    S = sharpness_proxy(sig, fs)
    R = roughness_proxy(sig, fs)
    F = fluctuation_proxy(sig, fs)
    T = tonality_proxy(sig, fs)
    A = annoyance(L,S,R,F)
    return dict(Loudness=L, Sharpness=S, Roughness=R, Fluctuation=F, Tonality=T, Annoyance=A)
