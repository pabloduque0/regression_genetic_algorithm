module ParentSelection
    function random_parent_selection(population, λ, μ_parents, output_type)
        groups_indices = split_indices(length(population.members), λ, μ_parents)
        groups = Array{output_type, 1}[]
        n_groups = ceil(Int, (μ_parents * λ) / length(population.members))
        for i in 1:n_groups
            group = population.members[groups_indices[i, :]]
            push!(groups, group)
        end
        return groups
    end

    function split_indices(population_length, λ, μ_parents)
        multiplier = ceil(Int, (λ * μ_parents) / population_length)
        total_size = floor(Int, population_length * multiplier)
        group_size = div(total_size, population_length)
        all_indices = ceil.(Int, rand(total_size) * population_length)
        groups_indices = reshape(all_indices, (group_size, div(total_size, group_size)))
        return groups_indices

    end

end # module ParentSelection
