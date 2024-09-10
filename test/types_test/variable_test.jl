using OhMyPlots
using Test
using InteractiveUtils: @code_warntype


@testset "Var" begin
    name = "X"
    unit = "m"
    value = 1:100
    var = Var(name, unit, value)
    @code_warntype Var(name, unit, value)
    @test var.value == value

    value = 1.0:100
    var = Var(name, unit, value)
    @test var.value == value

    value = ["1", "2", "3"]
    var = Var(name, unit, value)
    @code_warntype Var(name, unit, value)
    @test var.value == value
end

@testset "CurveVar" begin
    name = "C1"
    unit = "[-]"
    legend = "legend"
    value = 1
    var = CurveVar(name, unit, legend, value)
    @code_warntype CurveVar(name, unit, legend, value)
    @test var.value == string(value)

    value = 1.0
    var = CurveVar(name, unit, legend, value)
    @code_warntype CurveVar(name, unit, legend, value)
    @test var.value == string(value)

    value = "C1"
    var = CurveVar(name, unit, legend, value)
    @code_warntype CurveVar(name, unit, legend, value)
    @test var.value == value
end

