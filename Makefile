BUILDDIR=$(CURDIR)/build
LLVMDIR=$(CURDIR)/llvm-ir

release:
	mkdir -p $(BUILDDIR)
	clang src/*.c -O3 -lSDL2 -o $(BUILDDIR)/int-raytracer

debug:
	mkdir -p $(BUILDDIR)
	clang src/*.c -g -lSDL2 -o $(BUILDDIR)/int-raytracer-debug

llvm-ir:
	mkdir -p $(LLVMDIR)
	clang -S -emit-llvm -o $(LLVMDIR)/main.ll src/main.c
	clang -S -emit-llvm -o $(LLVMDIR)/raytrace.ll src/raytrace.c
	clang -S -emit-llvm -o $(LLVMDIR)/screen.ll src/screen.c
	clang -S -emit-llvm -o $(LLVMDIR)/vec.ll src/vec.c
	clang -S -emit-llvm -o $(LLVMDIR)/fixed.ll src/fixed.c

clean:
	rm -rf $(BUILDDIR) $(LLVMDIR)

all: release
	