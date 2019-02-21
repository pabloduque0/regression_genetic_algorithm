# regression_genetic_algorithim

This repo is an approach to solving the known problem of regression using a evolutionary algorithm. More specifically using evolution strategy.

The approximation of the function is done by a sum of Gaussian kernels:

![approx_function](outputs/readme_resources/approx_function.gif)

where $ K_{G_i} $ is defined as:

![gauss_kernels](outputs/readme_resources/gauss_kernels.gif)

Then what we are trying to optimize is the set of parameters: 

![](outputs/readme_resources/parameters.gif)

To minimize the error of the pair:

![tuple](outputs/readme_resources/tuple.gif)



The following functions have been added as a sample:

Function1:

![f1](outputs/readme_resources/f1.gif)

Function2:

![f2](outputs/readme_resources/f2.gif)

Function3:

![f3](outputs/readme_resources/f3.gif)

Function4:

![f4](outputs/readme_resources/f4.gif)

Function5:

![](outputs/readme_resources/f5.gif)



We are using the following error:

<img src="outputs/readme_resources/error.png" width="350">



However mean squared error and absolute mean error are available in the code as well.



| Predicted function vs True function   | Mean and max fitness per generation   |
| ------------------------------------- | ------------------------------------- |
| ![](outputs/experiment_1_4_funcs.png) | ![](outputs/experiment_1_4_error.png) |
| ![](outputs/experiment_3_2_funcs.png) | ![](outputs/experiment_3_2_error.png) |
| ![](outputs/experiment_3_3_funcs.png) | ![](outputs/experiment_3_3_error.png) |
| ![](outputs/experiment_3_4_funcs.png) | ![](outputs/experiment_3_4_error.png) |
| ![](outputs/experiment_3_5_funcs.png) | ![](outputs/experiment_3_5_error.png) |
|                                       |                                       |

Since the error we are using allows to track a pseudo hit ratio, here are the outputs of such metric for all 5 functions:

| Function  | Hit ratios for fittest             |
| --------- | ---------------------------------- |
| Function1 | ![](outputs/experiment_1_4_hr.png) |
|           |                                    |
| Function2 | ![](outputs/experiment_3_2_hr.png) |
| Function3 | ![](outputs/experiment_3_3_hr.png) |
| Function4 | ![](outputs/experiment_3_4_hr.png) |
| Function5 | ![](outputs/experiment_3_5_hr.png) |



### Demo

The file `algo_params.json` contains the parametrization of the algorithm.

```
{
	"num_runs": 10,
	"num_generations": 40,
	"population_size": 41,
	"n_kernels": 4,
	"σ_initial": 1,
	"λ_children": 200,
	"μ_parents": 30,
	"recombination_type": "discrete_recombination",
	"mutation_type": "uncorr_mutation_n_stepsize",
	"error_function": "weighted_mean_abs_error",
	"threshold": 0.1,
	"lower_weight": 1.0,
	"upper_weight": 10.0,
	"evaluate_function": "function1",
	"x_range": [-1, 3],
	"survivor_selection": "all"
	"output_file": ""
}

```

Change the parameters desired and then run `algo_runner.jl`.

Error, functions and hit ratio graphs will be generated under the folder `outputs/` and then given the name in the parameters as `output_file`. If empty or blank spaces, graphs wont be saved and will be displayed instead.