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
        )

position=:lt
nbanks=3
labelsize=12
orientation=:horizontal

Colorbar = (ticksize=16, tickalign=1, spinewidth=0.5)
markersize = 8
markercolor= :white
strokewidth=2.0
leg_alignmode = Outside()

"""
XY_Theme(;size=size, fonts=fonts, fontsize=fontsize, font=font, axis=axis, Legend=Legend, Colorbar=Colorbar,cycle= cycle,
     palette=palette, markersize=markersize, markercolor=markercolor, strokewidth=strokewidth, position=position, nbanks=nbanks,labelsize=labelsize, orientation=orientation)

    Create a theme for XY plots

    # Arguments
    - size: Tuple{Int,Int} = (600, 480)
    - fonts: NamedTuple = (;regular = Makie.assetpath("times.ttf"),
                    bold_italic  = Makie.assetpath("timesbi.ttf"),
                    bold= Makie.assetpath("timesbd.ttf"),
                    italic = Makie.assetpath("timesi.ttf")
                    )
    - fontsize: Int = 20
    - font: Symbol = :bold
    - axis: NamedTuple = (
            xlabelsize=28,xlabelpadding=+5,
            ylabelsize=28,ylabelpadding=+5,
            xgridstyle=:dash, ygridstyle=:dash,
            xgridwidth = 1.5, ygridwidth = 1.5,
            xtickalign=1, ytickalign=1,
            yticksize=10, xticksize=10,
            markersize=16, markercolor= :white, strokewidth=2.0, 
            )
    - Legend: NamedTuple = (framecolor=(:black, 0.5), backgroundcolor=(:white, 0.5),
                position=:lt, nbanks=3,labelsize=12, orientation=:horizontal)
    - Colorbar: NamedTuple = (ticksize=16, tickalign=1, spinewidth=0.5)
    - cycle: Cycle = Cycle([:color, :linestyle, :marker], covary=true)
    - palette: NamedTuple = (linestyle = linestyle_palette,marker = marker_palette,color = color_palette)
    - markersize: Int = 8
    - markercolor: Symbol = :white
    - strokewidth: Float64 = 2.0
    - position: Symbol = :lt
    - nbanks: Int = 3
    - labelsize: Int = 12
    - orientation: Symbol = :horizontal

    linestyle_palette = (:solid,(:dot,:dense) ,:dash, :dashdot,:dashdotdot,(:dot,:loose))
    marker_palette = [:circle,:rect,:cross,:utriangle, :dtriangle,:xcross]
    color_palette = [:red, :blue, :black,:green,:orange,:pink]
"""
function XY_Theme(;size=size, fonts=fonts, fontsize=fontsize, font=font, axis=axis, Legend=Legend, Colorbar=Colorbar,cycle= cycle,
     palette=palette, markersize=markersize, markercolor=markercolor, strokewidth=strokewidth, position=position,
      nbanks=nbanks,labelsize=labelsize, orientation=orientation)
    Theme(
    size = size,
    fonts = fonts,
    fontsize=fontsize, 
    font = font,
    markersize = markersize,
    markercolor= markercolor,
    strokewidth=strokewidth,
    Axis=axis,
    Legend = (framecolor=(:black, 0.5), backgroundcolor=(:white, 0.5),
            position=position, nbanks=nbanks,labelsize=labelsize, orientation=orientation),#NOTE: This is the default legend theme
    Colorbar = Colorbar,
    Lines=(cycle=cycle,),
    Scatter=(cycle=cycle,),
    ScatterLines=(cycle=cycle,),
    palette = palette
    )
end



"""
XY_Line_Scatter_Theme(;size=size, fonts=fonts, fontsize=fontsize, font=font, axis=axis, Legend=Legend, Colorbar=Colorbar,cycle= cycle, palette=palette,
     markersize=markersize, markercolor=markercolor, strokewidth=strokewidth, position=position, nbanks=nbanks,labelsize=labelsize, orientation=orientation)

    Create a theme for XY plots with lines and scatter plots

    # Arguments
    - size: Tuple{Int,Int} = (600, 480)
    - fonts: NamedTuple = (;regular = Makie.assetpath("times.ttf"),
                    bold_italic  = Makie.assetpath("timesbi.ttf"),
                    bold= Makie.assetpath("timesbd.ttf"),
                    italic = Makie.assetpath("timesi.ttf")
                    )
    - fontsize: Int = 20
    - font: Symbol = :bold
    - axis: NamedTuple = (
            xlabelsize=28,xlabelpadding=+5,
            ylabelsize=28,ylabelpadding=+5,
            xgridstyle=:dash, ygridstyle=:dash,
            xgridwidth = 1.5, ygridwidth = 1.5,
            xtickalign=1, ytickalign=1,
            yticksize=10, xticksize=10,
            markersize=16, markercolor= :white, strokewidth=2.0, 
            )
    - Legend: NamedTuple = (framecolor=(:black, 0.5), backgroundcolor=(:white, 0.5),
                position=:lt, nbanks=3,labelsize=12, orientation=:horizontal)
    - Colorbar: NamedTuple = (ticksize=16, tickalign=1, spinewidth=0.5)
    - cycle: Cycle = Cycle([:color, :linestyle, :marker], covary=true)
    - palette: NamedTuple = (linestyle = linestyle_palette,marker = marker_palette,color = color_palette)
    - markersize: Int = 8
    - markercolor: Symbol = :white
    - strokewidth: Float64 = 2.0
    - position: Symbol = :lt
    - nbanks: Int = 3
    - labelsize: Int = 12
    - orientation: Symbol = :horizontal
"""
function XY_Line_Scatter_Theme(;size=size, fonts=fonts, fontsize=fontsize, font=font, axis=axis, Legend=Legend, Colorbar=Colorbar,cycle= cycle, palette=palette,
     markersize=markersize, markercolor=markercolor, strokewidth=strokewidth, position=position, nbanks=nbanks,labelsize=labelsize,
      orientation=orientation,leg_alignmode=leg_alignmode)
    Theme(
        font = font,
        fonts = fonts,
        fontsize = fontsize,
        markersize = markersize,
        markercolor= markercolor,
        strokewidth=strokewidth,
        size = size,
        Axis=axis,
        Legend = (framecolor=(:black, 0.5), backgroundcolor=(:white, 0.5),
            position=position, nbanks=nbanks,labelsize=labelsize, orientation=orientation,
            leg_alignmode = leg_alignmode),#NOTE: This is the default legend theme
        Colorbar = Colorbar,
    )
end

