using OhMyPlots
using InteractiveUtils: @code_warntype

function _check_number_of_x_vars(data::Vector{PlotDataXYLine{S,T,P}}) where {S,T,P}
    x_vars = [d.XVar.name for d in data]
    if length(unique(x_vars)) > 1
        error("All XVars must be the same")
    end
    nothing
end

function _check_number_of_y_vars(data::Vector{PlotDataXYLine{S,T,P}}) where {S,T,P}
    y_vars = [d.YVars.name for d in data]
    if length(unique(y_vars)) > 1
        error("All YVars must be the same")
    end
    nothing
end

function xy_label!(data,xy_label)
    xy_label[1] = data.XVar.name
    xy_label[2] = data.XVar.unit
    xy_label[3] = data.YVars.name
    xy_label[4] = data.YVars.unit
    nothing
end

ax_barier(ax::Axis) = ax

function _make_fig_ax(cycle,palette,xy_label)
    xlabel,xlabel_unit,ylabel,ylabel_unit = xy_label
    fig = Figure(ScatterLines=(cycle=cycle,),palette = palette)
    ax = ax_barier(Axis(fig[1, 1], xlabel=L"%$xlabel %$xlabel_unit", ylabel=L"%$ylabel %$ylabel_unit"))
    ax, fig
end

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


function _draw_scatterlines(data::Vector{PlotDataXYLine{S,T,P}},ax,fig) where {S,T,P}
    for i in eachindex(data)
        x = data[i].XVar.value
        y = 2 * i .+ data[i].YVars.value
        curve_name = data[i].CurveVars.name
        curve_unit = data[i].CurveVars.unit
        curve_legend = data[i].CurveVars.legend
        curve_value = data[i].CurveVars.value
        label = curve_name * " = " * curve_value * "\t" * curve_unit * " - " * curve_legend
        scatterlines!(ax, x, y; markersize=13, markercolor= :white, strokewidth=2.0,
            label=L"%$label")
    end
    ax,fig
end


function XY(Pattr::PlotAttributsXYLine{S,T,P}) where {S,T,P}
    @unpack data,save_path,save_format,title,is_scatter,fontsize,ylim,xlim,legend_labelsize,legend_orientation,legend_nbanks,legend_position = Pattr 
    
    # @show data
    image_path = save_path * "." * save_format
    _check_number_of_x_vars(data)
    _check_number_of_y_vars(data)

    fonts = (; regular = "asset/fonts/times.ttf",
                bold_italic  = "asset/fonts/timesbi.ttf",
                bold="asset/fonts/timesbd.ttf",
                italic = "asset/fonts/timesi")
    set_theme!(
        size = (600, 480),
        fonts = fonts,
        fontsize=fontsize, 
        font = :bold,
        Axis=(
            xlabelsize=32,xlabelpadding=+5,
            ylabelsize=32,ylabelpadding=+5,
            xgridstyle=:dash, ygridstyle=:dash,
            xgridwidth = 1.5, ygridwidth = 1.5,
            xtickalign=1, ytickalign=1,
            yticksize=10, xticksize=10,
        ),
        Legend = (framecolor=(:black, 0.5), backgroundcolor=(:white, 0.5),merge=true,),
        Colorbar = (ticksize=16, tickalign=1, spinewidth=0.5) 
    )

    cycle= Cycle([:strokecolor,:linestyle,:marker], covary=false)
    palette = (linestyle = [:solid, :dash,:dot],marker =[:circle,:rect,:cross],strokecolor = [:red, :blue, :black])
    
    xy_label = Vector{String}(undef,4)
    xy_label!(first(data),xy_label)
    


    ax , fig = _make_fig_ax(cycle,palette,xy_label)

    ax,fig = _draw_scatterlines(data,ax,fig)

    


    
    axislegend(;  position=legend_position, nbanks=legend_nbanks, labelsize=legend_labelsize,orientation = legend_orientation)
    
    ax = _apply_ylims(ax,ylim)
    ax = _apply_xlims(ax,xlim)

    trim!(fig.layout)
    save(image_path, fig)
    fig 
end

begin "generate data"
    function fill_C(Name,range,plot_data)
        for i in range
            name = "X"
            unit = "[x]"
            value1 = sort(rand(20))
            xVar = Var(name, unit, value1)

            name = "Y"
            unit = "[y]"
            value2= rand(20)
            yVar = Var(name, unit, value2)

            name = Name
            unit = "["*Name*"_unit]"
            legend = Name*"_legend"
            value3 = Name*"_value"
            cVar = CurveVar(name, unit, legend, value3)

            plot_data[i] = PlotDataXYLine(xVar, yVar, cVar)
        end
    end

    function fill_plot_data!(plot_data)
        fill_C("C1",1:3,plot_data)
        fill_C("C2",4:6,plot_data)
        fill_C("C3",7:9,plot_data)
        nothing
    end

    title = "My Main Plot"
    save_path = "test/plots_test/images/main"
    save_format = "svg"
    kwargs = Dict(
        :title => title,
        :save_path => save_path,
        :ylim => (0.0, 30.0),
        :legend_labelsize => 14,
        :legend_orientation => :vertical,
        :legend_nbanks => 2,
        :legend_position => :lt,
    )

    plot_data = Vector{PlotDataXYLine{String,Float64,Float64}}(undef, 9)
    fill_plot_data!(plot_data)
    plotAttributes = PlotAttributsXYLine(plot_data,save_path, save_format;kwargs...);
end


data = plotAttributes.data
eltype(data)
xy_label = Vector{String}(undef,4)
xy_label!(first(data),xy_label)
cycle= Cycle([:strokecolor,:linestyle,:marker], covary=false)
palette = (linestyle = [:solid, :dash,:dot],marker =[:circle,:rect,:cross],strokecolor = [:red, :blue, :black])

ax , fig = _make_fig_ax(cycle,palette,xy_label)
@code_warntype _make_fig_ax(cycle,palette,xy_label)


@code_warntype XY(plotAttributes)

XY(plotAttributes)










