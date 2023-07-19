using Test

using StippleUI
using Stipple

@testset "Extensions" begin
    @test_throws MethodError DataTable()
    using DataFrames
    @test DataTable().data == DataFrame()

    df = DataFrame(:a => [1, 2, 3], :b => ["a", "b", "c"])
    dt = DataTable(df)
    dict = render(DataTable(df))
    dt_target = DataTable(deepcopy(df))
    empty!(dt_target.data)
    @test Stipple.convertvalue(R(dt_target), dict).data == dt.data
end

@testset "Parsers" begin
    doc_string = """<div>
        <q-input v-model="message"/>
                <br>
        <p> Message: {{message}}</p>
        <p> Vowel count: {{vowels}} vowels.</p>
    </div>"""
    
    result = """Stipple.Html.div([
        textfield("", :message, ),
        br(),
        p(
            "Message: {{message}}"
        ),
        p(
            "Vowel count: {{vowels}} vowels."
        )
    ])"""
    
    @test parse_vue_html(doc_string) == result
    
    result = """Stipple.Html.div([
        textfield("", :message, )
    
        br()
    
        p(
            "Message: {{message}}"
        )
    
        p(
            "Vowel count: {{vowels}} vowels."
        )
    ])"""
    
    @test parse_vue_html(doc_string, vec_sep = "\n\n") == result
    
    end