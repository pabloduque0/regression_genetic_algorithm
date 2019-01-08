module Recombination

    function intermediary_recombination()

    end

    function discrete_recombination(parents)
        child = Tuple{Float64, Float64, Float64}[]
        for nth_param in zip(parents...)
            new_kernel = tuple(nth_param[generate_index(length(parents))][1],
                                nth_param[generate_index(length(parents))][2],
                                nth_param[generate_index(length(parents))][3])
            push!(child, new_kernel)
        end

    end

    function generate_index(len_parents)
        return floor(rand() * len_parents) + 1
    end
end # module Recombination
