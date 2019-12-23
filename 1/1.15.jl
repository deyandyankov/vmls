# Cheapest supplier
using LinearAlgebra
q = [10, 15, 20, 35, 5, 8, 12]
K = [
    [100, 2, 3, 4, 5, 6, 7],
    [1, 1, 1, 5, 10, 15, 20],
    [10, 20, 5, 8, 1, 1, 1]
]

# how to get cheapest overall order?
order_totals = []
for k in 1:length(K)
    append!(order_totals, dot(q, K[k]))
end

cheapest_price, cheapest_supplier = findmin(order_totals)
println("Cheapest supplier is ", cheapest_supplier, " at ", cheapest_price)

# if we want to split this into two suppliers, then perhaps we can get
# differences between best supplier's prices and other suppliers
# then see which is the one that offers most products at a discounted rate
for k in 1:length(K)
    diff_price = K[k] - K[cheapest_supplier]
    cheaper_products = map(x -> x >= 0 ? 0 : 1, diff_price)
    println(cheaper_products)
end

# therefore we can use supplier 1 for products 4:7 or supplier 3 for products 5:7
# while purchasing products 1:3 or 1:4 from supplier 3
# not the best strategy but it's something.
