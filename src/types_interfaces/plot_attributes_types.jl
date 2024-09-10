export PlotAttributsAbstract, PlotAttributsXYLine


abstract type PlotAttributsAbstract end


@kwdef struct PlotAttributsXYLine{S,T,P}<: PlotAttributsAbstract
    data::Vector{PlotDataXYLine{S,T,P}} 
    save_path::String
    save_format::String
    title::Union{String,Nothing} = nothing
    is_scatter::Bool = true 
    fontsize::Int = 20
    ylim::Union{Nothing, Tuple{Float64,Float64}} = nothing
    xlim::Union{Nothing, Tuple{Float64,Float64}} = nothing
    legend_labelsize::Int = 20
    legend_orientation::Symbol = :vertical
    legend_nbanks::Int = 1
    legend_position::Symbol = :ct
end

function PlotAttributsXYLine(data::Vector{PlotDataXYLine{S,T,P}}, save_path::Q,
        save_format::Q; kwargs...) where {S,T,P,Q<:AbstractString}
    PlotAttributsXYLine{S,T,P}(data=data, save_path=save_path, save_format=save_format; kwargs...)
end

