var sum = 0
let iterations = 2000000000
proc trivialFunction(x: int): int =
  return x + 1

for i in 0..<iterations:
  sum = trivialFunction(sum)

echo sum
