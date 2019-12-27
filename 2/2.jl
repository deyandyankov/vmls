# Example from p. 36
using LinearAlgebra
using Plots
using Test
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

# 2.5
A = [
    1 0
    1 -2
]
x = [1, 2]

A \ x
f(x) = [1., -.5]' * x
f([1, -1])
f([2, -2])

# 2.6
w1 = repeat([0, 1, 2], 15)
w2 = repeat([0, 2, 4], 15)
w = vcat(w1, w2)
v = 0
s(a) = w'*a + v

@test s(vcat(repeat([0, 1, 0], 15), repeat([0, 1, 0], 15))) == 15*1 + 15*2
@test s(vcat(repeat([0, 0, 1], 15), repeat([0, 1, 0], 15))) == 15*2 + 15*2
@test s(vcat(repeat([0, 0, 1], 15), repeat([0, 0, 1], 15))) == 15*2 + 15*4

# 2.9
@time begin
    f(x) = x[1] * x[2]
    dfdx1(x) = x[2]
    dfdx2(x) = x[1]
    z = [1, 1]
    f̂(x) = f(z) + dfdx1(z)*(x[1] - z[1]) + dfdx2(z)*(x[2] - z[2])
    #
    # or, more elegantly:
    using Calculus
    f̂(x) = f(z) + Calculus.gradient(f, z)'*(x - z)
    #
    compare_values = [
        [1, 1],
        [1.05, 0.95],
        [0.85, 1.25],
        [0.90, 1.10],
        [0, 0],
        [2, 2],
        [-1, 2]
    ]

    y = map(f, compare_values)
    ŷ = map(f̂, compare_values)
    @show y .- ŷ
end

# 2.12
@time begin
    n = 10
    Pcurr = [4.89, 1.15, 1.70, 1.52, 9.15, 1.62, 4.09, 0.76, 8.44, 6.59]
    Pnew = [4.89, 1.15, 1.70, 1.52, 9.30, 1.64, 4.09, 0.76, 8.44, 6.59]
    # Pnew = Pcurr
    x = (Pnew .- Pcurr) ./ Pcurr
    β = [0.36, 0.55, 0.9, 0.2, 1.89, 1.38, 0.78, 0.83, 0.79, 0.69]
    P = 100 # current profit with Pcurr prices
    P̂(x) = β'*x + P
    @show x[5], x[6]
    @show P, P̂(x)
    # 1% increase in products 5 and 6 result in 4% increase in overall profits
end
