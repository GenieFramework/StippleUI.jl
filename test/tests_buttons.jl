@safetestset "Buttons test" begin

  @safetestset "Button Click Test" begin
    using HTTP
    using Playwright

    include("components/Buttons.jl")
    HTTP.get("http://127.0.0.1:8000/")

    @uitest p begin
      browser = p.firefox.launch(headless = false, slow_mo = 1000)
      page = browser.new_page()
      browser.close()
    end
  end
end