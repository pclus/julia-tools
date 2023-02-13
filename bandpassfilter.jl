# From this answer: https://discourse.julialang.org/t/filtfilt-in-dsp-jl-i-really-dont-get-it/10437/2

using DSP
myfilter = digitalfilter(Bandpass(0.1,0.15),Butterworth(2));
mydata = rand(100);
filtfilt(myfilter,mydata)
