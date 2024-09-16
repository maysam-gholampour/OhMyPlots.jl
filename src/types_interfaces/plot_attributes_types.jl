export PlotAttributsAbstract, PlotAttributsXYLine


abstract type PlotAttributsAbstract end


"""
    struct PlotAttributsXYLine{S,T,P} <: PlotAttributsAbstract

    The `PlotAttributsXYLine` struct represents the attributes of an XY line plot.

    # Fields
    - `data::Vector{PlotDataXYLine{S,T,P}}`: Vector of XY line plot data.
    - `save_path::String`: Path to save the plot.
    - `save_format::String`: Format to save the plot.
    - `title::Union{LaTeXString,Nothing}`: Title of the plot (optional).
    - `is_scatter::Bool`: Flag indicating whether the plot is a scatter plot or not.
    - `ylim::Union{Nothing, Tuple{Float64,Float64}}`: Y-axis limits of the plot (optional).
    - `xlim::Union{Nothing, Tuple{Float64,Float64}}`: X-axis limits of the plot (optional).
    - `n_curve::Int`: Number of curves in the plot.
    - `n_each_curve::Int`: Number of data points in each curve.

"""
@kwdef struct PlotAttributsXYLine{S,T,P}<: PlotAttributsAbstract
    data::Vector{PlotDataXYLine{S,T,P}} 
    # save_path::String
    # save_format::String
    title::Union{LaTeXString,Nothing} = nothing
    # is_scatter::Bool = true 
    ylim::Union{Nothing, Tuple{Float64,Float64}} = nothing
    xlim::Union{Nothing, Tuple{Float64,Float64}} = nothing
    n_curve::Int
    n_each_curve::Int
end

"""
    PlotAttributsXYLine(data::Vector{PlotDataXYLine{S,T,P}}, save_path::Q, save_format::Q, n_curve::Int, n_each_curve::Int; kwargs...) where {S,T,P,Q<:AbstractString}

    Constructs a `PlotAttributsXYLine` object.

    # Arguments
    - `data::Vector{PlotDataXYLine{S,T,P}}`: The data for the plot.
    - `save_path::Q`: The path to save the plot.
    - `save_format::Q`: The format to save the plot.
    - `n_curve::Int`: The number of curves in the plot.
    - `n_each_curve::Int`: The number of points in each curve.
    - `kwargs...`: Additional keyword arguments.

    # Returns
    A `PlotAttributsXYLine{S,T,P}` object.

"""
function PlotAttributsXYLine(data::Vector{PlotDataXYLine{S,T,P}}, n_curve::Int,n_each_curve::Int; kwargs...) where {S,T,P}
    PlotAttributsXYLine{S,T,P}(data=data, n_curve=n_curve, n_each_curve = n_each_curve; kwargs...)
end

