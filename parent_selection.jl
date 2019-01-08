module ParentSelection

    function random_parent_selection(population)

        half_indices = Set(round.(Int, rand(length(population))))
        other_half = setdiff(Set(1:length(population)), half_indices)

    end

end # module ParentSelection
