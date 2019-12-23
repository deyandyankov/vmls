using LinearAlgebra
using Statistics

x = rand(1:100, 100)
@assert sum(x) == dot(ones(Int64, length(x)), x)
mean(x[66:end])
sum(x) / length(x)
