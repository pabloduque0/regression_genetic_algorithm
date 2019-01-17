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
end
