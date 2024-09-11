using Test
using OhMyPlots
using LaTeXStrings
using InteractiveUtils: @code_warntype


@testset "PlotDataXYLine" begin
    name = L"X"
    unit = L"[x]"
    value = sort(rand(20))
    xVar = Var(name, unit, value)
    @code_warntype Var(name, unit, value)

    name = L"Y"
    unit = L"[y]"
    value = rand(20)
    yVar = Var(name, unit, value)
    @code_warntype Var(name, unit, value)

    name = L"C_1"
    unit = L"[-]"
    legend = L"legend"
    value = 1
    cVar = CurveVar(name, unit, legend, value)
    @code_warntype CurveVar(name, unit, legend, value)

    plotData = PlotDataXYLine(xVar, yVar, cVar)
    @code_warntype PlotDataXYLine(xVar, yVar, cVar)
    @test plotData.XVar == xVar
end

@testset "PlotDataX2YLine" begin "TODO: complete for 2-axes y in the future"
    
end




