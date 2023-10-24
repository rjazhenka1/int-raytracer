BUILDDIR=$(CURDIR)/build
LLVMDIR=$(CURDIR)/llvm-ir
PASSDIR=$(CURDIR)/llvm-pass-src
TRACEDIR=$(CURDIR)/trace

release:
	mkdir -p $(BUILDDIR)
	clang -Wall src/*.c -O3 -lSDL2 -o $(BUILDDIR)/int-raytracer

debug:
	mkdir -p $(BUILDDIR)
	clang -Wall src/*.c -g -lSDL2 -o $(BUILDDIR)/int-raytracer-debug

llvm-ir:
	mkdir -p $(LLVMDIR)
	clang -O2 -S -emit-llvm -o $(LLVMDIR)/main.ll src/main.c
	clang -O2 -S -emit-llvm -o $(LLVMDIR)/raytrace.ll src/raytrace.c
	clang -O2 -S -emit-llvm -o $(LLVMDIR)/screen.ll src/sim.c

llvm-trace:
	mkdir -p $(BUILDDIR)
	clang++ $(PASSDIR)/CountingPass.cpp -c -fPIC -I`llvm-config-14 --includedir` -o $(BUILDDIR)/CountingPass.o
	clang++ $(BUILDDIR)/CountingPass.o -fPIC -shared -o $(BUILDDIR)/libPass.so
	clang src/*.c -lSDL2 -Xclang -load -Xclang $(BUILDDIR)/libPass.so -flegacy-pass-manager $(BUILDDIR)/int-raytracer-pass

clean:
	rm -rf $(BUILDDIR) $(LLVMDIR)

all: release
	