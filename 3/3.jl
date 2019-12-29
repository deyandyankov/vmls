using LinearAlgebra
using Distances
using Test

begin
    u = [1.8, 2.0, -3.7, 4.7]
    v = [0.6, 2.1, 1.9, -1.4]
    w = [2.0, 1.9, -4.0, 4.6]

    @test euclidean(u, v) ≈ norm(u - v)
end

# 3.1
begin
    n = 100
    x = rand([0, 1], n)
    y = rand([0, 1], n)
    d = sqrt(sum((x .- y).^2))
    @show x
    @show y
    @test d == euclidean(x, y)
    @test d <= n

end

# 3.2
begin
    n = 10
    m = 20
    a = rand(n)
    b = rand(m)

    rms(x) = sqrt(x'x) / sqrt(length(x))
    rms(a, b) = sqrt(a'a + b'b) / sqrt(length(a) + length(b))

    myavg(x) = sum(x) / length(x)
    myavg(a, b) = (sum(a) + sum(b)) / (length(a) + length(b))

    x = vcat(a, b)

    @test rms(x) ≈ rms(a, b)
    @test myavg(x) ≈ myavg(a, b)
end

# 3.3
begin
    for i in 1:100
        a = rand(10)
        b = rand(10)
        @test a'b == b'a
    end
end
