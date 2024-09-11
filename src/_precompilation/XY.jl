export _preconpile_XY


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

function fill_plot_data!(plot_data,n_curve,n_each_curve)
    for i in 1:n_curve
        fill_C("C"*string(i),n_each_curve*(i-1)+1:n_each_curve*i,plot_data)
    end
    nothing
end

function _preconpile_XY()
    title = "n_curve = 4 - n_each_curve = 3"
    save_path = "src/_precompilation/images/43"
    save_format = "svg"
    kwargs = Dict(
        :title => title,
        :save_path => save_path,
        :ylim => (0.0, 45.0),
        :legend_labelsize => 14,
        :legend_orientation => :vertical,
        :legend_nbanks => 2,
        :legend_position => :lt,
    )

    n_curve = 4
    n_each_curve = 3

    plot_data = Vector{PlotDataXYLine{String,Float64,Float64}}(undef, n_curve * n_each_curve)
    fill_plot_data!(plot_data,n_curve,n_each_curve)
    plotAttributes = PlotAttributsXYLine(plot_data,save_path, save_format;kwargs...);

    fig = XY(plotAttributes)
    fig
end
