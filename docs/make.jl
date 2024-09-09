using OhMyPlots
using Documenter

DocMeta.setdocmeta!(OhMyPlots, :DocTestSetup, :(using OhMyPlots); recursive=true)

makedocs(;
    modules=[OhMyPlots],
    authors="maysam-gholampour <meysam.gholampoor@gmail.com> and contributors",
    sitename="OhMyPlots.jl",
    format=Documenter.HTML(;
        canonical="https://maysam-gholampour.github.io/OhMyPlots.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/maysam-gholampour/OhMyPlots.jl",
    devbranch="main",
)
