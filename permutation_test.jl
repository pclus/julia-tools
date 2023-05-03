function permutation_test(x,y,n)
    nx=length(x)
    ny=length(y)
    ntotal = binomial(nx+ny)
    n = min(ntotal,n)

    v = [ x ; y ]

    μx = mean(x);
    μy = mean(y);
    ν = μx-μy

    for i in 1:n
        v0 = shuffle(v)
        μa = mean(v0[1:nx])
        μb = mean(v0[(nx+1):end])
        ν0 = μa-μb
    end

end
