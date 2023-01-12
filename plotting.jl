using Plots

# Filled regions
plot(f,mean_psd,ribbon=std_psd,c=1,fillalpha=0.25,xlim=(0,70))

# Heatmaps
heatmap(0.1:0.1:200,1:n,log.(psd_mean_tfhm))

# Complex layouts
l=@layout [a ; [b c]]
plot(p1,p2,p3,layout=l,size=(800,800))

# Ticks
plot(α[:,1],γ[:,1],xerr=α[:,2],yerr=γ[:,2], key=false,
 lt=:scatter,xlabel=l1,ylabel=l2,xticks=2e-16:4e-16:2e-15,yticks=5e-17:5e-17:2e-16)
