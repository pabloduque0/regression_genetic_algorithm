module Metrics

    function mean_sqr_error(true_values::Array{Float64, 1}, pred_values::Array{Float64, 1})
        return sum((true_values - pred_values)^2)/length(true_values)
    end

    function mean_absolute_error(true_values::Array{Float64, 1}, pred_values::Array{Float64, 1})
        return sum(abs.(true_values - pred_values))/length(true_values)
    end

    function weighted_mean_abs_error(true_values::Array{Float64, 1},
                                    pred_values::Array{Float64, 1},
                                    threshold::Float64,
                                    lower_weight::Float64,
                                    upper_weight::Float64)

        abs_error = abs.(true_values - pred_values)
        mask = [apply_threshold(value, threshold,
                        lower_weight, upper_weight) for value in abs_error]
        return sum(abs_error*mask)/length(true_values)

    end

    function apply_threshold(value::Float64, threshold::Float64,
                                lower_weight::Float64, upper_weight::Float64)
        return values <= threshold ? lower_weight : upper_weight
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
