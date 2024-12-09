#include <iostream>
#include <cstdlib>

int main() {
    const int iterations = 100000000; // 100 million allocations, adjust as needed
    for (int i = 0; i < iterations; ++i) {
        int* ptr = new int(i);
        // trivial use to prevent optimization
        *ptr = *ptr + 1;
        delete ptr;
    }
    std::cout << "Done\n";
    return 0;
}
