export PlotAttributsAbstract, PlotAttributsXYLine


abstract type PlotAttributsAbstract end


@kwdef struct PlotAttributsXYLine{S,T,P}<: PlotAttributsAbstract
    data::Vector{PlotDataXYLine{S,T,P}} 
    save_path::String
    save_format::String
    title::Union{LaTeXString,Nothing} = nothing
    is_scatter::Bool = true 
    fontsize::Int = 20 #DELME 
    ylim::Union{Nothing, Tuple{Float64,Float64}} = nothing
    xlim::Union{Nothing, Tuple{Float64,Float64}} = nothing
    legend_labelsize::Int = 20
    legend_orientation::Symbol = :vertical
    legend_nbanks::Int = 1
    legend_position::Symbol = :ct
    n_curve::Int
    n_each_curve::Int
end

function PlotAttributsXYLine(data::Vector{PlotDataXYLine{S,T,P}}, save_path::Q,
        save_format::Q, n_curve::Int,n_each_curve::Int; kwargs...) where {S,T,P,Q<:AbstractString}
    PlotAttributsXYLine{S,T,P}(data=data, save_path=save_path, save_format=save_format,n_curve=n_curve, n_each_curve = n_each_curve; kwargs...)
end

