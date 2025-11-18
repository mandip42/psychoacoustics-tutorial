# Psychoacoustic Metrics for Automotive Sound Quality
*A Tutorial with Synthetic Case Studies and AI/ML Workflows*

[![DOI](https://zenodo.org/badge/DOI/10.xxxx/zenodo.xxxxxxx.svg)](https://doi.org/10.xxxx/zenodo.xxxxxxx)

## Overview
This repository accompanies the paper:
**“Psychoacoustic Metrics for Automotive Sound Quality: A Tutorial with Synthetic Case Studies and AI/ML Workflows.”**

It provides MATLAB and Python implementations of six psychoacoustic metrics, synthetic case study signals, and example workflows for ML.

## Features
- Loudness (Zwicker / BS.1770 proxy)
- Sharpness (spectral centroid–based proxy)
- Roughness (15–300 Hz modulation)
- Fluctuation Strength (<20 Hz modulation)
- Tonality (PSD peak prominence)
- Annoyance (composite index)

Additional:
- Synthetic case studies (engine boom, wind whistle, road noise)
- PCA visualization and classifier examples
- Figures reproducibility

## Repository Structure
```
├── matlab/
│   ├── compute_metrics.m
│   ├── case_studies.m
│   └── plot_figures.m
├── python/
│   ├── compute_metrics.py
│   ├── case_studies.py
│   └── plot_figures.py
├── data/
├── figures/
├── requirements.txt
├── CITATION.cff
├── LICENSE
├── README.md
└── zenodo.json
```

## Quickstart

### Python
```bash
python -m venv .venv && source .venv/bin/activate  # (or .venv\Scripts\activate on Windows)
pip install -r requirements.txt
python python/case_studies.py
python python/plot_figures.py
```

### MATLAB
Open `matlab/` and run:
```matlab
run('case_studies.m');
run('plot_figures.m');
```

## Citation
Please cite the accompanying paper (update once available):

```
@inproceedings{YourName2025Psychoacoustics,
  title={Psychoacoustic Metrics for Automotive Sound Quality: A Tutorial with Synthetic Case Studies and AI/ML Workflows},
  author={Your Name},
  booktitle={SAE Noise and Vibration Conference},
  year={2025},
  publisher={SAE International}
}
```

Zenodo DOI: 10.xxxx/zenodo.xxxxxxx (replace after Zenodo publish).

## License
MIT — see `LICENSE`.
