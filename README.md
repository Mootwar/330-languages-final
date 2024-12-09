# 330-languages-final
Final project repo for 330
## Notes
### MakeFile
- Compiles Nim and C++
- Nim is compiled in "safe" and dangerous mode
- Nim’s safe defaults provide a guarantee against out-of-bounds errors, but at the cost of checking each index access. This adds overhead in tight loops. Even with -d:release, Nim will remove many checks, but some checks might remain unless you use -d:danger or specific compiler options.
### Tests
- alloc_over test: The allocation overhead test measures how much time is spend on allocating and deallocating memory.
- call test: This is a trivial function call benchmark measures the overhead of repeatedly invoking a trivial function.
- fill test: This is a dynamic array fill benchmark measures the performance of dynamically allocating and filling a large vector
#### Citacion
- Alliance, Z. (Ed.). (n.d.). Andreas Rumpf at Nim workshop. YouTube. https://youtu.be/zb3Sqs7lNJo ​