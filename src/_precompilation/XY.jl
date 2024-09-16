export _precompile_XY


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

function _precompile_XY()
    title = L"n_{curve} = 4 - n_{each,curve} = 3"
    kwargs = Dict(
        :title => title,
        :ylim => (0.0, 35.0),
    )

    n_curve = 4
    n_each_curve = 3

    plot_data = Vector{PlotDataXYLine{LaTeXString,Float64,Float64}}(undef, n_curve * n_each_curve)
    fill_plot_data!(plot_data,n_curve,n_each_curve)
    plotAttributes = PlotAttributsXYLine(plot_data,n_curve,n_each_curve;kwargs...);

    fig = XY(plotAttributes)
    fig
end
