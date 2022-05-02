using SafeTestsets, Test

@safetestset "StippleUI tests" begin
  @safetestset "Button Tests" begin
    using Stipple, StippleUI
    using HTTP
    using Distributed
    using Playwright

    include("components/Buttons.jl")

    route("/") do
      Buttons.factory() |> Buttons.ui |> html
    end
    up()

    # trigger precompilation of Buttons.jl components for testing
    HTTP.get("http://127.0.0.1:8000/")

    x = "Hello"
    
    # run test with playwright.jl i.e. tests_buttons.jl
    t1 = `julia --project -e 'using Pkg; include("tests_buttons.jl")' $x` |> run
  end
end
