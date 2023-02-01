using DelimitedFiles

a=rand(3,3);
writedlm("out_"*ARGS[1]*"_"*ARGS[2]*".dat",a," ");

# run this from the terminal using:
# $ julia scripting.jl name1 name2


