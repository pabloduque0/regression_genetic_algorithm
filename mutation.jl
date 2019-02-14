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
                                                        member.α,
                                                        missing)
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

    function generate_tau_values(population_length)
        τ = 1 / ((2 * population_length)^(1/2))
        τ′ = 1 / ((2 * (population_length^(1/2)))^(1/2))
        return τ, τ′
    end

    function generate_new_sigma_nsteps(σ, τ, τ′)
        return σ * exp(τ * rand(Normal(0.0, 1), 1)[1] + τ′ * rand(Normal(0.0, 1), 1)[1])
    end

    function uncorr_mutation_n_stepsize(population::Representation.Population)
        τ, τ′ = generate_tau_values(length(population.members))
        new_members = Organism[]
        for member in population.members
            new_gauss_kernels = Tuple{Float64, Float64, Float64}[]
            new_sigmas = Float64[]
            for (index, kernel) in enumerate(member.gauss_kernels)
                new_kernel = Float64[]
                for (param, σ) in zip(kernel, member.σ[((index - 1) * 3) + 1:(index-1) * 3 + 3])
                    σ′ = generate_new_sigma_nsteps(σ, τ, τ′)
                    push!(new_kernel, mutate_param(param, σ′))
                    push!(new_sigmas, σ′)
                end
                push!(new_gauss_kernels, tuple(new_kernel...))
            end
            mutated_organism = Representation.Organism(new_gauss_kernels,
                                                        new_sigmas,
                                                        member.α,
                                                        missing,
                                                        missing)
            push!(new_members, mutated_organism)
        end
        return Representation.Population(new_members)
    end

end  # module Mutation
