using Plots, Multitaper, FFTW

N     = 1024
NW    = 4.0 
K     = 8
v,lam = Multitaper.dpss_tapers(N, NW, K, :both)

plot(-512:511, v, label = lam', xlabel = "Index", title = "DPSS's sorted by concentration")


# -------------------------------------------------------------------------
fn        = dirname(dirname(pathof(Multitaper)))*"/Examples/data/Willamette.dat"
riverdata = readdlm(fn,skipstart=8)[:,1]

plot(1950.0 .+ 10.0/12 .+ (0.0:(length(riverdata)-1))/12.0, riverdata, 
    label = "Willamette River data", xlabel = "Year", ylabel = "Log flow")

NW  = 4.0
K   = 5
pad = 2.0
S   = multispec(riverdata, dt = 1/12.0, NW = NW, K = K, jk = true, Ftest = true, guts = true, a_weight=true,
        pad = pad)

p = plot(S, legend = :top, label = "Multitaper Spectrum")

q = plot(S.f, S.Fpval, label = "F-test p-value")

# Find the peaks in the F-test above 99% and 99.9% significance
Pks99 = findall(S.Fpval .< 0.01)
q = scatter!(S.f[Pks99], S.Fpval[Pks99], label="Lines significant at 99%")
Pks999 = findall(S.Fpval .< 0.001)
q = scatter!(S.f[Pks999], S.Fpval[Pks999], label="Lines significant at 99.9%")

# Show both plots together
plot(q, p, layout=(2,1), legend = :topright)