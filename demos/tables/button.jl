using GenieFramework
@genietools

@app begin
  @out count = 0

  @event :serverclick begin
    count += 1
  end
end

function ui()
  [
    textfield("", :count)
    button("Increment", :count, @on(:click, :serverclick))
  ]
end

@page("/", ui)