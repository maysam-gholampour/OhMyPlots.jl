begin "using packages"

    using OhMyPlots
    using Test
    using Makie
    using LaTeXStrings
    using CairoMakie
end


begin "generate data functions"
    function fill_C(Name,range,plot_data)
        for i in range
            name = L"X"
            unit = L"[x]"
            value1 = sort(rand(20))
            xVar = Var(name, unit, value1)

            name = L"Y"
            unit = L"[y]"
            value2= rand(20)
            yVar = Var(name, unit, value2)

            legend = latexstring("$(Name)_$i")
            cVar = CurveVar(legend)

            plot_data[i] = PlotDataXYLine(xVar, yVar, cVar)
        end
    end

    function fill_plot_data!(plot_data,n_curve,n_each_curve)
        for i in 1:n_curve
            fill_C(L"C_%$(string(i))",n_each_curve*(i-1)+1:n_each_curve*i,plot_data)
        end
        nothing
    end
end

# Test for plotting
@testset "Plot Testing n_curve = 4 - n_each_curve = 3" begin
    title = L"n_{curve} = 4 - n_{each,curve} = 3"
    save_path = "_precompile/43"
    save_format = "svg"
    kwargs = Dict(
        :title => title,
        :save_path => save_path,
        :ylim => (0.0, 1.3),
    )

    n_curve = 4
    n_each_curve = 3

    plot_data = Vector{PlotDataXYLine{LaTeXString,Float64,Float64}}(undef, n_curve * n_each_curve)
    fill_plot_data!(plot_data,n_curve,n_each_curve)
    plotAttributes = PlotAttributsXYLine(plot_data,save_path, save_format,n_curve,n_each_curve;kwargs...);

    fig = XY(plotAttributes)

    # Check if figure has content
    @test length(fig.content) > 0

    # Check if figure contains an Axis
    @test any(x -> x isa Axis, fig.content)

    # Check if the Axis has lines in it
    ax = fig.content[1]
    @test length(ax.scene.plots) == n_curve * n_each_curve

    @test (@inferred XY(plotAttributes)) isa Makie.Figure

end


@testset "Plot Testing n_curve = 3 - n_each_curve = 2" begin
    title = L"n_{curve} = 3 - n_{each,curve} = 2"
    save_path = "_precompile/32"
    save_format = "svg"
    kwargs = Dict(
        :title => title,
        :save_path => save_path,
        :ylim => (0.0, 1.0),
    )

    n_curve = 3
    n_each_curve = 2

    plot_data = Vector{PlotDataXYLine{LaTeXString,Float64,Float64}}(undef, n_curve * n_each_curve)
    fill_plot_data!(plot_data,n_curve,n_each_curve)
    plotAttributes = PlotAttributsXYLine(plot_data,save_path, save_format,n_curve,n_each_curve;kwargs...);
    xY_Line_Scatter_Theme = XY_Line_Scatter_Theme()
    set_theme!(xY_Line_Scatter_Theme, size=(600,480))
    fig = XY(plotAttributes)
    leg = fig.content[2]
    delete!(leg)
    fig
    ax = fig.content[1]
    fig
    resize_to_layout!(fig)
    resize!(fig.scene, (700, 480))
    trim!(fig.layout)
    fig
    Legend(fig[1,2],ax;nbanks=1, labelsize=16,orientation = :vertical)
    fig
    

    xY_Line_Scatter_Theme = XY_Line_Scatter_Theme(markersize=20)    
    set_theme!(xY_Line_Scatter_Theme)
    fig = XY(plotAttributes)


    axislegend(;position=:cb, nbanks=2, labelsize=14,orientation = :horizontal)
    fig
    @test length(fig.content) == 3
    delete!(fig.content[2])
    @test length(fig.content) == 2
    fig

    fig.content[2].halign = :center
    fig.content[2].valign = :top
    fig
    # for i in 1:length(fig.content[1].scene.plots)
    #     fig.content[1].scene.plots[i].markersize = 13
    # end

    # Check if figure has content
    @test length(fig.content) > 0

    # Check if figure contains an Axis
    @test any(x -> x isa Axis, fig.content)

    # Check if the Axis has lines in it
    ax = fig.content[1]
    @test length(ax.scene.plots) == n_curve * n_each_curve

    @test (@inferred XY(plotAttributes)) isa Makie.Figure

end


#NOTE: DO NOT DELETE THIS COMMENT
#= begin "how to create plot with legend outside and then delete it and create legend inside starting with legend outside"

    # markersize = 12
    # markercolor= :white
    # strokewidth=2.0
    set_theme!(XY_Line_Scatter_Theme(size=(700,480),markersize=15)) 
    x = 1:0.1:10
    y = sin.(x)
    fig = Figure()
    ax = Axis(fig[1,1],
        xlabel=L"x", ylabel=L"f(x)")
    scatterlines!(ax, x, rand() * y, label = L"sin(x)\,\,\,\,\,sin(x)")
    scatterlines!(ax, x, rand() * y, label = L"sin(x)")
    scatterlines!(ax, x, rand() * y, label = L"sin(x)")
    scatterlines!(ax, x, rand() * y, label = L"sin(x)")
    Legend(fig[1,2],ax;nbanks=1, labelsize=16,orientation = :vertical)
    fig
    save("test.svg",fig)
    delete!(fig.content[2])
    fig
    resize_to_layout!(fig)
    resize!(fig.scene, (600, 480))
    trim!(fig.layout)
    fig
    axislegend(;position=:lt, nbanks=2, labelsize=14,orientation = :horizontal)
    fig

    # methodswith(Scene) #NOTE : to see all methods of Scene
end

begin "how to create plot with legend outside and then delete it and create legend inside starting with legend inside"
    set_theme!(XY_Line_Scatter_Theme()) 
    x = 1:0.1:10
    y = sin.(x)
    fig = Figure()
    ax = Axis(fig[1,1],
        xlabel=L"x", ylabel=L"f(x)")
    scatterlines!(ax, x, rand() * y, label = L"sin(x)\,\,\,\,\,sin(x)")
    scatterlines!(ax, x, rand() * y, label = L"sin(x)")
    scatterlines!(ax, x, rand() * y, label = L"sin(x)")
    scatterlines!(ax, x, rand() * y, label = L"sin(x)")
    scatterlines!(ax, x, rand() * y, label = L"sin(x)")
    axislegend()       
    fig
    save("test.svg",fig)
    delete!(fig.content[2])
    fig
    resize_to_layout!(fig)
    resize!(fig.scene, (700, 480))
    trim!(fig.layout)
    fig
    Legend(fig[1,2],ax;nbanks=1, labelsize=16,orientation = :vertical)
    fig
end =#