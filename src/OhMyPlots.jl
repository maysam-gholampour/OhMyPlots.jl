module OhMyPlots
    using Reexport: @reexport

    @reexport using StaticArrays
    @reexport using CairoMakie
    @reexport using Makie
    @reexport using LaTeXStrings
    @reexport using UnPack: @unpack

    Makie.set_theme!(fonts = (; regular = "asset/fonts/times.ttf",
                            bold_italic  = "asset/fonts/timesbi.ttf",
                            bold="asset/fonts/timesbd.ttf",
                            italic = "asset/fonts/timesi"))

    

    include("types_interfaces/_types.jl")
    include("plots/_plots.jl")

end
