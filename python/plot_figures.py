import numpy as np, matplotlib.pyplot as plt
from scipy.signal import welch
from case_studies import engine_boom, wind_whistle, road_noise

def savefig(path):
    plt.tight_layout(); plt.savefig(path, dpi=200, bbox_inches='tight'); plt.close()

def plot_waveform(sig, fs, title, path):
    t = np.arange(0,len(sig))/fs
    plt.figure(figsize=(7,2.5)); plt.plot(t, sig)
    plt.xlabel('Time (s)'); plt.ylabel('Amplitude'); plt.title(title); savefig(path)

def plot_spectrum(sig, fs, title, path):
    f,pxx = welch(sig, fs, nperseg=4096)
    plt.figure(figsize=(7,2.5)); plt.semilogy(f, pxx)
    plt.xlabel('Frequency (Hz)'); plt.ylabel('PSD'); plt.title(title); savefig(path)

if __name__ == "__main__":
    for name, gen, tag in [("Engine Boom", engine_boom, "5a"),("Wind Whistle", wind_whistle,"5b"),("Road Noise", road_noise,"5c")]:
        sig, fs = gen()
        plot_waveform(sig, fs, f"{tag} {name} – Waveform", f"fig{tag.lower()}_waveform.png")
        plot_spectrum(sig, fs, f"{tag} {name} – Spectrum", f"fig{tag.lower()}_spectrum.png")
    print("Saved waveform/spectrum figures.")
