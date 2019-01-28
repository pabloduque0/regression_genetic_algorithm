module FunctionsCollection

    function function1(x)
        return 2 * exp.(-2 * (x .- 1).^2) .- exp.(-(x .- 1).^2)
    end

    function function2(x)
        return x.^(1/2)
    end

    function function3(x)
        return exp.(-x) .* sin.(2 * x)
    end

    function function4(x)
        return log.(log.(x))
    end

    function function5(x)
        return 6 * exp.(-2 * x) + 2 * sin.(x) - cos.(x)
    end
    
end # FunctionsCollection
