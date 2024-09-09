export PlotAttributsAbstract, PlotAttributsXYLine


abstract type PlotAttributsAbstract end

_PA = AbstractVector{T} where T<:PlotDataAbstract

struct PlotAttributsXYLine{T1<:AbstractString, T2<:Integer, T3<:_PA}<: PlotAttributsAbstract
    title::T1
    save_path::T1
    save_format::T1
    is_scatter::T2
    data::T3
end