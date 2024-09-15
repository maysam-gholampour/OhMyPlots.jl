export VariableAbstract, Var, CurveVar


abstract type VariableAbstract end


"""
    struct Var{S<:AbstractString,T<:Union{AbstractFloat,Int, AbstractString}} <: VariableAbstract

The `Var` struct represents a variable with a name, unit, and a vector of values.

# Fields
- `name::S`: The name of the variable.
- `unit::S`: The unit of measurement for the variable.
- `value::Vector{T}`: A vector of values for the variable.

"""
struct Var{S<:AbstractString,T<:Union{AbstractFloat,Int, AbstractString}}<: VariableAbstract
    name::S
    unit::S
    value::Vector{T}
end

"""
    Var(name::S, unit::S, value::T) where {T<:AbstractRange, S<:AbstractString}

Constructs a `Var` object with the given `name`, `unit`, and `value`.

# Arguments
- `name::S`: The name of the variable.
- `unit::S`: The unit of measurement for the variable.
- `value::T`: The range of values for the variable.

# Returns
A `Var` object.

"""

function Var(name::S, unit::S, value::T) where {T<:AbstractRange, S<:AbstractString}
    _value = collect(value)
    _eltype = eltype(value)
    Var{S,_eltype}(name, unit, _value)
end


"""
    struct CurveVar{S<:AbstractString} <: VariableAbstract

Curve variable type representing a curve with a legend.

# Fields
- `legend::S`: The legend of the curve.

"""
struct CurveVar{S<:AbstractString} <: VariableAbstract
    legend::S
end
