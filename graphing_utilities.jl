module GraphingUtilities
    using Statistics, Plots
    function plot_average_fitness(fitness_values::Array{Array{Float64, 1}, 1},
                                    num_generations::Int)
        averages = [mean(generation_fitvalues) for generation_fitvalues in fitness_values]
        plot(1:num_generations, averages, lw=3)
    end

    function plot_max_fitness(fitness_values::Array{Array{Float64, 1}, 1})
        maxes = [max(generation_fitvalues) for generation_fitvalues in fitness_values]
        plot(1:num_generations, maxes, lw=3)
    end

end
