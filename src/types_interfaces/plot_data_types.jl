export PlotDataAbstract, PlotDataXYLine, PlotDataX2YLine
# export PlotDataXYLineAbstract, PlotDataX2YLineAbstract


abstract type PlotDataAbstract end
# abstract type PlotDataXYLineAbstract<: PlotDataAbstract end
# abstract type PlotDataX2YLineAbstract<: PlotDataAbstract end

_P1 = VarAbstract
_P2 = CurveVarAbstract

struct PlotDataXYLine{T1<:_P1,T2<:_P2}<: PlotDataAbstract
    XVar::T1
    YVars::T1
    CurveVars::T2
end

struct PlotDataX2YLine{T1<:_P1,T2<:_P2}<: PlotDataAbstract #TODO: complete for 2-axes y in the future
    XVar::T1
    Y1Vars::T1
    Y2Vars::T1
    CurveVars1::T2
    CurveVars2::T2
end