#include "llvm/IR/Function.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
using namespace llvm;

namespace {
struct CountingPass : public FunctionPass {
  static char ID;
  CountingPass() : FunctionPass(ID) {}

  virtual bool runOnFunction(Function &F) {
    outs() << "In a function called " << F.getName() << "!\n";
    return false;
  }
};
} // namespace

char CountingPass::ID = 0;

// Automatically enable the pass.
// http://adriansampson.net/blog/clangpass.html
static void registerMyPass(const PassManagerBuilder &,
                           legacy::PassManagerBase &PM) {
  PM.add(new CountingPass());
}

static RegisterStandardPasses
    RegisterMyPass(PassManagerBuilder::EP_EarlyAsPossible, registerMyPass);