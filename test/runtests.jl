using SafeTestsets

@safetestset "StippleUI tests" begin
  @safetestset "Button Tests" begin
    using Stipple, StippleUI
    using HTTP

    include("components/Buttons.jl")

    route("/") do
      html(Buttons.factory())
    end

    route("/hello") do
      "Hello World!"
    end

    up()

    # t2 = `julia --project -e 'include("components/Buttons.jl")'` |> run
    #`open "http://localhost:8000/"` |> run
    HTTP.get("http://127.0.0.1:8000/")
    HTTP.get("http://127.0.0.1:8000/hello")

    # include("tests_buttons.jl")
    t1 = `julia --project -e 'include("tests_buttons.jl")'` |> run
  end
end
