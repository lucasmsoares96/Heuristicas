module Heuristicas

using ArgParse
using Random
include("./Solver.jl")
using .Solver

function main()
    args = parse_commandline()
    # args = Dict(
    #     "arquivo" => "Tnm52.tsp",
    #     "problema" => "tsp",
    #     "algoritmo" => "1",
    #     "seed" => "0",
    # )
    file = args["arquivo"]
    type_problem = args["problema"]
    seed = parse(Int64, args["seed"])
    type_algorithm = args["algoritmo"]
    Random.seed!(seed)

    problem = get_problem(type_problem, file)
    algorithm = get_algorithm(type_problem, type_algorithm)

    solution = problem |> algorithm
    println("Solução:\t $solution")
    cost = evaluate(problem, solution)
    println("Custo:\t\t $cost")
    is_valid = Solver.is_valid(problem, solution)
    println("É valída?\t $is_valid")
end

function parse_commandline()::Dict{String,Any}
    s = ArgParseSettings()
    @add_arg_table s begin
        "--problema", "-p"
        help = "Tipo de problema a ser resolvido. Pode ser 'tsp' ou 'qkp'."
        arg_type = Problem
        required = true

        "--algoritmo", "-a"
        help = "Algoritmo a ser usado. Pode ser 'random', 'nearestneighbor' ou 'nearestinsertion'."
        arg_type = Algorithm_
        required = true

        "--seed", "-s"
        help = "Semente de números aleatórios"
        required = true
        default = 0

        "arquivo"
        help = "Entrada de dados"
        required = true
    end
    return parse_args(s)
end

# @run main()

end # module Heuristicas
