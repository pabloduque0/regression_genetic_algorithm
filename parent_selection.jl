module ParentSelection

    function random_parent_selection(population, λ)

        split_indices()

    end

    function split_indices(population_length, λ)
        multiplier = ceil(Int, (λ * 2) / population_length)
        total_size = population_length * multiplier
        group_size = total_size / (λ * 2)
        all_indices = round.(Int, rand(total_size))
        groups = reshape(1:total_size, (group_size, div(total_size, group_size)))
        return groups

    end

end # module ParentSelection
