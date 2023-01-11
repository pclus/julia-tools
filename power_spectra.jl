#------------------------------------------------
# Basic FFT with Julia
# Extended from https://stackoverflow.com/questions/56030394/how-to-visualize-fft-of-a-signal-in-julia
#------------------------------------------------
using FFTW

# Number of points 
N = 2^14 - 1; 
# Sample period
dt = 1 / (1.1 * N);
# Start time 
t0 = 0;
tmax = t0 + N * dt;
# time coordinate
t = t0:dt:tmax;
# signal 
signal = sin.(2π * 60 .* t); # sin (2π f t)

# Fourier Transform of it 
F = fft(signal) |> fftshift
freqs = fftfreq(length(t), 1.0/dt) |> fftshift

# plots 
time_domain = plot(t, signal, title = "Signal")
freq_domain = plot(freqs, abs2.(F), title = "Spectrum", xlim=(-100, +100)) 
plot(time_domain, freq_domain, layout = 2)
# savefig("Wave.pdf")

#------------------------------------------------
# Sampling problems
#------------------------------------------------
# compare the previous example with a shorter sequence:
n=2^12;
F2 = fft(signal[1:n]) |> fftshift
freqs2 = fftfreq(n, 1.0/dt) |> fftshift
plot(freqs, abs2.(F))
plot!(freqs2, abs2.(F2),xlim=(-100,100))


# compare with a different sampling rate:
dt = 1 / (10.1 * n) 
t = t0:dt:tmax
tmax = t0 + n * dt
signal = sin.(2π * 60 .* t) 
F3 = fft(signal) |> fftshift
freqs3 = fftfreq(length(t), 1.0/dt) |> fftshift
plot!(freqs3, abs2.(F3),xlim=(-100,100))

#------------------------------------------------
# Real FFT (easier, faster, and completely equivalent for real data)
#------------------------------------------------
Fr = rfft(signal); 
wr = rfftfreq(length(t), 1.0/dt); 
plot!(wr, abs2.(Fr),xlim=(0,100)) # Logscale with yaxis=:log



#------------------------------------------------
# Multitaper PSD
# See also the examples in the package documentation (they are in pathto(Multitaper) folder)
#------------------------------------------------
using Multitaper

# Same signal with noise, changed the sampling rate
N = 2^10 - 1 ;
dt = 1 / (2.1 * N) 
t0 = 0 
tmax = t0 + N * dt
t = t0:dt:tmax
signal = sin.(2π * 60 .* t);
signal =signal+5.0*(ones(length(signal))-rand(length(signal))); # play with the noise amplitude
plot(signal)

NW = 1.0*length(signal)*dt/(2.0) ;  #bandwith is W*dt/2.0, and NW = N*W*dt/2.0
K  = 5;    # number of tappers (should be less than 2*NW)
S  = multispec(signal, dt=dt, NW=NW, K=K,jk=true,Ftest=true, a_weight=true)
plot(S) # authomatic plot, the cross is a good reference to check K and NW

# comparison between multitaper and standard fft.
# Notice that multitaper package normalizes by dt/N, similar to what I am doing in C.
Fr = rfft(signal); 
wr = rfftfreq(length(t), 1.0/dt);
plot(S.f,S.S.*length(S.f)/dt)
plot!(wr,abs2.(Fr),lw=1.0)

# Plot including 95% confidence intervals, as in the authomatic version...
using StatsFuns
z=norminvcdf(0,1,0.975);
plot(S.f,S.S)
plot!(S.f,S.S.*exp.(-z*sqrt.(S.jkvar)),fillrange=S.S.*exp.(2*z*sqrt.(S.jkvar)),c=1,alpha=0.35)
plot!(yaxis=:log)
plot!(wr,abs2.(Fr)*dt/length(S.f),c=2,ylim=(1e-5,1))
