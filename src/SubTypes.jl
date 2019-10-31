# src/SubTypes.jl
# Custom Subtyping in Julia

__precompile__(true)

"""```
SubTypes
```
Custom Subtypes in Julia.
See https://github.com/bhgomes/SubTypes.jl for more details.
"""
module SubTypes

import Base: convert, eltype

export SubType, check_predicate, predicate, context, Constrained, ConstrainedSymbol, support


"""```
SubType{T, P, Ctx}
```
Subtype structure with underlying type `T`, predicate `P`, and context `Ctx`.
"""
struct SubType{T,P,Ctx}
    value::T
    SubType{T}(x::T) where {T} = new{T,Any,nothing}(x)
    SubType{T,Any}(x::T) where {T} = new{T,Any,nothing}(x)
    function SubType{T,P,Ctx}(x::T) where {T,P,Ctx}
        check_predicate(P, Val(Ctx), x)
        return new{T,P,Ctx}(x)
    end
end


"""```
check_predicate(P, Val(Ctx), x)
```
Check that `x` satisfies the predicate `P` in context `Ctx`.
"""
function check_predicate(P, ::Val{Ctx}, x) where {Ctx}
    throw(ArgumentError("`$x` does not match the predicate `$P` in context `$Ctx`"))
end


"""```
convert(::Type{T}, x::SubType{T}) === x.value
```
Convert a subtype value `x` to its underlying value `x.value`.
"""
convert(::Type{T}, x::SubType{T}) where {T} = x.value


"""```
eltype(::Type{SubType{T}}) === T
```
Return the underlying type of the `SubType` type.
"""
eltype(::Type{SubType{T}}) where {T} = T


"""```
eltype(x::SubType) === eltype(typeof(x))
```
Return the underlying type of the `SubType` value `x`.
"""
eltype(x::SubType) = eltype(typeof(x))


"""```
predicate(::Type{SubType{T, P}}) === P
```
Return the `predicate` of the `SubType` type.
"""
predicate(::Type{SubType{T,P}}) where {T,P} = P


"""```
predicate(x::SubType) === predicate(typeof(x))
```
Return the `predicate` of the `SubType` value `x`.
"""
predicate(x::SubType) = predicate(typeof(x))


"""```
context(::Type{SubType{T, P, Ctx}}) === Ctx
```
Return the `context` of the `SubType` type.
"""
context(::Type{SubType{T,P,Ctx}}) where {T,P,Ctx} = Ctx


"""```
context(x::SubType) === context(typeof(x))
```
Return the `context` of the `SubType` value `x`.
"""
context(x::SubType) = context(typeof(x))


"""```
Constrained{T, S} === SubType{T, S, :Constrained}
```
Constrained types emulate subset inclusion types. That is
`x::Constrained{T,S} <=> x.value::T in S`.
"""
const Constrained{T,S} = SubType{T,S,:Constrained}


"""```
ConstrainedSymbol{S} === Constrained{Symbol, S}
```
Constrained symbols are the constrained type of `Symbol`s.
"""
const ConstrainedSymbol{S} = Constrained{Symbol,S}


"""```
check_predicate(S, ::Val{:Constrained}, x::T)
```
Predicate check implementation for `Constrained` types.
"""
function check_predicate(S, ::Val{:Constrained}, x::T) where {T}
    if !(x in S)
        throw("$x not in support $S")
    end
end


"""```
support(::Type{Constrained{T, S}}) = S
```
Return the set which defines the predicate, i.e. the support of the
indicator function on `S`.
"""
support(::Type{Constrained{T,S}}) where {T,S} = S


"""```
support(constrained::Constrained) === support(typeof(constrained))
```
Return the set which defines the predicate, i.e. the support of the
indicator function on `S`.
"""
support(constrained::Constrained) = support(typeof(constrained))

end  # module SubTypes
