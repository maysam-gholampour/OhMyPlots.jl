using OhMyPlots
using Test
using InteractiveUtils: @code_warntype

@testset "plot attributes" begin

    function fill_plot_data!(plot_data)
        for i in 1:3
            name = "X"
            unit = "[x]"
            value1 = sort(rand(20))
            xVar = Var(name, unit, value1)

            name = "Y"
            unit = "[y]"
            value2= rand(20)
            yVar = Var(name, unit, value2)

            name = "C1"
            unit = "[C1_unit]"
            legend = "C1_legend"
            value3 = "C1_value"
            cVar = CurveVar(name, unit, legend, value3)

            plot_data[i] = PlotDataXYLine(xVar, yVar, cVar)
        end

        for i in 4:5
            name = "X"
            unit = "[x]"
            value4 = sort(rand(20))
            xVar = Var(name, unit, value4)

            name = "Y"
            unit = "[y]"
            value5 = rand(20)
            yVar = Var(name, unit, value5)

            name = "C2"
            unit = "[C2_unit]"
            legend = "C2_legend"
            value = "C2_value"
            cVar = CurveVar(name, unit, legend, value)

            plot_data[i] = PlotDataXYLine(xVar, yVar, cVar)
        end
        nothing
    end

    function is_scatter_test(::Val{true})
        "scatter plot"
    end

    function is_scatter_test(::Val{false})
        "line plot"
    end

    # ================== PlotAttributesXYLine ==================
    title = "title"
    save_path = "save_path"
    save_format = "save_format"
    is_scatter = true
    plot_data = Vector{PlotDataXYLine}(undef, 5)
    fill_plot_data!(plot_data)
    plotAttributes = PlotAttributsXYLine(title, save_path, save_format,is_scatter, plot_data)

    @test length(plotAttributes.data) == 5
    @test length(plotAttributes.data[1].XVar.value) == 20

    @test is_scatter_test(Val(plotAttributes.is_scatter)) == "scatter plot"

    is_scatter = false
    plotAttributes = PlotAttributsXYLine(title, save_path, save_format,is_scatter, plot_data)

    @test is_scatter_test(Val(plotAttributes.is_scatter)) == "line plot"

end


