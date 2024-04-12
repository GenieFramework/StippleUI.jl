using GenieFramework
@genietools

@app begin
    @in say_hi = false
    @onchange say_hi println("Hi!")
end

ui() = button("Hi", @click("say_hi = !say_hi"))
@page("/", ui)

up()