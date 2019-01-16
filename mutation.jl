module Mutation
    using ..Representation
    using Distributions, Random

    function uncorr_mutation_onestepsize(population::Representation.Population)
        t_value = generate_t_value(length(population.members))
        new_members = Organism[]
        for member in population.members
            σ′ = generate_new_sigma(member.σ, t_value)
            new_gauss_kernels = Tuple{Float64, Float64, Float64}[]
            for kernel in member.gauss_kernels
                new_kernel = tuple([mutate_param(param, σ′[1]) for param  in kernel]...)
                push!(new_gauss_kernels, new_kernel)
            end
            mutated_organism = Representation.Organism(new_gauss_kernels,
                                                        σ′,
                                                        member.α)
            push!(new_members, mutated_organism)
        end
        return Representation.Population(new_members)
    end

    function generate_t_value(population_length)
        constant = 1 / population_length^(1/2)
        return rand(Normal(0.0, constant), 1)[1]
    end

    function mutate_param(param, σ′)
        return param + σ′ * rand(Normal(0.0, 1), 1)[1]
    end

    function generate_new_sigma(σ, t_value)
        return σ * exp(t_value*rand(Normal(0.0, 1), 1)[1])
    end

    function uncorr_mutation_n_stepsize(population::Representation.Population)
        t_value = generate_t_value(length(population.members))
        for member in population.members
            gauss_kernels = Tuple{Float64, Float64, Float64}[]
            for (index, kernel) in enumerate(member.gauss_kernels)
                new_kernel = Float64[]
                for (param, σ) in zip(kernel, member.σ[((index-1)*3)+1:(index*3)+3])
                    σ′ = generate_new_sigma(σ, t_value)
                    push!(new_kernel, mutate_param(param, σ′))
                end
                push!(gauss_kernels, tuple(new_kernel...))
            end
            member.gauss_kernels = gauss_kernels
        end
    end

end  # module Mutation
