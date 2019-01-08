module Mutation
    using Distributions, Random

    function uncorr_mutation_onestepsize(population::Population)
        constant = 1 / n^(1/2)
        t_value = rand(Normal(0.0, constant), 1)[1]
        σ′ = σ * exp(constant*rand(Normal(0.0, 1), 1)[1])

        for member in population.members
            gauss_kernels = Array{Tuple{Float64, Float64, Float64}, 1}[]
            for kernel in member.gauss_kernels
                new_kernel = tuple([mutate_param(param, σ′) for param  in kernel]...)
                push!(gauss_kernels, new_kernel)
            end
            member.gauss_kernels = gauss_kernels
        end
    end

    function mutate_param(param, σ′)
        return param + σ′ * rand(Normal(0.0, 1), 1)[1]
    end

    function uncorr_mutation_n_stepsize(population::Population)

    end

end  # module Mutation
