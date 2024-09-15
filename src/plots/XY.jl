export XY


begin "pallete"
    linestyle_palette = @SVector[:solid,(:dot,:dense) ,:dash, :dashdot,:dashdotdot,(:dot,:loose)]
    marker_palette = @SVector[:circle,:rect,:cross,:utriangle, :dtriangle,:xcross]
    color_palette = @SVector[:red, :blue, :black,:green,:orange,:pink]

    """
        _create_pallette(data::Vector{PlotDataXYLine{S,T,P}}, n_curve, n_each_curve) where {S,T,P}

        Create a palette and color order for plotting multiple curves.

        # Arguments
        - `data::Vector{PlotDataXYLine{S,T,P}}`: Vector of plot data for XY line plots.
        - `n_curve`: Number of curves to plot.
        - `n_each_curve`: Number of colors to use for each curve.

        # Returns
        - `palette`: A tuple containing the linestyle, marker, and color palettes.
        - `color_order`: An ordered list of colors to use for each curve.

    """
    function _create_pallette(data::Vector{PlotDataXYLine{S,T,P}},n_curve, n_each_curve) where {S,T,P}
        palette = (linestyle = linestyle_palette[1:n_each_curve],marker = marker_palette[1:n_curve],color = color_palette[1:n_each_curve])
        color_order = Symbol[]
        @inbounds for i in 1:n_curve* n_each_curve
            @inbounds for j in 1:n_each_curve
                push!(color_order, color_palette[j])
            end
        end
        palette , color_order
    end
end

begin "checking functions"

    """
        __check_number_of_x_vars(data::Vector{PlotDataXYLine{S,T,P}}) where {S,T,P}

        Check the number of XVars in the given data.

        # Arguments
        - `data::Vector{PlotDataXYLine{S,T,P}}`: A vector of `PlotDataXYLine` objects.

        # Returns
        - `nothing`: If the number of XVars is consistent.

        # Throws
        - `error`: If the number of XVars is not consistent.

    """
    function __check_number_of_x_vars(data::Vector{PlotDataXYLine{S,T,P}}) where {S,T,P}
        x_vars = [d.XVar.name for d in data]
        if length(unique(x_vars)) > 1
            error("All XVars must be the same")
        end
        nothing
    end

    """
        __check_number_of_y_vars(data::Vector{PlotDataXYLine{S,T,P}}) where {S,T,P}

        Check the number of YVars in the given data.

        # Arguments
        - `data::Vector{PlotDataXYLine{S,T,P}}`: A vector of `PlotDataXYLine` objects.

        # Returns
        - `nothing`: If the number of YVars is consistent.

        # Throws
        - `ErrorException`: If the number of YVars is not consistent.

    """
    function __check_number_of_y_vars(data::Vector{PlotDataXYLine{S,T,P}}) where {S,T,P}
        y_vars = [d.YVar.name for d in data]
        if length(unique(y_vars)) > 1
            error("All YVars must be the same")
        end
        nothing
    end

    """
        _check_xy_vars(data::Vector{PlotDataXYLine{S,T,P}}) where {S,T,P}

        Check the number of x and y variables in the given vector of `PlotDataXYLine` objects.

        # Arguments
        - `data`: A vector of `PlotDataXYLine` objects.

    """
    function _check_xy_vars(data::Vector{PlotDataXYLine{S,T,P}}) where {S,T,P}
        __check_number_of_x_vars(data)
        __check_number_of_y_vars(data)
    end
end

