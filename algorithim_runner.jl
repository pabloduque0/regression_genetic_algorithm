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

num_generations = 20
population_size = 41
n_kernels = 4
σ_initial = 1
λ_children = 200
μ_parents = 30
recombination_type = Recombination.intermediary_recombination
mutation_function = Mutation.uncorr_mutation_n_stepsize
error_function = Metrics.mean_sqr_error
threshold = 0.1
lower_weight = 1
upper_weight = 10
evaluate_function = FunctionsCollection.function1
x_range = (0, 4)
survivor_selection = SurvivorSelection.rank_selection
extra_params = Dict("threshold"=>threshold,
                    "lower_weight"=>lower_weight,
                    "upper_weight"=>upper_weight)


x_values = Utils.generate_linespace(x_range[1], x_range[2], population_size)
true_values = evaluate_function(x_values)
population = Representation.generate_population(population_size, n_kernels, σ_initial)
Metrics.calc_population_fitness!(population,
                                 true_values,
                                 error_function,
                                 extra_params)
fitness_values = Array{Float64, 1}[]
for i in 1:num_generations
    println("Generation: ", i)
    println("Selecting parents...")
    parents_groups = ParentSelection.random_parent_selection(population, λ_children,
                                                            μ_parents)
    println("Applying recombination...")
    offspring = Recombination.apply_recombination(parents_groups, μ_parents,
                                                recombination_type)
    println("Applying mutation")
    offspring_population = Representation.Population(offspring)
    mutated_population = mutation_function(offspring_population)
    println("Calculating fitness...")
    Metrics.calc_population_fitness!(mutated_population,
                                     true_values,
                                     error_function,
                                     extra_params)
    println("Selecting survivors...")
    next_generation = survivor_selection(mutated_population, μ_parents)
    push!(fitness_values, [member.fitness for member in next_generation.members])
    global population = next_generation
end

GraphingUtilities.plot_all(fitness_values, num_generations)
