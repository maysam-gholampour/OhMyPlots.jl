"""
    OhMyPlots

This module ]provides a set of tools to create beautiful plots using Makie.jl.
"""
module OhMyPlots
    __precompile__(false)
    using PrecompileTools: @setup_workload, @compile_workload  

    using StaticArrays
    using CairoMakie
    using Makie
    using Makie:texfont
    using LaTeXStrings
    using UnPack: @unpack

    include("types_interfaces/_types.jl")
    include("plots/_plots.jl")
    include("Themes/_Themes.jl")

    @setup_workload begin
        @compile_workload begin
            include("_precompilation/_precompile.jl")
            _precompile_XY()
        end
    end
end
