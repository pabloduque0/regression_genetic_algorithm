include("./representation.jl")
include("./parent_selection.jl")
using .Representation, .ParentSelection

population_size = 100
n_kernels = 4
σ_initial = 1
λ_children = 100

population = Representation.generate_population(population_size, n_kernels, σ_initial)
println(population.members[1])

ParentSelection.random_parent_selection(population.members, λ_children)
