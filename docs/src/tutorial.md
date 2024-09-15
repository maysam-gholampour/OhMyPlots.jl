Tutorial: Testing Variables and Curves with OhMyPlots.jl in Julia
# Tutorial: Using OhMyPlots.jl in Julia

OhMyPlots.jl is a Julia package designed to handle scientific plotting, particularly with variables that require LaTeX-style labels and annotations. This tutorial will guide you through the process of working with key types in OhMyPlots, such as Var and CurveVar, as well as how to plot data effectively.

## 1. Installing OhMyPlots.jl

Before you can use OhMyPlots, you need to install it. To do this, use Julia’s package manager.

```julia
using Pkg
Pkg.add("OhMyPlots")
```

Once installed, you can load the package with:

```julia
using OhMyPlots
```

## 2. Working with the Var Type

The Var type is a core component of OhMyPlots. It is designed to represent variables with names, units, and values.

### Creating a Var Instance

The Var type accepts three arguments:

- `name`: The name of the variable, typically written in LaTeX form.
- `unit`: The unit of the variable, also written in LaTeX.
- `value`: The value, which can be a scalar or a vector.

**Example 1: Integer Range Variable**

```julia
name = L"X"  # LaTeX string for the variable name
unit = L"[m]"  # LaTeX string for the unit (meters)
value = 1:100  # A range of values for the variable

var = Var(name, unit, value)
```

This creates a variable X with a unit of meters and values ranging from 1 to 100.

**Example 2: Floating-Point Range**

```julia
value = 1.0:100.0  # A floating-point range for the variable
var = Var(name, unit, value)
```

### Working with LaTeX Strings

Both the variable name and unit can be represented in LaTeX format using the LaTeXStrings.jl package, which is integrated into OhMyPlots.

```julia
using LaTeXStrings

name = L"\alpha"
unit = L"[s^{-1}]"
value = [1, 2, 3]

var = Var(name, unit, value)
```

This will create a variable with the name α and unit s⁻¹.

## 3. Plotting with CurveVar

The CurveVar type is useful for associating a label (or legend) with a variable in a plot.

### Creating a CurveVar Instance

CurveVar takes a legend argument, which is typically a LaTeX string for better presentation in plots.

```julia
legend = L"legend"
curve_var = CurveVar(legend)
```

### Plotting the Variable

To plot a variable, you would typically use Makie or another plotting library. Here’s an example of how to use OhMyPlots with a plotting library to visualize data.

```julia
using CairoMakie

# Create a figure and axis
fig = Figure()
ax = Axis(fig[1, 1], title = "Plot Example")

# Plot the data
lines!(ax, 1:100, sin.(1:100), label = L"\sin(x)")

# Add a legend
legend = Legend(fig, ax, "My Plot Legend", position = :rb)

# Display the plot
display(fig)
```

## 4. Managing Plot Attributes

With OhMyPlots, you can control various plot attributes such as:

- Line colors
- Line styles
- Markers
- Legends

For example, customizing the line style and adding markers:

```julia
lines!(ax, 1:100, sin.(1:100); label = L"sin(x)", linestyle = :dash, marker = :circle)
```

## 5. Saving Your Plots

You can save your plot to a file using the save function.

```julia
save("my_plot.png", fig)
```

You can adjust the resolution for publication-quality images:

```julia
save("my_plot.png", fig, dpi = 300)
```

## 6. Conclusion

This tutorial provides a basic introduction to working with the OhMyPlots package in Julia. You’ve learned how to create and manipulate variables using the Var and CurveVar types, as well as how to use LaTeX strings to create scientifically accurate labels and units. Additionally, you saw how to plot and customize visualizations using CairoMakie alongside OhMyPlots.

For more advanced usage and options, refer to the official documentation of OhMyPlots and related plotting libraries like CairoMakie.
