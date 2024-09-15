var documenterSearchIndex = {"docs":
[{"location":"reference/","page":"Reference","title":"Reference","text":"CurrentModule = OhMyPlots","category":"page"},{"location":"reference/","page":"Reference","title":"Reference","text":"","category":"page"},{"location":"reference/","page":"Reference","title":"Reference","text":"Modules = [OhMyPlots]","category":"page"},{"location":"reference/#OhMyPlots.OhMyPlots","page":"Reference","title":"OhMyPlots.OhMyPlots","text":"OhMyPlots\n\nThis module provides a set of tools to create beautiful plots using Makie.jl.\n\n\n\n\n\n","category":"module"},{"location":"reference/#OhMyPlots.linestyle_palette","page":"Reference","title":"OhMyPlots.linestyle_palette","text":"pallete\n\n\n\n\n\n","category":"constant"},{"location":"reference/#OhMyPlots.CurveVar","page":"Reference","title":"OhMyPlots.CurveVar","text":"struct CurveVar{S<:AbstractString} <: VariableAbstract\n\nCurve variable type representing a curve with a legend.\n\nFields\n\nlegend::S: The legend of the curve.\n\n\n\n\n\n","category":"type"},{"location":"reference/#OhMyPlots.PlotAttributsXYLine","page":"Reference","title":"OhMyPlots.PlotAttributsXYLine","text":"struct PlotAttributsXYLine{S,T,P} <: PlotAttributsAbstract\n\nThe `PlotAttributsXYLine` struct represents the attributes of an XY line plot.\n\n# Fields\n- `data::Vector{PlotDataXYLine{S,T,P}}`: Vector of XY line plot data.\n- `save_path::String`: Path to save the plot.\n- `save_format::String`: Format to save the plot.\n- `title::Union{LaTeXString,Nothing}`: Title of the plot (optional).\n- `is_scatter::Bool`: Flag indicating whether the plot is a scatter plot or not.\n- `ylim::Union{Nothing, Tuple{Float64,Float64}}`: Y-axis limits of the plot (optional).\n- `xlim::Union{Nothing, Tuple{Float64,Float64}}`: X-axis limits of the plot (optional).\n- `n_curve::Int`: Number of curves in the plot.\n- `n_each_curve::Int`: Number of data points in each curve.\n\n\n\n\n\n","category":"type"},{"location":"reference/#OhMyPlots.PlotAttributsXYLine-Union{Tuple{Q}, Tuple{P}, Tuple{T}, Tuple{S}, Tuple{Array{PlotDataXYLine{S, T, P}, 1}, Q, Q, Int64, Int64}} where {S, T, P, Q<:AbstractString}","page":"Reference","title":"OhMyPlots.PlotAttributsXYLine","text":"PlotAttributsXYLine(data::Vector{PlotDataXYLine{S,T,P}}, save_path::Q, save_format::Q, n_curve::Int, n_each_curve::Int; kwargs...) where {S,T,P,Q<:AbstractString}\n\nConstructs a `PlotAttributsXYLine` object.\n\n# Arguments\n- `data::Vector{PlotDataXYLine{S,T,P}}`: The data for the plot.\n- `save_path::Q`: The path to save the plot.\n- `save_format::Q`: The format to save the plot.\n- `n_curve::Int`: The number of curves in the plot.\n- `n_each_curve::Int`: The number of points in each curve.\n- `kwargs...`: Additional keyword arguments.\n\n# Returns\nA `PlotAttributsXYLine{S,T,P}` object.\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots.PlotDataXYLine","page":"Reference","title":"OhMyPlots.PlotDataXYLine","text":"struct PlotDataXYLine{S,T,P}<: PlotDataAbstract\n\nThe PlotDataXYLine struct represents a type of plot data for XY line plots.\n\nFields\n\nXVar::Var{S,T}: The variable representing the X-axis data.\nYVar::Var{S,P}: The variable representing the Y-axis data.\nCurveVars::CurveVar{S}: The variable representing the curve data.\n\n\n\n\n\n","category":"type"},{"location":"reference/#OhMyPlots.Var","page":"Reference","title":"OhMyPlots.Var","text":"struct Var{S<:AbstractString,T<:Union{AbstractFloat,Int, AbstractString}} <: VariableAbstract\n\nThe Var struct represents a variable with a name, unit, and a vector of values.\n\nFields\n\nname::S: The name of the variable.\nunit::S: The unit of measurement for the variable.\nvalue::Vector{T}: A vector of values for the variable.\n\n\n\n\n\n","category":"type"},{"location":"reference/#OhMyPlots.XY-Union{Tuple{PlotAttributsXYLine{S, T, P}}, Tuple{P}, Tuple{T}, Tuple{S}} where {S, T, P}","page":"Reference","title":"OhMyPlots.XY","text":"XY(Pattr::PlotAttributsXYLine{S,T,P}) where {S,T,P}\n\nThis function generates an XY plot based on the given plot attributes.\n\n# Arguments\n- `Pattr::PlotAttributsXYLine{S,T,P}`: The plot attributes object containing information such as data, save path, save format, title, scatter option, y-axis limits, x-axis limits, number of curves, and number of points in each curve.\n\n# Returns\n- `fig`: The generated figure object.\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots.XY_Line_Scatter_Theme-Tuple{}","page":"Reference","title":"OhMyPlots.XY_Line_Scatter_Theme","text":"XYLineScatter_Theme(;size=size, fonts=fonts, fontsize=fontsize, font=font, axis=axis, Legend=Legend, Colorbar=Colorbar,cycle= cycle, palette=palette,      markersize=markersize, markercolor=markercolor, strokewidth=strokewidth, position=position, nbanks=nbanks,labelsize=labelsize, orientation=orientation)\n\nCreate a theme for XY plots with lines and scatter plots\n\n# Arguments\n- size: Tuple{Int,Int} = (600, 480)\n- fonts: NamedTuple = (;regular = Makie.assetpath(\"times.ttf\"),\n                bold_italic  = Makie.assetpath(\"timesbi.ttf\"),\n                bold= Makie.assetpath(\"timesbd.ttf\"),\n                italic = Makie.assetpath(\"timesi.ttf\")\n                )\n- fontsize: Int = 20\n- font: Symbol = :bold\n- axis: NamedTuple = (\n        xlabelsize=28,xlabelpadding=+5,\n        ylabelsize=28,ylabelpadding=+5,\n        xgridstyle=:dash, ygridstyle=:dash,\n        xgridwidth = 1.5, ygridwidth = 1.5,\n        xtickalign=1, ytickalign=1,\n        yticksize=10, xticksize=10,\n        markersize=16, markercolor= :white, strokewidth=2.0, \n        )\n- Legend: NamedTuple = (framecolor=(:black, 0.5), backgroundcolor=(:white, 0.5),\n            position=:lt, nbanks=3,labelsize=12, orientation=:horizontal)\n- Colorbar: NamedTuple = (ticksize=16, tickalign=1, spinewidth=0.5)\n- cycle: Cycle = Cycle([:color, :linestyle, :marker], covary=true)\n- palette: NamedTuple = (linestyle = linestyle_palette,marker = marker_palette,color = color_palette)\n- markersize: Int = 8\n- markercolor: Symbol = :white\n- strokewidth: Float64 = 2.0\n- position: Symbol = :lt\n- nbanks: Int = 3\n- labelsize: Int = 12\n- orientation: Symbol = :horizontal\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots.XY_Theme-Tuple{}","page":"Reference","title":"OhMyPlots.XY_Theme","text":"XY_Theme(;size=size, fonts=fonts, fontsize=fontsize, font=font, axis=axis, Legend=Legend, Colorbar=Colorbar,cycle= cycle,      palette=palette, markersize=markersize, markercolor=markercolor, strokewidth=strokewidth, position=position, nbanks=nbanks,labelsize=labelsize, orientation=orientation)\n\nCreate a theme for XY plots\n\n# Arguments\n- size: Tuple{Int,Int} = (600, 480)\n- fonts: NamedTuple = (;regular = Makie.assetpath(\"times.ttf\"),\n                bold_italic  = Makie.assetpath(\"timesbi.ttf\"),\n                bold= Makie.assetpath(\"timesbd.ttf\"),\n                italic = Makie.assetpath(\"timesi.ttf\")\n                )\n- fontsize: Int = 20\n- font: Symbol = :bold\n- axis: NamedTuple = (\n        xlabelsize=28,xlabelpadding=+5,\n        ylabelsize=28,ylabelpadding=+5,\n        xgridstyle=:dash, ygridstyle=:dash,\n        xgridwidth = 1.5, ygridwidth = 1.5,\n        xtickalign=1, ytickalign=1,\n        yticksize=10, xticksize=10,\n        markersize=16, markercolor= :white, strokewidth=2.0, \n        )\n- Legend: NamedTuple = (framecolor=(:black, 0.5), backgroundcolor=(:white, 0.5),\n            position=:lt, nbanks=3,labelsize=12, orientation=:horizontal)\n- Colorbar: NamedTuple = (ticksize=16, tickalign=1, spinewidth=0.5)\n- cycle: Cycle = Cycle([:color, :linestyle, :marker], covary=true)\n- palette: NamedTuple = (linestyle = linestyle_palette,marker = marker_palette,color = color_palette)\n- markersize: Int = 8\n- markercolor: Symbol = :white\n- strokewidth: Float64 = 2.0\n- position: Symbol = :lt\n- nbanks: Int = 3\n- labelsize: Int = 12\n- orientation: Symbol = :horizontal\n\nlinestyle_palette = (:solid,(:dot,:dense) ,:dash, :dashdot,:dashdotdot,(:dot,:loose))\nmarker_palette = [:circle,:rect,:cross,:utriangle, :dtriangle,:xcross]\ncolor_palette = [:red, :blue, :black,:green,:orange,:pink]\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots.__check_number_of_x_vars-Union{Tuple{Array{PlotDataXYLine{S, T, P}, 1}}, Tuple{P}, Tuple{T}, Tuple{S}} where {S, T, P}","page":"Reference","title":"OhMyPlots.__check_number_of_x_vars","text":"__check_number_of_x_vars(data::Vector{PlotDataXYLine{S,T,P}}) where {S,T,P}\n\nCheck the number of XVars in the given data.\n\n# Arguments\n- `data::Vector{PlotDataXYLine{S,T,P}}`: A vector of `PlotDataXYLine` objects.\n\n# Returns\n- `nothing`: If the number of XVars is consistent.\n\n# Throws\n- `error`: If the number of XVars is not consistent.\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots.__check_number_of_y_vars-Union{Tuple{Array{PlotDataXYLine{S, T, P}, 1}}, Tuple{P}, Tuple{T}, Tuple{S}} where {S, T, P}","page":"Reference","title":"OhMyPlots.__check_number_of_y_vars","text":"__check_number_of_y_vars(data::Vector{PlotDataXYLine{S,T,P}}) where {S,T,P}\n\nCheck the number of YVars in the given data.\n\n# Arguments\n- `data::Vector{PlotDataXYLine{S,T,P}}`: A vector of `PlotDataXYLine` objects.\n\n# Returns\n- `nothing`: If the number of YVars is consistent.\n\n# Throws\n- `ErrorException`: If the number of YVars is not consistent.\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots._apply_xlims-Tuple{Makie.Axis, Nothing}","page":"Reference","title":"OhMyPlots._apply_xlims","text":"_apply_xlims(ax::Axis, x::Nothing)\n\nApply the x-axis limits to the given `ax` Axis object.\n\n# Arguments\n- `ax::Axis`: The Axis object to apply the limits to.\n- `x::Nothing`: The x-axis limits. Since it is `Nothing`, no limits are applied.\n\n# Returns\n- `ax::Axis`: The updated Axis object.\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots._apply_xlims-Union{Tuple{T}, Tuple{Makie.Axis, Tuple{T, T}}} where T<:Real","page":"Reference","title":"OhMyPlots._apply_xlims","text":"_apply_xlims(ax::Axis, x::Tuple{T,T}) where T<:Real\n\nApply the x-axis limits to the given `ax` Axis object.\n\n# Arguments\n- `ax::Axis`: The Axis object to apply the limits to.\n- `x::Tuple{T,T}`: The x-axis limits as a tuple of two elements.\n\n# Returns\n- `ax::Axis`: The modified Axis object.\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots._apply_ylims-Tuple{Makie.Axis, Nothing}","page":"Reference","title":"OhMyPlots._apply_ylims","text":"_apply_ylims(ax::Axis, x::Nothing)\n\nApply y-axis limits to the given axis.\n\nParameters\n----------\nax : Axis\n    The axis to apply the y-axis limits to.\nx : Nothing\n    The value representing no y-axis limits.\n\nReturns\n-------\nAxis\n    The modified axis.\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots._apply_ylims-Union{Tuple{T}, Tuple{Makie.Axis, Tuple{T, T}}} where T<:Real","page":"Reference","title":"OhMyPlots._apply_ylims","text":"_apply_ylims(ax::Axis, x::Tuple{T,T}) where T<:Real\n\nApply the y-axis limits to the given `ax` Axis object.\n\n# Arguments\n- `ax::Axis`: The Axis object to apply the y-axis limits to.\n- `x::Tuple{T,T}`: The y-axis limits as a tuple of two elements.\n\n# Returns\n- `ax`: The modified Axis object with the y-axis limits applied.\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots._check_xy_vars-Union{Tuple{Array{PlotDataXYLine{S, T, P}, 1}}, Tuple{P}, Tuple{T}, Tuple{S}} where {S, T, P}","page":"Reference","title":"OhMyPlots._check_xy_vars","text":"_check_xy_vars(data::Vector{PlotDataXYLine{S,T,P}}) where {S,T,P}\n\nCheck the number of x and y variables in the given vector of `PlotDataXYLine` objects.\n\n# Arguments\n- `data`: A vector of `PlotDataXYLine` objects.\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots._create_pallette-Union{Tuple{P}, Tuple{T}, Tuple{S}, Tuple{Array{PlotDataXYLine{S, T, P}, 1}, Any, Any}} where {S, T, P}","page":"Reference","title":"OhMyPlots._create_pallette","text":"_create_pallette(data::Vector{PlotDataXYLine{S,T,P}}, n_curve, n_each_curve) where {S,T,P}\n\nCreate a palette and color order for plotting multiple curves.\n\n# Arguments\n- `data::Vector{PlotDataXYLine{S,T,P}}`: Vector of plot data for XY line plots.\n- `n_curve`: Number of curves to plot.\n- `n_each_curve`: Number of colors to use for each curve.\n\n# Returns\n- `palette`: A tuple containing the linestyle, marker, and color palettes.\n- `color_order`: An ordered list of colors to use for each curve.\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots._draw_scatterlines-Union{Tuple{P}, Tuple{T}, Tuple{S}, Tuple{Array{PlotDataXYLine{S, T, P}, 1}, Any, Any, Any}} where {S, T, P}","page":"Reference","title":"OhMyPlots._draw_scatterlines","text":"_draw_scatterlines(data::Vector{PlotDataXYLine{S,T,P}}, ax, fig, color_order) where {S,T,P}\n\nDraws scatterlines on the given axes ax using the data provided in data. Each element in data represents a line plot with x-values XVar.value and y-values YVar.value. The label for each line plot is taken from CurveVars.legend. The scatterlines are drawn with the specified color_order for strokecolor and color.\n\nArguments\n\ndata::Vector{PlotDataXYLine{S,T,P}}: Vector of line plot data.\nax: Axes object to draw the scatterlines on.\nfig: Figure object to which the axes belong.\ncolor_order: Vector of colors to use for strokecolor and color.\n\nReturns\n\nax: The modified axes object.\nfig: The unmodified figure object.\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots._make_fig_ax-NTuple{4, Any}","page":"Reference","title":"OhMyPlots._make_fig_ax","text":"_make_fig_ax(cycle, palette, xy_label, title)\n\nConstructs a figure and axis for plotting XY data.\n\nArguments\n\ncycle::Any: The cycle parameter for ScatterLines.\npalette::Any: The palette parameter for the figure.\nxy_label::Tuple: A tuple containing the x-axis and y-axis labels and units.\ntitle::Any: The title of the plot.\n\nReturns\n\nax::Axis: The constructed axis.\nfig::Figure: The constructed figure.\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots._post_process_figure-Tuple{Any, Any, Any}","page":"Reference","title":"OhMyPlots._post_process_figure","text":"_post_process_figure(ax, ylim, xlim)\n\nPost-processes the figure by applying the specified y-limits (`ylim`) and x-limits (`xlim`) to the axes (`ax`).\n\n# Arguments\n- `ax`: The axes object to be post-processed.\n- `ylim`: The y-limits to be applied to the axes.\n- `xlim`: The x-limits to be applied to the axes.\n\n# Returns\nThe post-processed axes object.\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots._pre_process_figure-NTuple{5, Any}","page":"Reference","title":"OhMyPlots._pre_process_figure","text":"_pre_process_figure(data, save_path, save_format, n_curve, n_each_curve)\n\nPre-processes the figure data before saving it.\n\nArguments\n\ndata: The figure data.\nsave_path: The path where the figure will be saved.\nsave_format: The format in which the figure will be saved.\nn_curve: The number of curves in the figure.\nn_each_curve: The number of points in each curve.\n\nReturns\n\nimage_path: The path of the saved image.\ncycle: The cycle of line styles and markers.\npalette: The color palette for the figure.\ncolor_order: The order of colors in the palette.\nxy_label: The labels for the x and y axes.\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots.ax_barier-Tuple{Makie.Axis}","page":"Reference","title":"OhMyPlots.ax_barier","text":"ax_barier(ax::Axis)\n\nA function that returns the input `ax` object. It is just a barrier function for type stability.\n\n# Arguments\n- `ax::Axis`: The input `Axis` object.\n\n# Returns\n- `ax`: The input `Axis` object.\n\n\n\n\n\n","category":"method"},{"location":"reference/#OhMyPlots.xy_label!-Tuple{Any, Any}","page":"Reference","title":"OhMyPlots.xy_label!","text":"xy_label!(data, xy_label)\n\nSet the labels for the x and y variables in the given `data` structure.\n\n# Arguments\n- `data`: The data structure containing the x and y variables.\n- `xy_label`: An array to store the labels for the x and y variables. The labels are assigned to the elements of `xy_label` in the following order: x variable name, x variable unit, y variable name, y variable unit.\n\n\n\n\n\n","category":"method"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = OhMyPlots","category":"page"},{"location":"#OhMyPlots","page":"Home","title":"OhMyPlots","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for OhMyPlots.","category":"page"},{"location":"#Install","page":"Home","title":"Install","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"pkg> add https://github.com/maysam-gholampour/OhMyPlots.jl","category":"page"}]
}
