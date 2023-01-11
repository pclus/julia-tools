# The documentation refers to this as "Multi-threading", see README

Threads.nthreads()

# number of threads, can be changed at runtime with JULIA_NUM_THREADS environment variable.
# i.e., run julia with:
# $ julia --threads 4

Threads.threadid()

# The magic @threads macro:

a = zeros(10);
Threads.@threads for i = 1:10
	a[i] = Threads.threadid()
end

# Keep track of processes with atomic addition:


state = Threads.Atomic{Int}(0);
a=zeros(1000);

# 
Threads.@threads for id=1:1000
    Threads.atomic_add!(state, 1)
    print("-->",state[]," out of 1000\n");
    flush(stdout);
    a[id]=rand();
end
