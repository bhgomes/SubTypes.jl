# src/SubTypes.jl
# Custom subtyping in Julia

__precompile__(true)


"""
"""
module SubTypes

import Base: convert, eltype

export SubType, check_predicate, predicate, flag, Constrained, ConstrainedSymbol, support


"""
"""
struct SubType{T, P, Flag}
    value::T
    SubType{T}(x::T) where {T} = new{T, Any, nothing}(x)
    SubType{T, Any}(x::T) where {T} = new{T, Any, nothing}(x)
    function SubType{T, P, Flag}(x::T) where {T, P, Flag}
        check_predicate(P, Val(Flag), x)
        return new{T, P, Flag}(x)
    end
end


"""
"""
function check_predicate(P, _, x)
    throw(ArgumentError("$x does not match the predicate $P"))
end


"""
"""
convert(::Type{T}, x::SubType{T}) where {T} = x.value


"""
"""
eltype(::Type{SubType{T}}) where {T} = T


"""
"""
eltype(x::SubType) = eltype(typeof(x))


"""
"""
predicate(::Type{SubType{T, P}}) where {T, P} = P


"""
"""
predicate(x::SubType) = predicate(typeof(x))


"""
"""
flag(::Type{SubType{T, P, Flag}}) where {T, P, Flag} = Flag


"""
"""
flag(x::SubType) = flag(typeof(x))


"""
"""
const Constrained{T, S} = SubType{T, S, :Constrained}


"""
"""
const ConstrainedSymbol{S} = Constrained{Symbol, S}


"""
"""
function check_predicate(S, ::Val{:Constrained}, x::T) where {T}
    if !(x in S)
        throw("$x not in support $S")
    end
end


"""
"""
support(::Type{Constrained{T, S}}) where {T, S} = S


"""
"""
support(constrained::Constrained) = support(typeof(constrained))

end  # module SubTypes
