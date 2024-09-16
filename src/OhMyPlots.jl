"""
    OhMyPlots

This module provides a set of tools to create beautiful plots using Makie.jl.
"""
module OhMyPlots
    __precompile__(true)
    using PrecompileTools: @setup_workload, @compile_workload  
    
    using Reexport: @reexport
    @reexport using StaticArrays
    @reexport using CairoMakie
    @reexport using Makie
    @reexport using LaTeXStrings
    @reexport using UnPack: @unpack

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
