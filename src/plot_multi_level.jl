
abstract type CurvesNumber end
struct OneCurve <: CurvesNumber end
struct TwoCurves <: CurvesNumber end





f(x,y,a,b,t,L1,L2) = (x^2 + y^2 + a + b + t + L1 + L2 , L1 + L2)



curve_vars = ((id=6, value=[0.1,0.2,0.3]),(id=7, value=[0.4,0.5]))
params = ((id=1, value=0.1),(id=2, value=0.2),(id=3, value=0.3))
x_var = (id=5, value=5)
y_vars = ((name=:output1, id=1), (name=:output2, id=2))

function set_arg_values_params_x!(arg_values, params, x_var)
    # Set the value of the params
    for param in params
        arg_values[param.id] = param.value
    end
    # Set the value of the x variable
    arg_values[x_var.id] = x_var.value
    nothing
end

function test_call_fun(fun :: Function, x_var, y_vars, curve_vars, params,::TwoCurves) 
    number_of_variables = length(params) + length(x_var) + length(curve_vars)
    arg_values = zeros(number_of_variables)

    # Set the value of the params and x variables
    set_arg_values_params_x!(arg_values, params, x_var)

    # Set the value of the curve variables
    curve_ids = [curve_var.id for curve_var in curve_vars]
    curve_values = [curve_var.value for curve_var in curve_vars]

    for i in curve_values[1] 
        for j in curve_values[2]
            arg_values[curve_ids[1]] = i
            arg_values[curve_ids[2]] = j
            @show arg_values
            @show fun(arg_values...)
        end
    end
end


test_call_fun(f, x_var, y_vars, curve_vars, params,TwoCurves()) 


# ==================================================================================================


# ==================================================================================================


# ==================================================================================================
