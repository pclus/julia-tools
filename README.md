# Julia tools

Short and easy to use julia code examples on different topics.

+ `power_spectra.jl` Demonstration on how to use the [`FFTW`](https://juliamath.github.io/FFTW.jl/stable/) and [`Multitaper`](https://docs.juliahub.com/Multitaper/OT9LO/0.2.0/) packages to compute the spectra of oscillatory signals. 
+ `parallel.jl` some toy examples on how to use multi-threading and, specially, the `@thread` macro. See the [official documentation](https://docs.julialang.org/en/v1/manual/multi-threading/) for more. 
+ `plotting.jl` different examples of plots and common tools to generate and decorate them.

## Support for vim

From this [documentation](https://github.com/JuliaEditorSupport/julia-vim/blob/master/INSTALL.md):

In `.vimrc` add a line `Plug 'JuliaEditorSupport/julia-vim'` and then run `:PlugInstall`.

## Run from terminal

You can use a julia script as an executable using, in the first line of your `example.jl`:

```
#!/usr/bin/env -S julia --threads 20

<some julia code ...>
```

## Empty environtments:

```julia
empty!(LOAD_PATH)
push!(LOAD_PATH, "@")
```
