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

# "With dots"
plot(f[1:100:end],α[1:100:end],lt=:scatter, ms=2.0, msw=0.0,legend=:false)

# Save figure, format inferred from filename
savefig(pl,"../3_figures/figure3.pdf")

# Gnuplot package: is a direct interface with gnuplot
using Gnuplot
p=rand(1000,136)
@gp "set pale @RAINBOW" :- 
@gp :- "set xrange[0:1000]; set yrange[0:136]; set cbrange[0:0.1]" :-
@gp :- p' " w image" 



cmd = "set pale @RAINBOW;
set logsca zcb;
set size 1.0,0.5;
set xrange[-0.5:85];
set yrange[0:1000];
set cbrange[1e-17:*];
set xlabel 'time [s]';
set ylabel 'Freq. [Hz]';
set ytics format '%g';
unset key;
df = 0.1;
dt = 10.0;
plot 'tfhm.dat' w u (\$1*dt+5):(df*\$2+0.05):3 image pixels"
# @gp :- tfhm "w image pixels"
write("../4_outputs/cmd.gpi",cmd)
writedlm("../4_outputs/tfhm.dat",tfhm," ")
run(`gnuplot -c ../4_outputs/cmd.gpi`)

function epslatex(name)
    # cd("../4_outputs/")
    junk = "temporary"
    jp = "/home/pclusella/TeX_Generator"
    save(term="epslatex standalone color rounded", output=junk*".tex")
    run(`pdflatex -synctex=1 -interaction=nonstopmode --shell-escape
    -output-directory $jp $junk.tex`)
    run(`cp $jp/$junk.pdf $name.pdf`)
    run(`rm -f $junk.tex`)
    run(`rm -f $junk-inc.eps`)
    run(`rm -f $junk-inc-eps-converted-to.pdf`)
    # cd("../0_codes/")
    return 0
end

epslatex("prova")


# Hidden arguments and tools fro GR heatmaps
#
using Plots.PlotMeasures
Plots.gr_cbar_width[]=0.01
Plots.gr_cbar_width[]=0.01
Plots.gr_colorbar_tick_size[]=0.001
Plots.gr_cbar_offsets[]=(0.005,0.02)
hm= Any[]
for subj in [8,10,11,12,13,15,16,18,20]
    p = heatmap(0.1:0.1:200,dp,log10.(tfhm_mean_pre[subj]./sum(tfhm_mean_pre[subj])),
    color=:rainbow1,xrange=(0.0,100.0),frame=:box,clim=(-6,-4.5), title="suj"*string(subj),
    rightmargin=2mm,label="suj"*string(subj),colorbar=true)
    # p = heatmap(0.1:0.1:200,dp,tfhm_mean_pre[subj],
    # color=:rainbow1,xrange=(0.0,100.0),frame=:box,colorbar_scale=:log10,
    # rightmargin=10mm)
    plot!(ylabel="Depth [μm]",xlabel="Freq. [Hz]")
    push!(hm,p)
end

plot(hm...,size=(1920,1080),bottommargin=10mm,leftmargin=10mm)

subj=8
p = heatmap(0.1:0.1:200,dp,tfhm_mean_pre[subj],
    color=:rainbow1,xrange=(0.0,100.0),frame=:box,
    rightmargin=10mm,colorbar_scale=:log10)
plot!(ylabel="Depth [μm]",xlabel="Freq. [Hz]")

# but sometimes it does not work. Also, there is supposed to be
# an option colorbar_formatter=:scientific, but it is not working in GR
#
#
# Gnuplot.options.verbose=false
@gp "
set term pngcairo enhanced size 200,300;" :-
p1 = @gp :- "plot sin(x) lc 3" ;

display(MIME("image/png"),p1)




# Heatmaps
using Plots.PlotMeasures
using Measures
Plots.gr_cbar_width[]=0.01
Plots.gr_cbar_width[]=0.01
Plots.gr_colorbar_tick_size[]=0.001
Plots.gr_cbar_offsets[]=(0.005,0.02)
hm= Any[]
for subj in [8,9,10,11,12,13,15,16,18,20]
    p = heatmap(0.1:0.1:200,dp,log10.(tfhm_mean_pre[subj]./sum(tfhm_mean_pre[subj])),
    color=:rainbow1,xrange=(0.0,100.0),frame=:box,clim=(-6,-4.5), title="suj"*string(subj),
    label="suj"*string(subj),colorbar=true)
    # p = heatmap(0.1:0.1:200,dp,tfhm_mean_pre[subj],
    # color=:rainbow1,xrange=(0.0,100.0),frame=:box,colorbar_scale=:log10,
    # rightmargin=10mm)
    plot!(ylabel="Depth [μm]",xlabel="Freq. [Hz]")
    push!(hm,p)
end

# plot(hm...,size=(1920,1080),layout=(2,5),bottommargin=10mm)
gr()
plot(hm...,size=(400*7,600*2),layout=(2,5),
bottommargin=15mm,topmargin=10mm,
leftmargin=1mm,rightmargin=1mm,
margin=0mm)


# makie
#
f = Figure(resolution=(1350,500));
Makie.scatter(f[1,1],rand(10))
Makie.scatter(f[2,1],rand(10),color=:blue)
Makie.scatter(f[1:2,2],rand(10),color=:red)
Makie.scatter(f[1:2,3],rand(10),color=:green)
f
