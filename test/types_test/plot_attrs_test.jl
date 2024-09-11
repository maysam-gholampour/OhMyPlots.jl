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

            name = L"C\_1"
            unit = L"[C1\_unit]"
            legend = L"C1\_legend"
            value3 = L"C_1,\_value"
            cVar = CurveVar(name, unit, legend, value3)

            plot_data[i] = PlotDataXYLine(xVar, yVar, cVar)
        end

        for i in 4:5
            name = L"X"
            unit = L"[x]"
            value4 = sort(rand(20))
            xVar = Var(name, unit, value4)

            name = L"Y"
            unit = L"[y]"
            value5 = rand(20)
            yVar = Var(name, unit, value5)

            name = L"C2"
            unit = L"[C2\_unit]"
            legend = L"C2\_legend"
            value = L"C2\_value"
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
    title = L"title"
    save_path = "save_path"
    save_format = "save_format"
    plot_data = Vector{PlotDataXYLine{LaTeXString,Float64,Float64}}(undef, 5)

    fill_plot_data!(plot_data)
    @code_warntype fill_plot_data!(plot_data)
  
    plotAttributes = PlotAttributsXYLine(data=plot_data, save_path=save_path, save_format=save_format)
    @code_native debuginfo=:none dump_module=false PlotAttributsXYLine(data=plot_data, save_path=save_path, save_format=save_format)
    @code_llvm PlotAttributsXYLine(data=plot_data, save_path=save_path, save_format=save_format)
    @code_warntype PlotAttributsXYLine(data=plot_data, save_path=save_path, save_format=save_format)

    plotAttributes = PlotAttributsXYLine(plot_data, save_path, save_format)
    @code_native debuginfo=:none dump_module=false PlotAttributsXYLine(plot_data, save_path, save_format)
    @code_llvm PlotAttributsXYLine(plot_data, save_path, save_format)
    @code_warntype PlotAttributsXYLine(plot_data, save_path, save_format)

    @test length(plotAttributes.data) == 5
    @test length(plotAttributes.data[1].XVar.value) == 20
    @test is_scatter_test(Val(plotAttributes.is_scatter)) == "scatter plot"

    is_scatter = false
    plotAttributes_ = PlotAttributsXYLine(plot_data, save_path, save_format;is_scatter= is_scatter)
    @test length(plotAttributes_.data) == 5
    @test length(plotAttributes_.data[1].XVar.value) == 20
    @test is_scatter_test(Val(plotAttributes_.is_scatter)) == "line plot"

end


