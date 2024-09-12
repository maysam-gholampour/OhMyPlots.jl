module OhMyPlots
    __precompile__(true)
    using PrecompileTools: @setup_workload, @compile_workload  

    using StaticArrays
    using CairoMakie
    using Makie
    using LaTeXStrings
    using UnPack: @unpack

    include("types_interfaces/_types.jl")
    include("plots/_plots.jl")
    include("Themes/_Themes.jl")

    @setup_workload begin
        @compile_workload begin
            include("_precompilation/_precompile.jl")
            _preconpile_XY()
        end
    end


end
