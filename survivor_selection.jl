module SurvivorSelection
    using ..Representation
    # Rank selection for (μ + λ)
    function rank_selection(offspring::Representation.Population,
                                parents::Representation.Population, μ_selected::Int)
        sorted_population = sort([offspring.members; parents.members], by=i->i.fitness)
        return Representation.Population(sorted_population[1:μ_selected])
    end
    # Rank selection for (μ, λ)
    function rank_selection(offspring::Representation.Population, μ_selected::Int)
        sorted_population = sort(offspring.members, by=i->i.fitness)
        return Representation.Population(sorted_population[1:μ_selected])
    end

end # module SurvivorSelection
