using OhMyPlots
using Test
# using Makie
# using CairoMakie


function plot_without_theme()
    x = 0:0.001:10
    y = sin.(x)
    fig = Figure()
    ax = Axis(fig[1, 1], xlabel="x [m]", ylabel=L"\xi_{sol} [\frac{kg}{kg_{dry-air}}]")
    for i in 1:5
        scatterlines!(x, y .*rand(); label=L"\xi_{sol}")
    end
    axislegend(;)
    fig
end

plot_without_theme()

# set the theme 
set_theme!(XY_Theme)
plot_without_theme()

# modify the attribute in the theme which is  in top layer
set_theme!(XY_Theme; theme= 20)
plot_without_theme()

# modify the attribute in the theme which is in sublayers
XY_Theme.Axis.xlabelsize = 20
plot_without_theme()

# add attribute does not exist in the theme
XY_Theme.Axis.yticksmirrored = true
plot_without_theme()
XY_Theme

#  change legend position #FIXME this is not working
XY_Theme.Legend.position = :ct
plot_without_theme()
