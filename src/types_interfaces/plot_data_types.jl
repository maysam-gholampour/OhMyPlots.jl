export PlotDataAbstract, PlotDataXYLine, PlotDataX2YLine



abstract type PlotDataAbstract end


"""
    struct PlotDataXYLine{S,T,P}<: PlotDataAbstract

The `PlotDataXYLine` struct represents a type of plot data for XY line plots.

# Fields
- `XVar::Var{S,T}`: The variable representing the X-axis data.
- `YVar::Var{S,P}`: The variable representing the Y-axis data.
- `CurveVars::CurveVar{S}`: The variable representing the curve data.

"""
struct PlotDataXYLine{S,T,P}<: PlotDataAbstract
    XVar::Var{S,T}
    YVar::Var{S,P}
    CurveVars::CurveVar{S}
end

struct PlotDataX2YLine{P,Q,R,S,T}<: PlotDataAbstract #TODO: complete for 2-axes y in the future
    XVar::Var{P}
    Y1Vars::Var{Q}
    Y2Vars::Var{R}
    CurveVars1::CurveVar{S}
    CurveVars2::CurveVar{T}
end