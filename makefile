# Makefile

NIM_SOURCES := $(wildcard *.nim)
CPP_SOURCES := $(wildcard *.cpp)

# Executables for Nim in normal release mode and danger mode
NIM_SAFE_EXECUTABLES := $(NIM_SOURCES:.nim=.nim.safe.out)
NIM_DANGER_EXECUTABLES := $(NIM_SOURCES:.nim=.nim.danger.out)

CPP_EXECUTABLES := $(CPP_SOURCES:.cpp=.cpp.out)

.PHONY: all safe_nim danger_nim run_nim_safe run_nim_danger run_cpp clean

# Build all variants
all: safe_nim danger_nim $(CPP_EXECUTABLES)

# Build Nim executables in normal release mode
safe_nim: $(NIM_SAFE_EXECUTABLES)

# Build Nim executables in danger mode
danger_nim: $(NIM_DANGER_EXECUTABLES)

# Compile Nim in release mode (no danger)
%.nim.safe.out: %.nim
	@start=$$(date +%s%N); \
	nim c -d:release -o:$@ $<; \
	end=$$(date +%s%N); \
	ns=$$((end - start)); \
	seconds=$$(awk -v x=$$ns 'BEGIN {printf "%.9f", x/1000000000}'); \
	echo "Compile time (safe): $$ns ns ($$seconds s)" > $@.compile

# Compile Nim in danger mode
%.nim.danger.out: %.nim
	@start=$$(date +%s%N); \
	nim c -d:danger -o:$@ $<; \
	end=$$(date +%s%N); \
	ns=$$((end - start)); \
	seconds=$$(awk -v x=$$ns 'BEGIN {printf "%.9f", x/1000000000}'); \
	echo "Compile time (danger): $$ns ns ($$seconds s)" > $@.compile

# Compile C++ files
%.cpp.out: %.cpp
	@start=$$(date +%s%N); \
	g++ -std=c++17 -O2 -o $@ $<; \
	end=$$(date +%s%N); \
	ns=$$((end - start)); \
	seconds=$$(awk -v x=$$ns 'BEGIN {printf "%.9f", x/1000000000}'); \
	echo "Compile time: $$ns ns ($$seconds s)" > $@.compile

run_nim_safe: $(NIM_SAFE_EXECUTABLES)
	@for exe in $(NIM_SAFE_EXECUTABLES); do \
		echo "Running $$exe (safe)"; \
		start=$$(date +%s%N); \
		./$$exe; \
		end=$$(date +%s%N); \
		ns=$$((end - start)); \
		seconds=$$(awk -v x=$$ns 'BEGIN {printf "%.9f", x/1000000000}'); \
		echo "Real (safe): $$ns ns ($$seconds s)" > $$exe.runtime; \
	done

run_nim_danger: $(NIM_DANGER_EXECUTABLES)
	@for exe in $(NIM_DANGER_EXECUTABLES); do \
		echo "Running $$exe (danger)"; \
		start=$$(date +%s%N); \
		./$$exe; \
		end=$$(date +%s%N); \
		ns=$$((end - start)); \
		seconds=$$(awk -v x=$$ns 'BEGIN {printf "%.9f", x/1000000000}'); \
		echo "Real (danger): $$ns ns ($$seconds s)" > $$exe.runtime; \
	done

run_cpp: $(CPP_EXECUTABLES)
	@for exe in $(CPP_EXECUTABLES); do \
		echo "Running $$exe"; \
		start=$$(date +%s%N); \
		./$$exe; \
		end=$$(date +%s%N); \
		ns=$$((end - start)); \
		seconds=$$(awk -v x=$$ns 'BEGIN {printf "%.9f", x/1000000000}'); \
		echo "Real: $$ns ns ($$seconds s)" > $$exe.runtime; \
	done

clean:
	rm -f $(NIM_SAFE_EXECUTABLES) $(NIM_DANGER_EXECUTABLES) $(CPP_EXECUTABLES) *.compile *.runtime
