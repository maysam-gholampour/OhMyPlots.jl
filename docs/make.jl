using PlotMultiLevelData
using Documenter

DocMeta.setdocmeta!(PlotMultiLevelData, :DocTestSetup, :(using PlotMultiLevelData); recursive=true)

makedocs(;
    modules=[PlotMultiLevelData],
    authors="maysam-gholampour <meysam.gholampoor@gmail.com> and contributors",
    sitename="PlotMultiLevelData.jl",
    format=Documenter.HTML(;
        canonical="https://maysam-gholampour.github.io/PlotMultiLevelData.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/maysam-gholampour/PlotMultiLevelData.jl",
    devbranch="main",
)
