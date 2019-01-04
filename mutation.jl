module Mutation
    using Distributions, Random

    function uncorr_mutation_onestepsize(population::Population)
        constant = 1 / n^(1/2)
        t_value = rand(Normal(μ=0.0, σ=constant), 1)
        σ′ = σ * exp(constant*rand(Normal(μ=0.0, σ=1), 1))

        for member in population.members
            for kernel in member.gauss_kernels

            end
        end
    end

    function uncorr_mutation_n_stepsize(population::Population)

    end

end  # module Mutation
