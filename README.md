<div align="center">

# SubTypes.jl

[![Stable Docs](https://img.shields.io/badge/docs-stable-blue.svg?style=flat-square)](https://bhgomes.github.io/SubTypes.jl/stable)
[![Latest Docs](https://img.shields.io/badge/docs-latest-blue.svg?style=flat-square)](https://bhgomes.github.io/SubTypes.jl/latest)
[![Travis Build Status](https://img.shields.io/travis/bhgomes/SubTypes.jl.svg?style=flat-square)](https://travis-ci.com/bhgomes/SubTypes.jl)
[![Build status](https://img.shields.io/appveyor/ci/bhgomes/subtypes-jl?style=flat-square)](https://ci.appveyor.com/project/bhgomes/subtypes-jl)
[![Coveralls github](https://img.shields.io/coveralls/github/bhgomes/SubTypes.jl?style=flat-square)](https://coveralls.io/github/bhgomes/SubTypes.jl})
[![Formatting](https://img.shields.io/badge/format-tab%204%20margin%2096-888?style=flat-square)](https://github.com/domluna/JuliaFormatter.jl)

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

[![Author](https://img.shields.io/badge/Author-bhgomes-blue?style=for-the-badge)](https://github.com/bhgomes)
[![License](https://img.shields.io/badge/(UN)-LICENSE-lightgray?style=for-the-badge)](UNLICENSE)
[![GitHub Repo](https://img.shields.io/badge/repo-GitHub-black?style=for-the-badge)](https://github.com/bhgomes/SubTypes.jl)

</div>
