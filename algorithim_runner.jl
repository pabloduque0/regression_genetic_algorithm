include("./representation.jl")
include("./parent_selection.jl")
include("./recombination.jl")
include("./mutation.jl")

using .Representation, .ParentSelection, .Recombination, .Mutation
population_size = 100
n_kernels = 4
σ_initial = 1
λ_children = 100
μ_parents = 2
recombination_type = Recombination.intermediary_recombination
mutation_function = Mutation.uncorr_mutation_onestepsize

population = Representation.generate_population(population_size, n_kernels, σ_initial)
parents_groups = ParentSelection.random_parent_selection(population, λ_children,
                                                        μ_parents)
offspring = Recombination.apply_recombination(parents_groups, μ_parents,
                                            recombination_type)
#println(population.members[1], "  -  ", offspring[1])
offspring_population = Representation.Population(offspring)
mutated_population = mutation_function(offspring_population)
