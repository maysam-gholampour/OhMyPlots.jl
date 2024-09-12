export PlotDataAbstract, PlotDataXYLine, PlotDataX2YLine
# export PlotDataXYLineAbstract, PlotDataX2YLineAbstract


abstract type PlotDataAbstract end
# abstract type PlotDataXYLineAbstract<: PlotDataAbstract end
# abstract type PlotDataX2YLineAbstract<: PlotDataAbstract end



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