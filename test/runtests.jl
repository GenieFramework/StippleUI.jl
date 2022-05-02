using SafeTestsets, Test

@safetestset "StippleUI tests" begin
  @safetestset "Button Tests" begin
    using Stipple, StippleUI
    using HTTP
    using Distributed
    using Playwright

    include("components/Buttons.jl")
    # model = Buttons.factory() 
    # @info model.press_btn

    route("/") do
      Buttons.factory() |> Buttons.ui |> html
    end
    up()


    # t1 = `julia16 --project -e 'using Pkg; include("components/Buttons.jl")'` |> run
    # @sync `julia16 --project -e 'include("components/Buttons.jl")'` |> run
  
    # `open "http://127.0.0.1:8000/"` |> run
    HTTP.get("http://127.0.0.1:8000/")

    # BLOCK = quote
    #   browser = p.firefox.launch(headless = false, slow_mo = 1000)
    #   page = browser.new_page()
    #   page.goto("http://127.0.0.1:8000/")
    #   browser.close()
    # end

    # VAR = :p

    # ptest(VAR, BLOCK)

    x = "Hello"

    # include("tests_buttons.jl")
    t1 = `julia --project -e 'using Pkg; include("tests_buttons.jl")' $x` |> run
  end
end
