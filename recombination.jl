module Recombination
    using ..Representation
    # Recombination main function
    function apply_recombination(parents_groups, μ_parents, recombination_type)
        all_offspring = Representation.Organism[]
        for i in 1:div(length(parents_groups), μ_parents)
            parents_to_recombine = parents_groups[i : i + (μ_parents - 1)]
            group_offspring = recombine_parents_per_group(parents_to_recombine, μ_parents, recombination_type)
            push!(all_offspring, group_offspring...)
        end
        return all_offspring
    end
    # Recombination helper to generate parents groups to recombine
    function recombine_parents_per_group(parents_to_recombine, μ_parents, recombination_type)
        offspring = Representation.Organism[]
        for parent_idx in 1:length(parents_to_recombine[1])
            set_parents = [group[parent_idx] for group in parents_to_recombine]
            child = recombination_type(set_parents)
            push!(offspring, child)
        end
        return offspring
    end
    # Intermediary recombination
    function intermediary_recombination(parents)
        parents_kernels = [parent.gauss_kernels for parent in parents]
        child_kernels = Tuple{Float64, Float64, Float64}[]
        for nth_param in zip(parents_kernels...)
            first_param, second_param, third_param = get_kernel_params_byorder(nth_param)
            child_kernel = tuple(sum(first_param)/length(parents),
                                sum(second_param)/length(parents),
                                sum(third_param)/length(parents))
            push!(child_kernels, child_kernel)
        end
        prior_σs = [parent.σ for parent in parents]
        prior_αs = [parent.α for parent in parents]
        σ = [sum(parent) for parent in zip(prior_σs...)]/length(parents)
        α = [sum(parent) for parent in zip(prior_αs...)]/length(parents)

        child = Representation.Organism(child_kernels, σ, α, missing, missing)
        return child

    end

    function get_kernel_params_byorder(kernels)
        first_param, second_param, third_param = Float64[], Float64[], Float64[]
        for kernel in kernels
            push!(first_param, kernel[1])
            push!(second_param, kernel[2])
            push!(third_param, kernel[3])
        end
        return first_param, second_param, third_param
    end
    # Discrete recombination
    function discrete_recombination(parents)
        child_kernels = Tuple{Float64, Float64, Float64}[]
        parents_kernels = [parent.gauss_kernels for parent in parents]
        for nth_param in zip(parents_kernels...)
            new_kernel = tuple(nth_param[generate_index(length(parents))][1],
                                nth_param[generate_index(length(parents))][2],
                                nth_param[generate_index(length(parents))][3])
            push!(child_kernels, new_kernel)
        end
        σ = parents[generate_index(length(parents))].σ
        α = parents[generate_index(length(parents))].α
        child = Representation.Organism(child_kernels, σ, α, missing, missing)
        return child
    end

    function generate_index(len_parents)
        return ceil(Int, rand() * len_parents)
    end
end # module Recombination
