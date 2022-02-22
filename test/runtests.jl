cd(@__DIR__)

using Pkg

using Stipple, StippleUI
using Test, TestSetExtensions, SafeTestsets, Logging

Logging.global_logger(NullLogger())

@testset ExtendedTestSet "StippleUI tests" begin
  @includetests ARGS #[(endswith(t, ".jl") && t[1:end-3]) for t in ARGS]
end