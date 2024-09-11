using OhMyPlots
using Test
using Makie

begin "generate data functions"
    function fill_C(Name,range,plot_data)
        for i in range
            name = "X"
            unit = "[x]"
            value1 = sort(rand(20))
            xVar = Var(name, unit, value1)

            name = "Y"
            unit = "[y]"
            value2= rand(20)
            yVar = Var(name, unit, value2)

            name = Name
            unit = "["*Name*"_unit]"
            legend = Name*"_legend"
            value3 = Name*"_value"
            cVar = CurveVar(name, unit, legend, value3)

            plot_data[i] = PlotDataXYLine(xVar, yVar, cVar)
        end
    end

    function fill_plot_data!(plot_data,n_curve,n_each_curve)
        for i in 1:n_curve
            fill_C("C"*string(i),n_each_curve*(i-1)+1:n_each_curve*i,plot_data)
        end
        nothing
    end
end

# Test for plotting
@testset "Plot Testing n_curve = 4 - n_each_curve = 3" begin
    title = "n_curve = 4 - n_each_curve = 3"
    save_path = "test/plots_test/images/43"
    save_format = "svg"
    kwargs = Dict(
        :title => title,
        :save_path => save_path,
        :ylim => (0.0, 45.0),
        :legend_labelsize => 14,
        :legend_orientation => :vertical,
        :legend_nbanks => 2,
        :legend_position => :lt,
    )

    n_curve = 4
    n_each_curve = 3

    plot_data = Vector{PlotDataXYLine{String,Float64,Float64}}(undef, n_curve * n_each_curve)
    fill_plot_data!(plot_data,n_curve,n_each_curve)
    plotAttributes = PlotAttributsXYLine(plot_data,save_path, save_format;kwargs...);

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
    title = "n_curve = 3 - n_each_curve = 2"
    save_path = "test/plots_test/images/32"
    save_format = "svg"
    kwargs = Dict(
        :title => title,
        :save_path => save_path,
        :ylim => (0.0, 20.0),
        :legend_labelsize => 14,
        :legend_orientation => :vertical,
        :legend_nbanks => 2,
        :legend_position => :lt,
    )

    n_curve = 3
    n_each_curve = 2

    plot_data = Vector{PlotDataXYLine{String,Float64,Float64}}(undef, n_curve * n_each_curve)
    fill_plot_data!(plot_data,n_curve,n_each_curve)
    plotAttributes = PlotAttributsXYLine(plot_data,save_path, save_format;kwargs...);

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


















