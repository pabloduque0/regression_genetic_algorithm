module Representation
    using Compat, Random, Distributions

    # Struct that represents a single organism
    mutable struct Organism
        genotype::Array{Float16, 1}
        phenotype::Array{Dict{String, Float16}, 1}
        c_range::Array{Float16, 1}
        σ::Array{Float16, 1}
        α::Array{Float16, 1}
    end
    # Struct that represents a population as a list of organisms
    mutable struct Population
        members::Array{Organism, 1}
    end

    function generate_population(args)
        normal_d = Normal(μ=0.0, σ=)
        c = rand(range(0.817, step=0.001, length=floor(Int, (1.0-0.817)/0.001) + 1))

    end
end  # module Population
