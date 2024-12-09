import sequtils

# Create a large sequence of integers
var s = newSeq[int](1_000_000_00) # 100 million elements

# Fill the sequence
for i in 0..<s.len:
  s[i] = i
