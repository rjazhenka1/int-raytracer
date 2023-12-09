#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include <llvm-14/llvm/IR/Instructions.h>
#include <llvm-14/llvm/Support/Casting.h>
using namespace llvm;

namespace {
struct CountingPass : public FunctionPass {
  static char ID;
  CountingPass() : FunctionPass(ID) {}

  virtual bool runOnFunction(Function &F) {
    if (isLogger(F.getName())) {
      return false;
    }

    LLVMContext &Ctx = F.getContext();
    IRBuilder<> builder(Ctx);
    Type *voidRetType = Type::getVoidTy(Ctx);

    ArrayRef<Type *> logInstrParamTypes = {builder.getInt8Ty()->getPointerTo()};
    FunctionType *logInstrLogFuncType =
        FunctionType::get(voidRetType, logInstrParamTypes, false);
    FunctionCallee logInstr =
        F.getParent()->getOrInsertFunction("logInstr", logInstrLogFuncType);

    ArrayRef<Type *> log2PatternParamTypes = {
        builder.getInt8Ty()->getPointerTo(),
        builder.getInt8Ty()->getPointerTo()};
    FunctionType *log2PatternLogFuncType =
        FunctionType::get(voidRetType, log2PatternParamTypes, false);
    FunctionCallee log2Pattern = F.getParent()->getOrInsertFunction(
        "log2Pattern", log2PatternLogFuncType);

    ArrayRef<Type *> log3PatternParamTypes = {
        builder.getInt8Ty()->getPointerTo(),
        builder.getInt8Ty()->getPointerTo(),
        builder.getInt8Ty()->getPointerTo()};
    FunctionType *log3PatternLogFuncType =
        FunctionType::get(voidRetType, log3PatternParamTypes, false);
    FunctionCallee log3Pattern = F.getParent()->getOrInsertFunction(
        "log3Pattern", log3PatternLogFuncType);

    Value *previous[] = {nullptr, nullptr};
    for (auto &B : F) {
      for (auto &I : B) {
        if (dyn_cast<PHINode>(&I)) {
          continue;
        }
        // outs() << I.getOpcodeName() << '\n';
        if (auto *call = dyn_cast<CallInst>(&I)) {
          Function *callee = call->getCalledFunction();
          if (isLogger(callee->getName())) {
            continue;
          }
        }

        builder.SetInsertPoint(&I);
        Value *instrName = builder.CreateGlobalStringPtr(I.getOpcodeName());
        {
          Value *args[] = {instrName};
          builder.CreateCall(logInstr, args);
        }

        if (previous[0]) {
          {
            Value *args[] = {previous[0], instrName};
            builder.CreateCall(log2Pattern, args);
          }

          if (previous[1]) {
            Value *args[] = {previous[1], previous[0], instrName};
            builder.CreateCall(log3Pattern, args);
          }
        }

        previous[1] = previous[0];
        previous[0] = instrName;
      }
    }

    return true;
  }

  bool isLogger(StringRef name) {
    return name == "logInstr" || name == "log2Pattern" || name == "log3Pattern";
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
    RegisterMyPass(PassManagerBuilder::EP_OptimizerLast, registerMyPass);