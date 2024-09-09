export VariableAbstract, Var, CurveVar


abstract type VariableAbstract end

struct Var{T1<:AbstractString, T2<:Union{AbstractFloat,AbstractString}} <: VariableAbstract
    name::T1
    unit::T1
    value::T2
end

struct CurveVar{T1<:AbstractString, T2<:Union{AbstractFloat,AbstractString}} <: VariableAbstract
    name::T1
    unit::T1
    legend::T1
    value::T2
end