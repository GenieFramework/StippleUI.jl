using GenieFramework
@genietools

@app begin
  @in number = 0
  @out double = 0
  @out triple = 0
  @out quadruple = 0

  @onchange number begin
    double, triple, quadruple = compute(number)
  end
end

function compute(number)
  (double = 2number, triple = 3number, quadruple = 4number)
end

function ui()
  [
    textfield("", :number)
    textfield("", :double)
    textfield("", :triple)
    textfield("", :quadruple)
  ]
end

@page("/", ui)