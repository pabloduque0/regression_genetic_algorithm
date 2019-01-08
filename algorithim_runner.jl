include("./representation.jl")
using .Representation

population_size = 100
n_kernels = 4
σ_initial = 1
Representation.generate_population(population_size, n_kernels, σ_initial)
