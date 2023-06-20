fg1,ax1,pl1 = lines(fp[:,5],fp[:,7],color=BifPal[ccond.(fp[:,2])],linewidth=3) # everything in one line

f = Figure(resolution=(1350,500));
Makie.scatter(f[1,1],rand(10))
Makie.scatter(f[2,1],rand(10),color=:blue)
Makie.scatter(f[1:2,2],rand(10),color=:red)
Makie.scatter(f[1:2,3],rand(10),color=:green)

# attributes can be easily changed:
#
axA.xlabel=L"I_e"
axA.ylabel=L"r_e"
axA.xlabelsize=25
axA.ylabelsize=25
axA.xlabelpadding=0
axA.xgridvisible=:false
axA.ygridvisible=:false
