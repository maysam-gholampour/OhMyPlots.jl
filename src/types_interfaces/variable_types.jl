export VariableAbstract, Var, CurveVar


abstract type VariableAbstract end


struct Var{S<:AbstractString,T<:Union{AbstractFloat,Int, AbstractString}}<: VariableAbstract
    name::S
    unit::S
    value::Vector{T}
end

function Var(name::S, unit::S, value::T) where {T<:AbstractRange, S<:AbstractString}
    _value = collect(value)
    _eltype = eltype(value)
    Var{S,_eltype}(name, unit, _value)
end


struct CurveVar{S<:AbstractString} <: VariableAbstract
    name::S
    unit::S
    legend::S
    value::S
end

function CurveVar(name::S, unit::S, legend::S, value::T) where {T<:Real,S<:AbstractString}
    CurveVar{S}(name, unit, legend, L"%$(string(value))")
end