begin "pre process"

    """
        xy_label!(data, xy_label)

        Set the labels for the x and y variables in the given `data` structure.

        # Arguments
        - `data`: The data structure containing the x and y variables.
        - `xy_label`: An array to store the labels for the x and y variables. The labels are assigned to the elements of `xy_label` in the following order: x variable name, x variable unit, y variable name, y variable unit.

    """
    function xy_label!(data,xy_label)
        xy_label[1] = data.XVar.name
        xy_label[2] = data.XVar.unit
        xy_label[3] = data.YVar.name
        xy_label[4] = data.YVar.unit
        nothing
    end

    """
        _pre_process_figure(data, save_path, save_format, n_curve, n_each_curve)

    Pre-processes the figure data before saving it.

    # Arguments
    - `data`: The figure data.
    - `save_path`: The path where the figure will be saved.
    - `save_format`: The format in which the figure will be saved.
    - `n_curve`: The number of curves in the figure.
    - `n_each_curve`: The number of points in each curve.

    # Returns
    - `image_path`: The path of the saved image.
    - `cycle`: The cycle of line styles and markers.
    - `palette`: The color palette for the figure.
    - `color_order`: The order of colors in the palette.
    - `xy_label`: The labels for the x and y axes.

    """
    function _pre_process_figure(data,save_path,save_format,n_curve, n_each_curve)
        _check_xy_vars(data)
        image_path = save_path * "." * save_format
        cycle= Cycle([:linestyle,:marker], covary=false)
        palette, color_order = _create_pallette(data,n_curve, n_each_curve)
        xy_label = Vector{String}(undef,4)
        xy_label!(first(data),xy_label)
        image_path,cycle,palette,color_order,xy_label
    end
end

begin "process"

    """
        ax_barier(ax::Axis)

        A function that returns the input `ax` object. It is just a barrier function for type stability.

        # Arguments
        - `ax::Axis`: The input `Axis` object.

        # Returns
        - `ax`: The input `Axis` object.

    """
    ax_barier(ax::Axis) = ax

    """
        _make_fig_ax(cycle, palette, xy_label, title)

    Constructs a figure and axis for plotting XY data.

    # Arguments
    - `cycle::Any`: The cycle parameter for ScatterLines.
    - `palette::Any`: The palette parameter for the figure.
    - `xy_label::Tuple`: A tuple containing the x-axis and y-axis labels and units.
    - `title::Any`: The title of the plot.

    # Returns
    - `ax::Axis`: The constructed axis.
    - `fig::Figure`: The constructed figure.
    """
    function _make_fig_ax(cycle,palette,xy_label,title)
        xlabel,xlabel_unit,ylabel,ylabel_unit = xy_label
        fig = Figure(ScatterLines=(cycle=cycle,),palette = palette)
        ax = ax_barier(Axis(fig[1, 1], xlabel=L"%$xlabel %$xlabel_unit", ylabel=L"%$ylabel %$ylabel_unit",title=title))
        ax, fig
    end

    """
        _draw_scatterlines(data::Vector{PlotDataXYLine{S,T,P}}, ax, fig, color_order) where {S,T,P}

    Draws scatterlines on the given axes `ax` using the data provided in `data`. Each element in `data` represents a line plot with x-values `XVar.value` and y-values `YVar.value`. The `label` for each line plot is taken from `CurveVars.legend`. The scatterlines are drawn with the specified `color_order` for strokecolor and color.

    # Arguments
    - `data::Vector{PlotDataXYLine{S,T,P}}`: Vector of line plot data.
    - `ax`: Axes object to draw the scatterlines on.
    - `fig`: Figure object to which the axes belong.
    - `color_order`: Vector of colors to use for strokecolor and color.

    # Returns
    - `ax`: The modified axes object.
    - `fig`: The unmodified figure object.

    """
    function _draw_scatterlines(data::Vector{PlotDataXYLine{S,T,P}},ax,fig,color_order) where {S,T,P}
        for i in eachindex(data)
            x = data[i].XVar.value
            y = data[i].YVar.value
            label = data[i].CurveVars.legend
            scatterlines!(ax, x, y; 
                # markersize=13, markercolor= :white, strokewidth=2.0,
                strokecolor = color_order[i], color=color_order[i],
                label=L"%$label")
        end
        ax,fig
    end
