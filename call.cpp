#include <iostream>

inline int trivialFunction(int x) {
    return x + 1; // Minimal work
}

int main() {
    volatile int sum = 0;
    const int iterations = 2000000000; // Two billion calls, adjust as needed
    for (int i = 0; i < iterations; ++i) {
        sum = trivialFunction(sum);
    }
    std::cout << sum << "\n";
    return 0;
}
