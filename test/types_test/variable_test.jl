@testset "Var" begin
    name = "X"
    unit = "m"
    value = 1:100
    var = Var(name, unit, value)
    @test var.value == value

    value = 1.0:100
    var = Var(name, unit, value)
    @test var.value == value

    value = ["1", "2", "3"]
    var = Var(name, unit, value)
    @test var.value == value
end

@testset "CurveVar" begin
    name = "C1"
    unit = "[-]"
    legend = "legend"
    value = 1
    var = CurveVar(name, unit, legend, value)
    @test var.value == value

    value = 1.0
    var = CurveVar(name, unit, legend, value)
    @test var.value == value

    value = "C1"
    var = CurveVar(name, unit, legend, value)
    @test var.value == value
end