end

begin "yx limit functions and post process"
    
    """
        _apply_ylims(ax::Axis, x::Tuple{T,T}) where T<:Real

        Apply the y-axis limits to the given `ax` Axis object.

        # Arguments
        - `ax::Axis`: The Axis object to apply the y-axis limits to.
        - `x::Tuple{T,T}`: The y-axis limits as a tuple of two elements.

        # Returns
        - `ax`: The modified Axis object with the y-axis limits applied.
    """
    function _apply_ylims(ax::Axis,x::Tuple{T,T}) where T<:Real
        ylims!(ax,x...)
        ax
    end

    """
        _apply_xlims(ax::Axis, x::Tuple{T,T}) where T<:Real

        Apply the x-axis limits to the given `ax` Axis object.

        # Arguments
        - `ax::Axis`: The Axis object to apply the limits to.
        - `x::Tuple{T,T}`: The x-axis limits as a tuple of two elements.

        # Returns
        - `ax::Axis`: The modified Axis object.

    """
    function _apply_xlims(ax::Axis,x::Tuple{T,T}) where T<:Real
        xlims!(ax,x...)
        ax
    end

    """
        _apply_ylims(ax::Axis, x::Nothing)

        Apply y-axis limits to the given axis.

        Parameters
        ----------
        ax : Axis
            The axis to apply the y-axis limits to.
        x : Nothing
            The value representing no y-axis limits.

        Returns
        -------
        Axis
            The modified axis.
    """
    _apply_ylims(ax::Axis,x::Nothing) = ax
    """
        _apply_xlims(ax::Axis, x::Nothing)

        Apply the x-axis limits to the given `ax` Axis object.

        # Arguments
        - `ax::Axis`: The Axis object to apply the limits to.
        - `x::Nothing`: The x-axis limits. Since it is `Nothing`, no limits are applied.

        # Returns
        - `ax::Axis`: The updated Axis object.

    """
    _apply_xlims(ax::Axis,x::Nothing) = ax

    """
        _post_process_figure(ax, ylim, xlim)

        Post-processes the figure by applying the specified y-limits (`ylim`) and x-limits (`xlim`) to the axes (`ax`).

        # Arguments
        - `ax`: The axes object to be post-processed.
        - `ylim`: The y-limits to be applied to the axes.
        - `xlim`: The x-limits to be applied to the axes.

        # Returns
        The post-processed axes object.

    """
    function _post_process_figure(ax,ylim,xlim)
        # axislegend(;position=legend_position, nbanks=legend_nbanks, labelsize=legend_labelsize,orientation = legend_orientation)
        axislegend()
        ax = _apply_ylims(ax,ylim)
        ax = _apply_xlims(ax,xlim)
        ax
    end
    
end

"""
    XY(Pattr::PlotAttributsXYLine{S,T,P}) where {S,T,P}

    This function generates an XY plot based on the given plot attributes.

    # Arguments
    - `Pattr::PlotAttributsXYLine{S,T,P}`: The plot attributes object containing information such as data, save path, save format, title, scatter option, y-axis limits, x-axis limits, number of curves, and number of points in each curve.

    # Returns
    - `fig`: The generated figure object.

"""
function XY(Pattr::PlotAttributsXYLine{S,T,P}) where {S,T,P}
    @unpack data,save_path,save_format,title,is_scatter,ylim,xlim, n_curve, n_each_curve = Pattr
    
    # pre process
    image_path,cycle,palette,color_order,xy_label = _pre_process_figure(data,save_path,save_format,n_curve, n_each_curve)
    # process 
    ax , fig = _make_fig_ax(cycle,palette,xy_label,title)
    ax , fig = _draw_scatterlines(data,ax,fig,color_order)
    # post process
    ax = _post_process_figure(ax,ylim,xlim)
    # save and return
    trim!(fig.layout)
    save(image_path, fig)
    fig 
end

