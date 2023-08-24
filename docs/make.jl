using PColorMesh
using Documenter

DocMeta.setdocmeta!(PColorMesh, :DocTestSetup, :(using PColorMesh); recursive=true)

makedocs(;
    modules=[PColorMesh],
    authors="Dominic Chang",
    repo="https://github.com/dchang10/PColorMesh.jl/blob/{commit}{path}#{line}",
    sitename="PColorMesh.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://dchang10.github.io/PColorMesh.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/dchang10/PColorMesh.jl",
    devbranch="main",
)
