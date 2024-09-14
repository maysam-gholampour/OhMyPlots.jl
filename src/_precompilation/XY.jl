export _preconpile_XY


function fill_C(Name,range,plot_data)
    for i in range
        name = L"X"
        unit = L"[x]"
        value1 = sort(rand(20))
        xVar = Var(name, unit, value1)

        name = L"Y"
        unit = L"[y]"
        value2= rand(20)
        yVar = Var(name, unit, value2)

        legend = latexstring("$(Name)_$i")
        cVar = CurveVar(legend)

        plot_data[i] = PlotDataXYLine(xVar, yVar, cVar)
    end
end

function fill_plot_data!(plot_data,n_curve,n_each_curve)
    for i in 1:n_curve
        fill_C(L"C_%$(string(i))",n_each_curve*(i-1)+1:n_each_curve*i,plot_data)
    end
    nothing
end

function _preconpile_XY()
    title = L"n_{curve} = 4 - n_{each,curve} = 3"
    save_path = "_precompile/43"
    save_format = "svg"
    kwargs = Dict(
        :title => title,
        :save_path => save_path,
        :ylim => (0.0, 35.0),
        :legend_labelsize => 14,
        :legend_orientation => :horizontal,
        :legend_nbanks => 2,
        :legend_position => :lt,
    )

    n_curve = 4
    n_each_curve = 3

    plot_data = Vector{PlotDataXYLine{LaTeXString,Float64,Float64}}(undef, n_curve * n_each_curve)
    fill_plot_data!(plot_data,n_curve,n_each_curve)
    plotAttributes = PlotAttributsXYLine(plot_data,save_path, save_format,n_curve,n_each_curve;kwargs...);

    fig = XY(plotAttributes)
    fig
end