export XY_Theme
export XY_Line_Scatter_Theme


linestyle_palette = @SVector[:solid,(:dot,:dense) ,:dash, :dashdot,:dashdotdot,(:dot,:loose)]
marker_palette = @SVector[:circle,:rect,:cross,:utriangle, :dtriangle,:xcross]
color_palette = @SVector[:red, :blue, :black,:green,:orange,:pink]
palette = (linestyle = linestyle_palette,marker = marker_palette,color = color_palette)
cycle = Cycle([:color, :linestyle, :marker], covary=true)
fonts = (;regular = Makie.assetpath("times.ttf"),
                bold_italic  = Makie.assetpath("timesbi.ttf"),
                bold= Makie.assetpath("timesbd.ttf"),
                italic = Makie.assetpath("timesi.ttf")
                )
size = (600, 480)
fonts = fonts
fontsize=20
font = :bold
axis=(
        xlabelsize=28,xlabelpadding=+5,
        ylabelsize=28,ylabelpadding=+5,
        xgridstyle=:dash, ygridstyle=:dash,
        xgridwidth = 1.5, ygridwidth = 1.5,
        xtickalign=1, ytickalign=1,
        yticksize=10, xticksize=10,
        markersize=16, markercolor= :white, strokewidth=2.0, 
        )
Legend = (framecolor=(:black, 0.5), backgroundcolor=(:white, 0.5),position=:lt, nbanks=2)
Colorbar = (ticksize=16, tickalign=1, spinewidth=0.5)
markersize = 8
markercolor= :white
strokewidth=2.0


function XY_Theme(;size=size, fonts=fonts, fontsize=fontsize, font=font, axis=axis, Legend=Legend, Colorbar=Colorbar,cycle= cycle,
     palette=palette, markersize=markersize, markercolor=markercolor, strokewidth=strokewidth)
    Theme(
    size = size,
    fonts = fonts,
    fontsize=fontsize, 
    font = font,
    Axis=axis,
    Legend = Legend,
    Colorbar = Colorbar,
    Lines=(cycle=cycle,),
    Scatter=(cycle=cycle,),
    ScatterLines=(cycle=cycle,),
    palette = palette
    )
end

function XY_Line_Scatter_Theme(;size=size, fonts=fonts, fontsize=fontsize, font=font, axis=axis, Legend=Legend, Colorbar=Colorbar,cycle= cycle, palette=palette,
     markersize=markersize, markercolor=markercolor, strokewidth=strokewidth)
    Theme(
        font = font,
        fonts = fonts,
        fontsize = fontsize,
        markersize = markersize,
        markercolor= markercolor,
        strokewidth=strokewidth,
        size = size,
        Axis=axis,
        Legend = Legend,
        Colorbar = Colorbar,
    )
end