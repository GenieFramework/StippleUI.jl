using Playwright, Test

@uitest p begin
  browser = p.firefox.launch(headless = false, slow_mo = 1000)
  page = browser.new_page()
  page.goto("http://localhost:8000/")
  browser.close()
end
