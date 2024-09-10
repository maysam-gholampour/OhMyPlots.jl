module OhMyPlots
    using Reexport: @reexport

    using StaticArrays
    using CairoMakie
    using Makie
    using LaTeXStrings
    using UnPack: @unpack

    # Makie.set_theme!(fonts = (; regular = "asset/fonts/times.ttf",
    #                         bold_italic  = "asset/fonts/timesbi.ttf",
    #                         bold="asset/fonts/timesbd.ttf",
    #                         italic = "asset/fonts/timesi"))

    

    include("types_interfaces/_types.jl")
    include("plots/_plots.jl")

end
