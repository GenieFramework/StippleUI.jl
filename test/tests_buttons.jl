using Playwright, Test

@show ARGS

@uitest p begin
  browser = p.firefox.launch(headless = false, slow_mo = 1000)
  page = browser.new_page()
  page.goto("http://127.0.0.1:8000/")
  
  @test 1 == 1
  @test ARGS == ["Hello"]
  browser.close()
end
