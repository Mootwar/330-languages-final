let iterations = 100_000_000
for i in 0..<iterations:
  var myPtr = new int
  myPtr[] = myPtr[] + 1
  # Nim uses GC, so no explicit delete, but you can let the reference go out of scope

echo "Done"
