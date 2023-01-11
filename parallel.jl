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
