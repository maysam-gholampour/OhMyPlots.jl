using OhMyPlots
using InteractiveUtils: @code_warntype


theme(:fonts)
fonts = (; regular = "asset/fonts/times.ttf",
            bold_italic  = "asset/fonts/timesbi.ttf",
            bold="asset/fonts/timesbd.ttf",
            italic = "asset/fonts/timesi")
set_theme!(
    size = (600, 480),
    fonts = fonts,
    fontsize=20, 
    font = :bold,
    Axis=(
        xlabelsize=32,xlabelpadding=-5,
        ylabelsize=32,ylabelpadding=-5,
        xgridstyle=:dash, ygridstyle=:dash,
        xgridwidth = 1.5, ygridwidth = 1.5,
        xtickalign=1, ytickalign=1,
        yticksize=10, xticksize=10,
    ),
    Legend = (framecolor=(:black, 0.5), backgroundcolor=(:white, 0.5),merge=true,),
    Colorbar = (ticksize=16, tickalign=1, spinewidth=0.5) 
)



begin "fig1"
    # https://juliadatascience.io/using-latexstrings.jl
    # https://beautiful.makie.org/dev/examples/2d/lines/line_latex#lines,-latex-fonts
    x = 0:0.05:4π
    fig = Figure() 
    ax = Axis(fig[1, 1], xlabel = L"x", ylabel = L"f (x)")

    lines!(x, x -> sin(3x) / (cos(x) + 2) / x; label = L"\frac{\sin(3x)}{x(\cos(x) + 2)}")
    lines!(x, x ->  cos(x) / x; label = L"\cos(x)/x")
    lines!(x, x ->  exp(-x); label = L"e^{-x}")
    axislegend(L"f(x)");
    trim!(fig.layout)
    save("gallery/images/first_figure.svg", fig)
    fig
end

begin "fig2"
    # https://juliadatascience.io/using-latexstrings.jl
    x = collect(0:10)
    cycle = Cycle([:color, :linestyle, :marker], covary=true)
    palette = (color = [:red, :blue, :black], linestyle = [:solid, :dash,:dot],marker =[:circle,:rect,:cross])
    fig = Figure(Lines=(cycle=cycle,), Scatter=(cycle=cycle,),palette = palette)
    ax = Axis(fig[1, 1], xlabel=L"x", ylabel=L"f(x,a)")
    for i in x
        lines!(ax, x, i .* x; label=L"%$i x")
        scatter!(ax, x, i .* x; markersize=13, strokewidth=0.25,
            label=L"%$i x")
    end
    axislegend(L"f(x)";  position=:lt, nbanks=2)
    text!(L"f(x,a) = ax", position=(4, 80))
    trim!(fig.layout)
    save("gallery/images/second_figure.svg", fig)
    fig
end

begin "fig3"
    # https://juliadatascience.io/using-latexstrings.jl
    # https://docs.makie.org/stable/explanations/theming/themes#cycles
    x = collect(1:9)
    cycle1 = Cycle([:color,:linestyle], covary=false)
    cycle2 = Cycle([:strokecolor ,:marker], covary=false)
    palette = (linestyle = [:solid, :dash,:dot],marker =[:circle,:rect,:cross],color = [:red, :blue, :black],strokecolor = [:red, :blue, :black])
    fig = Figure(Lines=(cycle=cycle1,), Scatter=(cycle=cycle2,),palette = palette)
    ax = Axis(fig[1, 1], xlabel=L"x", ylabel=L"f(x,a)")
    for i in x
        lines!(ax, x, i .* x; label=L"%$i x")
        scatter!(ax, x, i .* x; markersize=13, strokewidth=2.0,color = :transparent,
            label=L"%$i x")
    end
    axislegend(L"f(x)";  position=:lt, nbanks=2)
    text!(L"f(x,a) = ax", position=(4, 80))
    trim!(fig.layout)
    save("gallery/images/third_figure.svg", fig)
    fig
end

begin "fig4"
    # https://juliadatascience.io/using-latexstrings.jl
    # https://docs.makie.org/stable/explanations/theming/themes#cycles
    x = collect(1:9)
    cycle= Cycle([:strokecolor,:linestyle,:marker], covary=false)
    palette = (linestyle = [:solid, :dash,:dot],marker =[:circle,:rect,:cross],strokecolor = [:red, :blue, :black])
    fig = Figure(ScatterLines=(cycle=cycle,),palette = palette)
    ax = Axis(fig[1, 1], xlabel=L"x", ylabel=L"f(x,a)")
    for i in x
        scatterlines!(ax, x, i .* x; markersize=13, markercolor= :white, strokewidth=2.0,
            label=L"%$i x")
    end
    axislegend(L"f(x)";  position=:lt, nbanks=2)
    text!(L"f(x,a) = ax", position=(4, 80))
    trim!(fig.layout)
    save("gallery/images/forth_figure.svg", fig)
    fig
end