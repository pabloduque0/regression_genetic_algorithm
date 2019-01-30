module Utils
    using JSON, ..Metrics, ..Mutation, ..Recombination, ..FunctionsCollection
    function get_algo_params()
        file_path = pwd() * "/algo_inputs.txt"
        print(read(file_path, String))
        parameters = JSON.parse(read(file_path, String))
        parameters["error_function"] = select_error_function(parameters["error_function"])
        parameters["recombination_type"] = select_recombination_type(parameters["recombination_type"])
        parameters["mutation_type"] = select_mutation_type(parameters["mutation_type"])
        parameters["evaluate_function"] = select_evaluate_function(parameters["evaluate_function"])

        return parameters
    end

    function select_evaluate_function(evaluate_function)
        if evaluate_function[end] == '1'
            return FunctionsCollection.function1
        elseif evaluate_function[end] == '2'
            return FunctionsCollection.function2
        elseif evaluate_function[end] == '3'
            return FunctionsCollection.function3
        elseif evaluate_function[end] == '4'
            return FunctionsCollection.function4
        elseif evaluate_function[end] == '5'
            return FunctionsCollection.function5
        else
            throw(ArgumentError("Function to evaluate requested not available. Options are:
                                function1, function2, function3, function4, function5"))
        end
    end

    function select_error_function(error_function)
        if error_function == "mean_sqr_error"
            return Metrics.mean_sqr_error
        elseif error_function == "mean_absolute_error"
            return Metrics.mean_absolute_error
        elseif error_function == "weighted_mean_abs_error"
            return Metrics.weighted_mean_abs_error
        else
            throw(ArgumentError("Error function requested not available. Options are: mean_sqr_error,
                                mean_absolute_error, weighted_mean_abs_error"))
        end
    end

    function select_recombination_type(recombination_type)

        if recombination_type == "intermediary_recombination"
            Recombination.intermediary_recombination
        elseif recombination_type == "discrete_recombination"
            Recombination.discrete_recombination
        else
            throw(ArgumentError("Recombination type requested not available. Options are:
                                intermediary_recombination, discrete_recombination"))
        end
    end

    function select_mutation_type(mutation_type)
        if mutation_type == "uncorr_mutation_onestepsize"
            return Mutation.uncorr_mutation_onestepsize
        elseif mutation_type == "uncorr_mutation_n_stepsize"
            return Mutation.uncorr_mutation_n_stepsize
        else
            throw(ArgumentError("Mutation type requested not available. Options are:
                                uncorr_mutation_onestepsize, uncorr_mutation_n_stepsize"))
        end

    end

    function generate_linespace(min, max, n_values)
        step = (max-min)/n_values
        return collect(min:step:max)
    end

end
