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
    name = L"C_1"
    unit = L"[-]"
    legend = L"legend"
    value = 1
    var = CurveVar(name, unit, legend, value)
    @code_warntype CurveVar(name, unit, legend, value)
    @test var.value == L"%$(string(value))"

    value = 1.0
    var = CurveVar(name, unit, legend, value)
    @code_warntype CurveVar(name, unit, legend, value)
    @test var.value == L"%$(string(value))"

    value = L"C1"
    var = CurveVar(name, unit, legend, value)
    @code_warntype CurveVar(name, unit, legend, value)
    @test var.value == value
end

