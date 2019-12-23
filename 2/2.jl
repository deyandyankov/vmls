# Example from p. 36
using LinearAlgebra
using Plots
f(x) = x[1] + exp(x[2] - x[1])
z = [1, 2]
grad_f(z) = [1 - exp(z[2] - z[1]); exp(z[2] - z[1])]
grad_f(z)
f(z)
f̂(x) = f(z) + grad_f(z)' * (x - z)

x = [
    [1., 2.],
    [.96, 1.98],
    [1.1, 2.11],
    [.85, 2.05],
    [1.25, 2.41]
]
y = f.(x)
ŷ = f̂.(x)
errors = abs.(ŷ - y)
plot(1:length(x), y)
plot!(1:length(x), ŷ)

A = [
  10 10 10 1
  100 10 10 1
  10 100 10 1
  10 10 100 1
]
x = [30, 60, 75, 65]

coefs = A\x

a = coefs[1:end-1]
b = coefs[end]

@show a, b
f(P) = a'*P + b

@assert f([10, 10, 10]) == 30
@assert f([100, 10, 10]) == 60
@assert f([10, 100, 10]) == 75
@assert f([10, 10, 100]) == 65

function establish_same(max_power_output)
    same = 0
    P = [same, same, same]
    while f(P) <= max_power_output
        same += 1
        P = [same, same, same]
    end
    same
end
@show establish_same(85)

# 2.4
A = [
    1 1 0
    -1 1 1
    1 -1 -1
]
x = [-1, 1, 1]
A \ x
