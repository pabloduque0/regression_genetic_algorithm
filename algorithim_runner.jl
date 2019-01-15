include("./representation.jl")
include("./parent_selection.jl")
include("./recombination.jl")

using .Representation, .ParentSelection, .Recombination

population_size = 100
n_kernels = 4
σ_initial = 1
λ_children = 100
μ_parents = 2

population = Representation.generate_population(population_size, n_kernels, σ_initial)
parents_groups = ParentSelection.random_parent_selection(population, λ_children,
                                                        μ_parents)
offspring = Recombination.apply_recombination(parents_groups, μ_parents,
                                            Recombination.discrete_recombination)
