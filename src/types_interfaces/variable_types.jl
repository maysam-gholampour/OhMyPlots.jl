export VariableAbstract, Var, CurveVar
export VarAbstract, CurveVarAbstract 


abstract type VariableAbstract end
abstract type VarAbstract<: VariableAbstract end 
abstract type CurveVarAbstract<: VariableAbstract end

_V1 = AbstractVector{T} where T<:Real
_V2 = AbstractVector{T} where T<:AbstractString
_V = Union{_V1, _V2}

struct Var{T1<:AbstractString, T2<:_V}<: VarAbstract
    name::T1
    unit::T1
    value::T2
end

_C = Union{Real, AbstractString}
struct CurveVar{T1<:AbstractString, T2<:_C}<: CurveVarAbstract
    name::T1
    unit::T1
    legend::T1
    value::T2
end