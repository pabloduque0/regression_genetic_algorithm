module SurvivorSelection
    using ..Representation
    function rank_selection(offspring::Representation.Population,
                                parents::Representation.Population, μ_selected::Int)
        sorted_population = sort([offspring.members; parents.members], by=i->i.fitness)
        return Representation.Population(sorted_population[1:μ_selected])
    end

    function rank_selection(offspring::Representation.Population, μ_selected::Int)
        sorted_population = sort(offspring.members, by=i->i.fitness)
        return Representation.Population(sorted_population[1:μ_selected])
    end

end # module SurvivorSelection
