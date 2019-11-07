<div align="center">

# SubTypes.jl

[![Stable Docs](https://img.shields.io/badge/docs-stable-blue.svg)](https://bhgomes.github.io/SubTypes.jl/stable)
[![Latest Docs](https://img.shields.io/badge/docs-latest-blue.svg)](https://bhgomes.github.io/SubTypes.jl/latest)
[![Travis Build Status](https://travis-ci.com/bhgomes/SubTypes.jl.svg?branch=master)](https://travis-ci.com/bhgomes/SubTypes.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/9q43kym8re2rw92f?svg=true)](https://ci.appveyor.com/project/bhgomes/subtypes-jl)
[![Formatting](https://img.shields.io/badge/format-tab%204%20margin%2096-888)](https://github.com/domluna/JuliaFormatter.jl)

[![GitHub Repo](https://img.shields.io/badge/repo-GitHub-black)](https://github.com/bhgomes/SubTypes.jl)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3525301.svg)](https://doi.org/10.5281/zenodo.3525301)

_Custom Subtyping in Julia_

</div>

## Installation

To install, run the following in a Julia session:

```julia
]add SubTypes
```

## Custom Subtype

To create a custom subtype define the following data

```
SubType{T, P, Ctx}
        ^  ^  ^
        |  |  |
        |  |  L ______ Type Context
        |  L _________ Predicate Data
        L ____________ Underlying Type
```

and a predicate processing function

```julia
check_predicate(P, Val(Ctx), x::T)
```

which checks if `x::T` should be of type `SubType{T, P, Ctx}`. The context `Ctx` is the way to mark the subtypes for overloading.

## Predefined Custom Subtypes

The custom subtypes `Constrained` and `ConstrainedSymbol` are predefined in the `SubType` module. They emulate set inclusion subtyping, i.e.

```julia
x::Constrained{T, S}  <=>  x.value::T in S
```

The `ConstrainedSymbol` type emulates set inclusion for `Symbol` types. The `Constrained` type is defined as follows:

```julia
const Constrained{T,S} = SubType{T,S,:Constrained}
```

Inspiration for this type comes from [this post](https://discourse.julialang.org/t/creating-custom-type-of-enumerations-of-symbols/18635/7) by Mohamed Tarek [@mohamed82008](https://github.com/mohamed82008).

## Helper Functions

This module also comes with these helper functions defined for terms and types:

| Helper Function | Component | Description |
|-----------------|-----------|-------------|
| `eltype` | `SubType{T} => T` | The underlying type where the subtype terms are drawn from. |
| `predicate` | `SubType{T,P} => P` | The predicate data which determines the subtype terms. |
| `context` | `SubType{T,P,Ctx} => Ctx` | The implementation label for the `check_predicate` function. |
| `support` | `Constrained{T,S} => S` | The underlying set where the constrained variables are constrained to. |

---
<div align="center">

#### [(UN)LICENSE](UNLICENSE)
Knowledge is Freedom.
</div>
