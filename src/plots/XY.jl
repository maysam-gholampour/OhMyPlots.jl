export XY


begin "pallete"
    linestyle_palette = @SVector[:solid,(:dot,:dense) ,:dash, :dashdot,:dashdotdot,(:dot,:loose)]
    marker_palette = @SVector[:circle,:rect,:cross,:utriangle, :dtriangle,:xcross]
    color_palette = @SVector[:red, :blue, :black,:green,:orange,:pink]

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
    function __check_number_of_x_vars(data::Vector{PlotDataXYLine{S,T,P}}) where {S,T,P}
        x_vars = [d.XVar.name for d in data]
        if length(unique(x_vars)) > 1
            error("All XVars must be the same")
        end
        nothing
    end

    function __check_number_of_y_vars(data::Vector{PlotDataXYLine{S,T,P}}) where {S,T,P}
        y_vars = [d.YVar.name for d in data]
        if length(unique(y_vars)) > 1
            error("All YVars must be the same")
        end
        nothing
    end

    function _check_xy_vars(data::Vector{PlotDataXYLine{S,T,P}}) where {S,T,P}
        __check_number_of_x_vars(data)
        __check_number_of_y_vars(data)
    end
end

begin "pre process"

    function xy_label!(data,xy_label)
        xy_label[1] = data.XVar.name
        xy_label[2] = data.XVar.unit
        xy_label[3] = data.YVar.name
        xy_label[4] = data.YVar.unit
        nothing
    end

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
    ax_barier(ax::Axis) = ax

    function _make_fig_ax(cycle,palette,xy_label,title)
        xlabel,xlabel_unit,ylabel,ylabel_unit = xy_label
        fig = Figure(ScatterLines=(cycle=cycle,),palette = palette)
        ax = ax_barier(Axis(fig[1, 1], xlabel=L"%$xlabel %$xlabel_unit", ylabel=L"%$ylabel %$ylabel_unit",title=title))
        ax, fig
    end

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
    function _apply_ylims(ax::Axis,x::Tuple{T,T}) where T<:Real
        ylims!(ax,x...)
        ax
    end

    function _apply_xlims(ax::Axis,x::Tuple{T,T}) where T<:Real
        xlims!(ax,x...)
        ax
    end

    _apply_ylims(ax::Axis,x::Nothing) = ax
    _apply_xlims(ax::Axis,x::Nothing) = ax

    function _post_process_figure(ax,ylim,xlim)
        # axislegend(;position=legend_position, nbanks=legend_nbanks, labelsize=legend_labelsize,orientation = legend_orientation)
        # axislegend()
        ax = _apply_ylims(ax,ylim)
        ax = _apply_xlims(ax,xlim)
        ax
    end
    
end

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

