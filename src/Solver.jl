module Solver

using TSPLIB
using Random

export Problem, Algorithm_, Tsp, Qkp, Random_, NearestInsertion, NearestNeighbor, get_problem, get_algorithm, evaluate, is_valid

# Tipos Abstratos

abstract type Problem end
struct Tsp <: Problem end
struct Qkp <: Problem end

abstract type Algorithm_ end
struct Random_ <: Algorithm_ end
struct NearestNeighbor <: Algorithm_ end
struct NearestInsertion <: Algorithm_ end

# Lê o problema baseado no tipo

get_problem(::Tsp, file_name::String) = readTSP(file_name)
get_problem(::Qkp, file_name::String) = readQKP(file_name)

readQKP(file_name::String) = throw("QKP ainda não foi definida")

# Seleciona o algoritmo baseado no tipo

## Problema Tsp

### Random
function get_algorithm(::Tsp, ::Random_)
    return function (problem::TSPLIB.TSP)
        shuffle(1:size(problem.nodes, 1) |> collect)
    end
end

### NearestNeighbor
function get_algorithm(::Tsp, ::NearestNeighbor)
    return function (problem)
        throw("Ainda não foi definida")
    end
end

### NearestInsertion
function get_algorithm(::Tsp, ::NearestInsertion)
    return function (problem)
        throw("Ainda não foi definida")
    end
end

## Problema Tsp

### Random
function get_algorithm(::Qkp, ::Random_)
    return function (problem)
        throw("Ainda não foi definida")
    end
end

### NearestNeighbor
function get_algorithm(::Qkp, ::NearestNeighbor)
    return function (problem)
        throw("Ainda não foi definida")
    end
end

### NearestInsertion
function get_algorithm(::Qkp, ::NearestInsertion)
    return function (problem)
        throw("Ainda não foi definida")
    end
end

# Calcula o custo total da solução
function evaluate(problem::TSPLIB.TSP, solution::Vector{Int64})::Float64
    cost::Float64 = 0
    for i in eachindex(solution)
        cost += problem.weights[solution[i], solution[((i+1)%problem.dimension)+1]]
    end
    return cost
end

# Valida a solução
function is_valid(problem::TSPLIB.TSP, solution::Vector{Int64})
    equal_dimension = length(solution) == problem.dimension
    equal_nodes = sort(collect(Set(solution))) == sort(collect(Set(collect(1:size(problem.nodes, 1)))))
    return equal_dimension && equal_nodes
end

function Base.convert(::Type{Problem}, x::AbstractString)
    if x == "tsp"
        Tsp()
    elseif x == "qkp"
        Qkp()
    else
        throw(ArgumentError("Valor inválido para Problem: $x"))
    end
end

function Base.convert(::Type{Algorithm_}, x::AbstractString)
    if x == "1"
        Random_()
    elseif x == "2"
        NearestNeighbor()
    elseif x == "3"
        NearestInsertion()
    else
        throw(ArgumentError("Valor inválido para Algorithm_: $x"))
    end
end


end
