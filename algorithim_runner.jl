include("./representation.jl")
include("./parent_selection.jl")
include("./recombination.jl")
include("./mutation.jl")
include("./metrics.jl")

using .Representation, .ParentSelection, .Recombination, .Mutation, .Metrics

population_size = 100
n_kernels = 4
σ_initial = 1
λ_children = 100
μ_parents = 2
recombination_type = Recombination.intermediary_recombination
mutation_function = Mutation.uncorr_mutation_onestepsize
error_function = Metrics.mean_sqr_error

population = Representation.generate_population(population_size, n_kernels, σ_initial)
parents_groups = ParentSelection.random_parent_selection(population, λ_children,
                                                        μ_parents)
offspring = Recombination.apply_recombination(parents_groups, μ_parents,
                                            recombination_type)

offspring_population = Representation.Population(offspring)
mutated_population = mutation_function(offspring_population)

fitness = Metrics.calc_population_fitness(mutated_population,
                                            true_values,
                                            error_function)
