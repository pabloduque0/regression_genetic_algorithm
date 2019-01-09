module ParentSelection

    function random_parent_selection(population, λ)
        groups_indices = split_indices(length(population), λ)
        groups =
        for i in 1:size(group)[1]
            population[groups[i, :]]
    end

    function split_indices(population_length, λ)
        multiplier = ceil(Int, (λ * 2) / population_length)
        total_size = floor(Int, population_length * multiplier)
        group_size = div(total_size, population_length)
        all_indices = round.(Int, rand(total_size) * population_length)
        groups_indices = reshape(all_indices, (group_size, div(total_size, group_size)))
        return groups_indices

    end

end # module ParentSelection
