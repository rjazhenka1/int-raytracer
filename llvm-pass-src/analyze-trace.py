import gzip

def dump(d, name):
    with open(f"../llvm-pass-src/{name}-dump.txt", "w") as f:
        items = list(d.items())
        items.sort(key=lambda x: -x[1])
        for item in items:
            print(*item, file=f)

if __name__ == "__main__":
    instrs = {}
    patterns2 = {}
    patterns3 = {}
    with gzip.open("../build/trace.txt.gz") as f:
        for line in f:
            line = line.strip().decode()
            
            tag, data = line[:line.find("]") + 1], line[line.find("]") + 2:]
            
            d = {"[instr]": instrs,
                   "[2-pattern]": patterns2,
                   "[3-pattern]": patterns3}[tag]
            
            if not data in d:
                d[data] = 0
                
            d[data] += 1
            
    dump(instrs, "instrs")
    dump(patterns2, "2-patterns")
    dump(patterns3, "3-patterns")