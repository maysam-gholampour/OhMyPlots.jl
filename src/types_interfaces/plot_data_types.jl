export PlotDataAbstract, PlotDataXYLine, PlotDataX2YLine


abstract type PlotDataAbstract end

struct PlotDataXYLine{T1::Vector{Var},Vector{CurveVar}} <: PlotDataAbstract
    XVar::T1
    YVars::T1
    CurveVars::T2
end

struct PlotDataX2YLine{T1::Vector{Var},Vector{CurveVar}} <: PlotDataAbstract #TODO: complete for 2-axes y in the future
    XVar::T1
    Y1Vars::T1
    Y2Vars::T1
    CurveVars1::T2
    CurveVars2::T2
end