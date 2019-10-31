# docs/make.jl
# Make Documentation for SubTypes.jl

push!(LOAD_PATH, "../src/")

using Documenter, SubTypes

makedocs(
    modules   = [SubTypes],
    doctest   = true,
    clean     = false,
    linkcheck = false,
    format    = Documenter.HTML(prettyurls=!("local" in ARGS)),
    sitename  = "SubTypes.jl",
    authors   = "Brandon H Gomes",
    pages     = [
        "Home" => "index.md",
    ],
)

deploydocs(
    repo = "github.com/bhgomes/SubTypes.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
)
