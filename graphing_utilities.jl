module GraphingUtilities
    using Statistics, Plots, ..Representation
    function plot_all(fitness_values::Array{Array{Float64, 1}, 1},
                        num_generations::Int, population::Representation.Population,
                        true_values::Array{Float64, 1}, x_values::Array{Float64, 1},
                        hit_ratios::Array{Array{Float64, 1}, 1},
                        population_size::Int64,
                        save_name::Union{Nothing, AbstractString})

        error_plot = plot(xlabel="Generation", ylabel="Error")
        plot_average_fitness!(fitness_values, num_generations)
        plot_max_fitness!(fitness_values, num_generations)
        func_plot = plot_both_functions(population, true_values, x_values)
        hit_ratio_plot = plot_metric(hit_ratios, num_generations, population_size,"Hit Ratio")
        if save_name != nothing
            savefig(error_plot, save_name * "_error.png")
            savefig(func_plot, save_name * "_funcs.png")
            savefig(hit_ratio_plot, save_name * "_hr.png")
        else
            display(error_plot)
            display(func_plot)
            display(hit_ratio_plot)
        end
    end

    function plot_metric(metric_values::Array{Array{Float64, 1}, 1},
                            num_generations::Int, population_size::Int64,
                            metric_name::AbstractString)
        averages = [mean(generation_values) for generation_values in metric_values]
        averages = averages / (population_size + 1)
        plot(1:num_generations, averages, lw=3,
                xlabel="Generation", ylabel=metric_name, label=metric_name)
    end

    function plot_average_fitness!(fitness_values::Array{Array{Float64, 1}, 1},
                                    num_generations::Int)
        averages = [mean(generation_fitvalues) for generation_fitvalues in fitness_values]
        plot!(1:num_generations, averages, lw=3,
                xlabel="Generation", ylabel="Error", label="Mean Fitness")
    end

    function plot_max_fitness!(fitness_values::Array{Array{Float64, 1}, 1},
                                num_generations::Int)
        minimums = [minimum(generation_fitvalues) for generation_fitvalues in fitness_values]
        plot!(1:num_generations, minimums, lw=3, label="Max fitness")
    end

    function plot_both_functions(population::Representation.Population,
                                 true_values::Array{Float64, 1},
                                 x_values::Array{Float64, 1})
        func_plot = plot(xlabel="X", ylabel="Y")
        fittest = sort(population.members, by=i->i.fitness)[end]
        pred_values = [kernels_to_values(x, fittest.gauss_kernels) for x in true_values]
        plot!(x_values, pred_values, lw=2, label="Pred function")
        plot!(x_values, true_values, lw=2, label="True function")
        return func_plot
    end

    function kernels_to_values(x::Float64,
                                kernels::Array{Tuple{Float64, Float64, Float64}, 1})
        sum = Float32(0.0)
        for kernel in kernels
            (weight, c, γ) = kernel
            sum += weight * exp(-γ*(c - x)^2)
        end
        return sum
    end

end
