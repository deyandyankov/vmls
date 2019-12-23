T = 13
r = .0137
c = zeros(T)
d = ones(T)
for i in 2:T
    d[i] = 1/(1+r)^i
end
c[1] = 5000
c[T] = 5000 * r

c
d

dot(d, c)

c
