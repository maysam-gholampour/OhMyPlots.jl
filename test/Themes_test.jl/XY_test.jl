using OhMyPlots
using Test



function plot_without_theme()
    x = 0:0.25:10
    y = sin.(x)
    fig = Figure()
    ax = Axis(fig[1, 1], xlabel="x [m]", ylabel=L"\xi_{sol} [\frac{kg}{kg_{dry-air}}]")
    for i in 1:5
        scatterlines!(ax,x, y .*rand(); label=L"\xi_{sol}")
    end
    axislegend()
    fig
end

fig = plot_without_theme()

# set the theme 
xY_theme = XY_Theme()
set_theme!(xY_theme)
plot_without_theme()


# modify the attribute in the theme which is in sublayers
xY_theme.Axis.xlabelsize = 20
plot_without_theme()

# add attribute does not exist in the theme
xY_theme.Axis.yticksmirrored = true
plot_without_theme()
xY_theme

#  change legend position #FIXME this is not working
xY_theme.Legend.position = :ct
plot_without_theme()

xY_theme = XY_Theme(markersize=20)
set_theme!(xY_theme)
plot_without_theme()