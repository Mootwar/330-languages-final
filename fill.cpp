#include <vector>
#include <cstddef>

int main() {
    std::vector<int> s(100000000); // 100 million elements
    // Fill the vector
    for (size_t i = 0; i < s.size(); ++i) {
        s[i] = static_cast<int>(i);
    }

    return 0;
}
