export XY


begin "pallete"
    linestyle_palette = @SVector[:solid,(:dot,:dense) ,:dash, :dashdot,:dashdotdot,(:dot,:loose)]
    marker_palette = @SVector[:circle,:rect,:cross,:utriangle, :dtriangle,:xcross]
    color_palette = @SVector[:red, :blue, :black,:green,:orange,:pink]


    function _create_pallette(data::Vector{PlotDataXYLine{S,T,P}},n_curve, n_each_curve) where {S,T,P}
        palette = (linestyle = linestyle_palette[1:n_curve],marker = marker_palette[1:n_each_curve],color = color_palette[1:n_each_curve])
        palette
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

    function _pre_process_figure(data,n_curve, n_each_curve)
        _check_xy_vars(data)
        cycles= (
                    Cycle([:color,:linestyle];covary = false),
                    Cycle([:marker,:strokecolor => :color];covary = true)
                    )
        palette = _create_pallette(data,n_curve, n_each_curve)
        xy_label = Vector{String}(undef,4)
        xy_label!(first(data),xy_label)
        cycles,palette,xy_label
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

    function _make_fig_ax(cycles,palette,xy_label,title)
        xlabel,xlabel_unit,ylabel,ylabel_unit = xy_label
        fig = Figure(
            Lines=(cycle=cycles[1],),
            Scatter=(cycle=cycles[2],),
            palette = palette)
        ax = ax_barier(Axis(fig[1, 1], xlabel=L"%$xlabel %$xlabel_unit", ylabel=L"%$ylabel %$ylabel_unit",title=title))
        ax, fig
    end

    function _draw_scatter_and_lines(data::Vector{PlotDataXYLine{S,T,P}},ax,fig,N_samples) where {S,T,P}
        for i in eachindex(data)
            x = data[i].XVar.value
            y = data[i].YVar.value
            x_scatter , y_scatter = __sample_data(x,y,N_samples)
            label = data[i].CurveVars.legend
            scatter!(ax, x_scatter, y_scatter; 
                color= :white, 
                # strokecolor = color_order[i],
                strokewidth=1.25,
                label=L"%$label")
            lines!(ax, x, y; 
                # color=color_order[i],
                label=L"%$label")
        end
        ax,fig
    end
    function __sample_data(x,y,N_samples)
        if length(x) > N_samples
            R = range(start=1,stop=length(x),length = N_samples) .|> round .|> Int 
            x = x[R]
            y = y[R]
        else
            nothing
        end
        x,y
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
        axislegend(merge = true)
        # Legend()
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
    @unpack data,title,ylim,xlim, n_curve, n_each_curve, N_samples = Pattr
    
    # pre process
    cycles,palette,xy_label = _pre_process_figure(data,n_curve, n_each_curve)
    # process 
    ax , fig = _make_fig_ax(cycles,palette,xy_label,title)
    ax , fig = _draw_scatter_and_lines(data,ax,fig,N_samples)
    # post process
    ax = _post_process_figure(ax,ylim,xlim)

    fig 
end

