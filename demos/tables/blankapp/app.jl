module App
# set up Genie development environment
using GenieFramework
@genietools

# add your data analysis code
function mean(x)
    sum(x) / length(x)
end

# add reactive code to make the UI interactive
@app begin
    # reactive variables are tagged with @in and @out
    @in N = 0
    @out msg = "The average is 0."
    # @private defines a non-reactive variable
    @private result = 0.0

    # watch a variable and execute a block of code when
    # its value changes
    @onchange N begin
        # the values of result and msg in the UI will
        # be automatically updated
        result = mean(rand(N))
        msg = "The average is $result."
    end
end

# register a new route and the page that will be
# loaded on access
@page("/", "app.jl.html")
end
