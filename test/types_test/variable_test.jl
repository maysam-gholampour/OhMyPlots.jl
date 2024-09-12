using OhMyPlots
using Test
using LaTeXStrings
using InteractiveUtils: @code_warntype


@testset "Var" begin
    name = L"X"
    unit = L"[m]"
    value = 1:100
    var = Var(name, unit, value)
    @code_warntype Var(name, unit, value)
    @test var.value == value

    value = 1.0:100
    var = Var(name, unit, value)
    @test var.value == value

    value = [L"1", L"2", L"3"]
    var = Var(name, unit, value)
    @code_warntype Var(name, unit, value)
    @test var.value == value
end

@testset "CurveVar" begin
    legend = L"legend"
    var = CurveVar(legend)
    @code_warntype CurveVar(legend)
    @test var.legend == L"legend"
end

