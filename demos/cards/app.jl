using GenieFramework
@genietools

@app begin

end

ui() = begin
  card_1(; show_avatar = false, title = "Welcome to Genie", subtitle = "The best Julia Framework", content = "",
            buttons_component = nothing, menu_component = nothing, show_separator = false)
end

@page("/", ui)