using OhMyPlots
using Test
using LaTeXStrings
using InteractiveUtils: @code_warntype, @code_native,@code_llvm


@testset "plot attributes" begin

    function fill_plot_data!(plot_data)
        for i in 1:3
            name = L"X"
            unit = L"[x]"
            value1 = sort(rand(20))
            xVar = Var(name, unit, value1)

            name = L"Y"
            unit = L"[y]"
            value2= rand(20)
            yVar = Var(name, unit, value2)

            legend = L"C1\_legend"
            cVar = CurveVar(legend)

            plot_data[i] = PlotDataXYLine(xVar, yVar, cVar)
        end

        for i in 4:6
            name = L"X"
            unit = L"[x]"
            value4 = sort(rand(20))
            xVar = Var(name, unit, value4)

            name = L"Y"
            unit = L"[y]"
            value5 = rand(20)
            yVar = Var(name, unit, value5)

            legend = L"C2\_legend"
            cVar = CurveVar(legend)

            plot_data[i] = PlotDataXYLine(xVar, yVar, cVar)
        end
        nothing
    end


    # ================== PlotAttributesXYLine ==================
    title = L"title"
    n_curve = 2
    n_each_curve = 3
    plot_data = Vector{PlotDataXYLine{LaTeXString,Float64,Float64}}(undef, n_curve * n_each_curve)

    fill_plot_data!(plot_data)
    @code_warntype fill_plot_data!(plot_data)

    plotAttributes = PlotAttributsXYLine(data=plot_data, n_curve=n_curve, n_each_curve=n_each_curve)
    @code_native debuginfo=:none dump_module=false PlotAttributsXYLine(data=plot_data, n_curve=n_curve, n_each_curve=n_each_curve)
    @code_llvm PlotAttributsXYLine(data=plot_data, n_curve=n_curve, n_each_curve=n_each_curve)
    @code_warntype PlotAttributsXYLine(data=plot_data, n_curve=n_curve, n_each_curve=n_each_curve)


    plotAttributes = PlotAttributsXYLine(plot_data, n_curve, n_each_curve)
    @code_native debuginfo=:none dump_module=false PlotAttributsXYLine(plot_data, n_curve, n_each_curve)
    @code_llvm PlotAttributsXYLine(plot_data, n_curve, n_each_curve)
    @code_warntype PlotAttributsXYLine(plot_data, n_curve, n_each_curve)

    @test length(plotAttributes.data) == 6
    @test length(plotAttributes.data[1].XVar.value) == 20
    

    is_scatter = false
    plotAttributes_ = PlotAttributsXYLine(plot_data, n_curve, n_each_curve)
    @test length(plotAttributes_.data) == 6
    @test length(plotAttributes_.data[1].XVar.value) == 20
    

end


