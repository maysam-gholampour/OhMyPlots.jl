export PlotAttributsAbstract, PlotAttributsXYLine


abstract type PlotAttributsAbstract end

struct PlotAttributsXYLine{T1<:AbstractString, T2<:PlotDataAbstract} <: PlotAttributsAbstract
    title::T1
    save_path::T1
    save_format::T1
    Data::T2
end