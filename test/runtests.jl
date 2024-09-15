using OhMyPlots
using Test

@testset "OhMyPlots.jl" begin
    include("types_test/_types_tests.jl")
    include("plots_test/XY_test.jl")
end
