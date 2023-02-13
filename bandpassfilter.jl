# From this answer: https://discourse.julialang.org/t/filtfilt-in-dsp-jl-i-really-dont-get-it/10437/2

using DSP
fs = 1000.0 # kHz (sampling rate) 
myfilter = digitalfilter(Bandpass(0.1,0.15; fs=2500.0),Butterworth(2));
mydata = rand(100);
filtfilt(myfilter,mydata)
