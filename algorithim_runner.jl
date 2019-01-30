include("./representation.jl")
include("./parent_selection.jl")
include("./recombination.jl")
include("./mutation.jl")
include("./metrics.jl")
include("./functions_collection.jl")
include("./utils.jl")
include("./survivor_selection.jl")
include("graphing_utilities.jl")

using .Representation, .ParentSelection, .Recombination, .Mutation, .Metrics, .FunctionsCollection
using .SurvivorSelection, .Utils, Statistics, .GraphingUtilities

parameters =  Utils.get_algo_params()
x_values = Utils.generate_linespace(parameters["x_range"][1], parameters["x_range"][2], parameters["population_size"])
true_values = parameters["evaluate_function"](x_values)
population = Representation.generate_population(parameters["population_size"], parameters["n_kernels"], parameters["σ_initial"])
extra_params_error = Dict("threshold"=>parameters["threshold"],
                        "lower_weight"=>parameters["lower_weight"],
                        "upper_weight"=>parameters["upper_weight"])

Metrics.calc_population_fitness!(population,
                                 true_values,
                                 parameters["error_function"],
                                 extra_params_error)
fitness_values = Array{Float64, 1}[]
for i in 1:parameters["num_generations"]
    println("Generation: ", i)
    println("Selecting parents...")
    parents_groups = ParentSelection.random_parent_selection(population, parameters["λ_children"],
                                                            parameters["μ_parents"])
    println("Applying recombination...")
    offspring = Recombination.apply_recombination(parents_groups, parameters["μ_parents"],
                                                parameters["recombination_type"])
    println("Applying mutation")
    offspring_population = Representation.Population(offspring)
    mutated_population = parameters["mutation_function"](offspring_population)
    println("Calculating fitness...")
    Metrics.calc_population_fitness!(mutated_population,
                                     true_values,
                                     parameters["error_function"],
                                     extra_params_error)
    println("Selecting survivors...")
    next_generation = parameters["survivor_selection"](mutated_population, parameters["μ_parents"])
    push!(fitness_values, [member.fitness for member in next_generation.members])
    global population = next_generation
end

GraphingUtilities.plot_all(fitness_values, parameters["num_generations"])
