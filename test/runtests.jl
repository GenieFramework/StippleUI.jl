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
