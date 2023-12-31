#include "../src/sim.h"
#include <SDL2/SDL.h>
#include <SDL2/SDL_events.h>
#include <SDL2/SDL_render.h>
#include <SDL2/SDL_timer.h>
#include <SDL2/SDL_video.h>

struct ScreenMeta {
  SDL_Window *window;
  SDL_Renderer *renderer;
  SDL_Texture *texture;
  unsigned int *pixelBuffer;
  unsigned int lastTick;
};

struct ScreenMeta meta;

int ARGB(unsigned char red, unsigned char green, unsigned char blue) {
  return (255 << 24) | (red << 16) | (green << 8) | blue;
}

void simInit() {
  meta.window =
      SDL_CreateWindow("INT RT", 0, 0, WIDTH, HEIGHT, SDL_WINDOW_SHOWN);
  meta.renderer = SDL_CreateRenderer(meta.window, -1, 0);
  simPrepareScreen();
  meta.texture = SDL_CreateTexture(meta.renderer, SDL_PIXELFORMAT_ARGB8888,
                                   SDL_TEXTUREACCESS_STREAMING, WIDTH, HEIGHT);
  simFlush();
}

void simPrepareScreen() {
  int pitch;
  SDL_LockTexture(meta.texture, NULL, (void **)&meta.pixelBuffer, &pitch);
}

void simSetPixel(int x, int y, int argb) {
  meta.pixelBuffer[x + y * WIDTH] = argb;
}

int simCheckQuit() {
  int quit = 0;
  SDL_Event event;
  while (SDL_PollEvent(&event)) {
    if (event.type == SDL_QUIT ||
        (event.type == SDL_WINDOWEVENT &&
         event.window.event == SDL_WINDOWEVENT_CLOSE)) {
      quit = 1;
    }
  }
  return quit;
}

void simFlush() {
  unsigned int ticks = SDL_GetTicks();
  unsigned int delta = ticks - meta.lastTick;
  if (delta > 1000 / FPS) {
    meta.lastTick = ticks;
  } else {
    SDL_Delay(1000 / FPS - delta);
  }

  SDL_UnlockTexture(meta.texture);
  SDL_RenderCopy(meta.renderer, meta.texture, NULL, NULL);
  SDL_RenderPresent(meta.renderer);
}

void simClose() {
  SDL_DestroyRenderer(meta.renderer);
  SDL_DestroyWindow(meta.window);
  SDL_Quit();
}

#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
using namespace llvm;

int main() {
  LLVMContext context;
  // ; ModuleID = 'app.c'
  // source_filename = "app.c"
  Module *module = new Module("app.c", context);
  IRBuilder<> builder(context);

  // declare i32 @ARGB(i32 noundef, i32 noundef, i32 noundef)
  Type *i32Type = Type::getInt32Ty(context);
  Type *i64Type = Type::getInt64Ty(context);
  ArrayRef<Type *> ARGBParamTypes = {Type::getInt32Ty(context),
                                     Type::getInt32Ty(context),
                                     Type::getInt32Ty(context)};
  FunctionType *ARGBType = FunctionType::get(i32Type, ARGBParamTypes, false);
  FunctionCallee ARGBFunc = module->getOrInsertFunction("ARGB", ARGBType);

  ArrayRef<Type *> noArgs = {};

  // declare void @simInit()
  Type *voidType = Type::getVoidTy(context);
  FunctionType *simInitType = FunctionType::get(voidType, noArgs, false);
  FunctionCallee simInitFunc =
      module->getOrInsertFunction("simInit", simInitType);

  // declare void @simPrepareScreen()
  FunctionType *simPrepareScreenType =
      FunctionType::get(voidType, noArgs, false);
  FunctionCallee simPrepareScreenFunc =
      module->getOrInsertFunction("simPrepareScreen", simPrepareScreenType);

  // declare void @simSetPixel(i32 noundef, i32 noundef, i32 noundef)
  ArrayRef<Type *> simSetPixelParamTypes = {Type::getInt32Ty(context),
                                            Type::getInt32Ty(context),
                                            Type::getInt32Ty(context)};
  FunctionType *simSetPixelType =
      FunctionType::get(voidType, simSetPixelParamTypes, false);
  FunctionCallee simSetPixelFunc =
      module->getOrInsertFunction("simSetPixel", simSetPixelType);

  // declare i32 @simCheckQuit()
  FunctionType *simCheckQuitType = FunctionType::get(i32Type, noArgs, false);
  FunctionCallee simCheckQuitFunc =
      module->getOrInsertFunction("simCheckQuit", simCheckQuitType);

  // declare void @simFlush()
  FunctionType *simFlushType = FunctionType::get(voidType, noArgs, false);
  FunctionCallee simFlushFunc =
      module->getOrInsertFunction("simFlush", simFlushType);

  // declare void @simClose()
  FunctionType *simCloseType = FunctionType::get(voidType, noArgs, false);
  FunctionCallee simCloseFunc =
      module->getOrInsertFunction("simClose", simCloseType);

  ArrayRef<Type *> vecInternalTypes = {i64Type, i32Type};
  Type *vecType = StructType::create(vecInternalTypes);

  /*

  // define dso_local i32 @f_mul(i32 noundef %0, i32 noundef %1)
  // local_unnamed_addr #0 {
  ArrayRef<Type *> fMulParamTypes = {Type::getInt32Ty(context),
                                     Type::getInt32Ty(context)};
  FunctionType *fMulFuncType =
      FunctionType::get(i32Type, fMulParamTypes, false);
  Function *fMulFunc = Function::Create(fMulFuncType, Function::ExternalLinkage,
                                        "f_mul", module);
  {
    builder.SetInsertPoint(&fMulFunc->getEntryBlock());
    Value *val0 = fMulFunc->getArg(0);
    Value *val1 = fMulFunc->getArg(1);

    // %3 = sdiv i32 %1, 2048
    Value *val3 = builder.CreateSDiv(val1, builder.getInt32(2048));
    // %4 = mul nsw i32 %3, %0
    Value *val4 = builder.CreateNSWMul(val3, val0);
    // ret i32 %4
    builder.CreateRet(val4);
  }

  // define dso_local i32 @f_div(i32 noundef %0, i32 noundef %1)
  // local_unnamed_addr #0 {
  ArrayRef<Type *> fDivParamTypes = {Type::getInt32Ty(context),
                                     Type::getInt32Ty(context)};
  FunctionType *fDivFuncType =
      FunctionType::get(i32Type, fDivParamTypes, false);
  Function *fDivFunc = Function::Create(fMulFuncType, Function::ExternalLinkage,
                                        "f_div", module);
  {
    builder.SetInsertPoint(&fDivFunc->getEntryBlock());
    Value *val0 = fDivFunc->getArg(0);
    Value *val1 = fDivFunc->getArg(1);

    BasicBlock *BB4 = BasicBlock::Create(context, "", fDivFunc);
    BasicBlock *BB7 = BasicBlock::Create(context, "", fDivFunc);
    BasicBlock *BB10 = BasicBlock::Create(context, "", fDivFunc);

    //   %3 = icmp eq i32 %1, 0
    Value *val3 = builder.CreateICmpEQ(val1, builder.getInt32(0));
    //   br i1 %3, label %4, label %7'
    builder.CreateCondBr(val3, BB4, BB7);

    // 4:                                                ; preds = %2
    builder.SetInsertPoint(BB4);
    //   %5 = icmp sgt i32 %0, -1
    Value *val5 = builder.CreateICmpSGT(val0, builder.getInt32(-1));
    //   %6 = select i1 %5, i32 2147483647, i32 -2147483648
    Value *val6 = builder.CreateSelect(val5, builder.getInt32(2147483647),
                                       builder.getInt32(-2147483648));
    //   br label %10
    builder.CreateBr(BB10);

    // 7:                                                ; preds = %2
    builder.SetInsertPoint(BB7);
    //   %8 = shl nsw i32 %0, 11
    Value *val8 =
        builder.CreateShl(val0, builder.getInt32(11), "", false, true);
    //   %9 = sdiv i32 %8, %1
    Value *val9 = builder.CreateSDiv(val8, val1);
    //   br label %10
    builder.CreateBr(BB10);

    // 10:                                               ; preds = %7, %4
    builder.SetInsertPoint(BB10);
    //   %11 = phi i32 [ %6, %4 ], [ %9, %7 ]
    PHINode *val11 = builder.CreatePHI(builder.getInt32Ty(), 2);
    val11->addIncoming(val6, BB4);
    val11->addIncoming(val9, BB7);
    //   ret i32 %11
    builder.CreateRet(val11);
  }

  // define dso_local { i64, i32 } @v_add(i64 %0, i32 %1, i64 %2, i32 %3)
  // local_unnamed_addr #0 {
  ArrayRef<Type *> vAddParamTypes = {
      Type::getInt64Ty(context), Type::getInt32Ty(context),
      Type::getInt64Ty(context), Type::getInt32Ty(context)};
  FunctionType *vAddFuncType =
      FunctionType::get(vecType, vAddParamTypes, false);
  Function *vAddFunc = Function::Create(vAddFuncType, Function::ExternalLinkage,
                                        "v_add", module);
  {
    builder.SetInsertPoint(&vAddFunc->getEntryBlock());
    Value *val0 = vAddFunc->getArg(0);
    Value *val1 = vAddFunc->getArg(1);
    Value *val2 = vAddFunc->getArg(2);
    Value *val3 = vAddFunc->getArg(3);
    // %5 = and i64 %0, -4294967296
    Value *val5 = builder.CreateAdd(val0, builder.getInt64(-4294967296));
    // %6 = add i64 %2, %0
    Value *val6 = builder.CreateAdd(val2, val0);
    // %7 = add nsw i32 %3, %1
    Value *val7 = builder.CreateNSWAdd(val3, val1);
    // %8 = add i64 %5, %2
    Value *val8 = builder.CreateAdd(val5, val2);
    // %9 = and i64 %8, -4294967296
    Value *val9 = builder.CreateAnd(val8, builder.getInt64(-4294967296));
    // %10 = and i64 %6, 4294967295
    Value *val10 = builder.CreateAnd(val6, builder.getInt64(4294967295));
    // %11 = or i64 %9, %10
    Value *val11 = builder.CreateOr(val9, val10);
    // %12 = insertvalue { i64, i32 } poison, i64 %11, 0
    Value *val12 =
        builder.CreateInsertValue(PoisonValue::get(vecType), val11, {0});
    // %13 = insertvalue { i64, i32 } %12, i32 %7, 1
    Value *val13 = builder.CreateInsertValue(val12, val7, {1});
    // ret { i64, i32 } %13
    builder.CreateRet(val13);
  }

  // define dso_local { i64, i32 } @v_sub(i64 %0, i32 %1, i64 %2, i32 %3)
  // local_unnamed_addr #0 {
  ArrayRef<Type *> vSubParamTypes = {
      Type::getInt64Ty(context), Type::getInt32Ty(context),
      Type::getInt64Ty(context), Type::getInt32Ty(context)};
  FunctionType *vSubFuncType =
      FunctionType::get(vecType, vSubParamTypes, false);
  Function *vSubFunc = Function::Create(vSubFuncType, Function::ExternalLinkage,
                                        "v_sub", module);
  {
    builder.SetInsertPoint(&vSubFunc->getEntryBlock());
    Value *val1 = vSubFunc->getArg(1);
    Value *val0 = vSubFunc->getArg(0);
    Value *val2 = vSubFunc->getArg(2);
    Value *val3 = vSubFunc->getArg(3);
    // %5 = and i64 %2, -4294967296
    Value *val5 = builder.CreateAdd(val0, builder.getInt64(-4294967296));
    // %6 = sub i64 %0, %2
    Value *val6 = builder.CreateSub(val2, val0);
    // %7 = sub nsw i32 %1, %3
    Value *val7 = builder.CreateNSWSub(val3, val1);
    // %8 = sub i64 %0, %5
    Value *val8 = builder.CreateSub(val5, val2);
    // %9 = and i64 %8, -4294967296
    Value *val9 = builder.CreateAnd(val8, builder.getInt64(-4294967296));
    // %10 = and i64 %6, 4294967295
    Value *val10 = builder.CreateAnd(val6, builder.getInt64(4294967295));
    // %11 = or i64 %9, %10
    Value *val11 = builder.CreateOr(val9, val10);
    // %12 = insertvalue { i64, i32 } poison, i64 %11, 0
    Value *val12 =
        builder.CreateInsertValue(PoisonValue::get(vecType), val11, {0});
    // %13 = insertvalue { i64, i32 } %12, i32 %7, 1
    Value *val13 = builder.CreateInsertValue(val12, val7, {1});
    // ret { i64, i32 } %13
    builder.CreateRet(val13);
  }

  // define dso_local { i64, i32 } @v_mul(i64 %0, i32 %1, i64 %2, i32 %3)
  // local_unnamed_addr #0 {
  ArrayRef<Type *> vMulParamTypes = {
      Type::getInt64Ty(context), Type::getInt32Ty(context),
      Type::getInt64Ty(context), Type::getInt32Ty(context)};
  FunctionType *vMulFuncType =
      FunctionType::get(vecType, vMulParamTypes, false);
  Function *vMulFunc = Function::Create(vMulFuncType, Function::ExternalLinkage,
                                        "v_mul", module);

  {
    builder.SetInsertPoint(&vMulFunc->getEntryBlock());
    Value *val0 = vMulFunc->getArg(0);
    Value *val1 = vMulFunc->getArg(1);
    Value *val2 = vMulFunc->getArg(2);
    Value *val3 = vMulFunc->getArg(3);

    // %5 = trunc i64 %0 to i32
    Value *val5 = builder.CreateTrunc(val0, Type::getInt32Ty(context));
    // %6 = lshr i64 %0, 32
    Value *val6 = builder.CreateLShr(val0, builder.getInt32(32));
    // %7 = trunc i64 %6 to i32
    Value *val7 = builder.CreateTrunc(val6, Type::getInt32Ty(context));
    // %8 = trunc i64 %2 to i32
    Value *val8 = builder.CreateTrunc(val2, Type::getInt32Ty(context));
    // %9 = lshr i64 %2, 32
    Value *val9 = builder.CreateLShr(val2, builder.getInt32(32));
    // %10 = trunc i64 %9 to i32
    Value *val10 = builder.CreateTrunc(val9, Type::getInt32Ty(context));
    // %11 = sdiv i32 %8, 2048
    Value *val11 = builder.CreateSDiv(val8, builder.getInt32(2048));
    // %12 = mul nsw i32 %11, %5
    Value *val12 = builder.CreateNSWMul(val11, val5);
    // %13 = sdiv i32 %10, 2048
    Value *val13 = builder.CreateSDiv(val10, builder.getInt32(2048));
    // %14 = mul nsw i32 %13, %7
    Value *val14 = builder.CreateNSWMul(val13, val7);
    // %15 = sdiv i32 %3, 2048
    Value *val15 = builder.CreateSDiv(val3, builder.getInt32(2048));
    // %16 = mul nsw i32 %15, %1
    Value *val16 = builder.CreateNSWMul(val15, val1);
    // %17 = zext i32 %14 to i64
    Value *val17 = builder.CreateZExt(val14, Type::getInt64Ty(context));
    // %18 = shl nuw i64 %17, 32
    Value *val18 = builder.CreateShl(val17, builder.getInt32(32), "", true);
    // %19 = zext i32 %12 to i64
    Value *val19 = builder.CreateZExt(val12, Type::getInt64Ty(context));
    // %20 = or i64 %18, %19
    Value *val20 = builder.CreateOr(val18, val19);
    // %21 = insertvalue { i64, i32 } poison, i64 %20, 0
    Value *val21 =
        builder.CreateInsertValue(PoisonValue::get(vecType), val20, {0});
    // %22 = insertvalue { i64, i32 } %21, i32 %16, 1
    Value *val22 = builder.CreateInsertValue(val21, val16, {1});
    // ret { i64, i32 } %22
    builder.CreateRet(val22);
  }

  // define dso_local { i64, i32 } @v_div(i64 %0, i32 %1, i64 %2, i32 %3)
  // local_unnamed_addr #0 {
  ArrayRef<Type *> vDivParamTypes = {
      Type::getInt64Ty(context), Type::getInt32Ty(context),
      Type::getInt64Ty(context), Type::getInt32Ty(context)};
  FunctionType *vDivFuncType =
      FunctionType::get(vecType, vDivParamTypes, false);
  Function *vDivFunc = Function::Create(vDivFuncType, Function::ExternalLinkage,
                                        "v_div", module);

  {
    builder.SetInsertPoint(&vDivFunc->getEntryBlock());
    Value *val0 = vDivFunc->getArg(0);
    Value *val1 = vDivFunc->getArg(1);
    Value *val2 = vDivFunc->getArg(2);
    Value *val3 = vDivFunc->getArg(3);

    BasicBlock *BB10 = BasicBlock::Create(context, "", vDivFunc);
    BasicBlock *BB13 = BasicBlock::Create(context, "", vDivFunc);
    BasicBlock *BB16 = BasicBlock::Create(context, "", vDivFunc);
    BasicBlock *BB19 = BasicBlock::Create(context, "", vDivFunc);
    BasicBlock *BB22 = BasicBlock::Create(context, "", vDivFunc);
    BasicBlock *BB27 = BasicBlock::Create(context, "", vDivFunc);
    BasicBlock *BB30 = BasicBlock::Create(context, "", vDivFunc);
    BasicBlock *BB33 = BasicBlock::Create(context, "", vDivFunc);
    BasicBlock *BB36 = BasicBlock::Create(context, "", vDivFunc);

    //   %5 = trunc i64 %0 to i32
    Value *val5 = builder.CreateTrunc(val0, Type::getInt32Ty(context));
    //   %6 = trunc i64 %2 to i32
    Value *val6 = builder.CreateTrunc(val2, Type::getInt32Ty(context));
    //   %7 = lshr i64 %2, 32
    Value *val7 = builder.CreateLShr(val2, builder.getInt32(32));
    //   %8 = trunc i64 %7 to i32
    Value *val8 = builder.CreateTrunc(val7, Type::getInt32Ty(context));
    //   %9 = icmp eq i32 %6, 0
    Value *val9 = builder.CreateICmpEQ(val6, builder.getInt32(0));
    //   br i1 %9, label %10, label %13
    builder.CreateCondBr(val9, BB10, BB13);

    // 10:                                               ; preds = %4
    builder.SetInsertPoint(BB10);
    //   %11 = icmp sgt i32 %5, -1
    Value *val11 = builder.CreateICmpSGT(val5, builder.getInt32(-1));
    //   %12 = select i1 %11, i32 2147483647, i32 -2147483648
    Value *val12 = builder.CreateSelect(val11, builder.getInt32(2147483647),
                                        builder.getInt32(-2147483648));
    //   br label %16
    builder.CreateBr(BB16);

    // 13:                                               ; preds = %4
    builder.SetInsertPoint(BB13);
    //   %14 = shl nsw i32 %5, 11
    Value *val14 =
        builder.CreateShl(val5, builder.getInt32(11), "", false, true);
    //   %15 = sdiv i32 %14, %6
    Value *val15 = builder.CreateSDiv(val14, val6);
    //   br label %16
    builder.CreateBr(BB16);

    // 16:                                               ; preds = %10, %13
    builder.SetInsertPoint(BB16);
    //   %17 = phi i32 [ %12, %10 ], [ %15, %13 ]
    PHINode *val17 = builder.CreatePHI(builder.getInt32Ty(), 2);
    val17->addIncoming(val12, BB10);
    val17->addIncoming(val15, BB13);
    //   %18 = icmp eq i32 %8, 0
    Value *val18 = builder.CreateICmpEQ(val8, builder.getInt32(0));
    //   br i1 %18, label %19, label %22
    builder.CreateCondBr(val18, BB19, BB22);

    // 19:                                               ; preds = %16
    builder.SetInsertPoint(BB19);
    //   %20 = icmp sgt i64 %0, -1
    Value *val20 = builder.CreateICmpSGT(val0, builder.getInt64(-1));
    //   %21 = select i1 %20, i32 2147483647, i32 -2147483648
    Value *val21 = builder.CreateSelect(val20, builder.getInt32(2147483647),
                                        builder.getInt32(-2147483648));
    //   br label %27
    builder.CreateBr(BB27);

    // 22:                                               ; preds = %16
    builder.SetInsertPoint(BB22);
    //   %23 = lshr i64 %0, 21
    Value *val23 = builder.CreateLShr(val0, builder.getInt32(21));
    //   %24 = trunc i64 %23 to i32
    Value *val24 = builder.CreateTrunc(val23, Type::getInt32Ty(context));
    //   %25 = and i32 %24, -2048
    Value *val25 = builder.CreateAnd(val24, builder.getInt32(-2048));
    //   %26 = sdiv i32 %25, %8
    Value *val26 = builder.CreateSDiv(val25, val8);
    //   br label %27
    builder.CreateBr(BB27);

    // 27:                                               ; preds = %19, %22
    builder.SetInsertPoint(BB27);
    //   %28 = phi i32 [ %21, %19 ], [ %26, %22 ]
    PHINode *val28 = builder.CreatePHI(builder.getInt32Ty(), 2);
    val17->addIncoming(val21, BB19);
    val17->addIncoming(val26, BB22);
    //   %29 = icmp eq i32 %3, 0
    Value *val29 = builder.CreateICmpEQ(val3, builder.getInt32(0));
    //   br i1 %29, label %30, label %33
    builder.CreateCondBr(val29, BB30, BB33);

    // 30:                                               ; preds = %27
    builder.SetInsertPoint(BB30);
    //   %31 = icmp sgt i32 %1, -1
    Value *val31 = builder.CreateICmpSGT(val1, builder.getInt32(-1));
    //   %32 = select i1 %31, i32 2147483647, i32 -2147483648
    Value *val32 = builder.CreateSelect(val31, builder.getInt32(2147483647),
                                        builder.getInt32(-2147483648));
    //   br label %36
    builder.CreateBr(BB36);

    // 33:                                               ; preds = %27
    builder.SetInsertPoint(BB33);
    //   %34 = shl nsw i32 %1, 11
    Value *val34 =
        builder.CreateShl(val1, builder.getInt32(11), "", false, true);
    //   %35 = sdiv i32 %34, %3
    Value *val35 = builder.CreateSDiv(val34, val3);
    //   br label %36
    builder.CreateBr(BB36);

    // 36:                                               ; preds = %30, %33
    builder.SetInsertPoint(BB36);
    //   %37 = phi i32 [ %32, %30 ], [ %35, %33 ]
    PHINode *val37 = builder.CreatePHI(builder.getInt32Ty(), 2);
    val37->addIncoming(val32, BB30);
    val37->addIncoming(val25, BB33);
    //   %38 = zext i32 %28 to i64
    Value *val38 = builder.CreateZExt(val28, Type::getInt64Ty(context));
    //   %39 = shl nuw i64 %38, 32
    Value *val39 = builder.CreateShl(val38, builder.getInt32(32), "", true);
    //   %40 = zext i32 %17 to i64
    Value *val40 = builder.CreateZExt(val17, Type::getInt64Ty(context));
    //   %41 = or i64 %39, %40
    Value *val41 = builder.CreateOr(val39, val40);

    //   %42 = insertvalue { i64, i32 } poison, i64 %41, 0
    Value *val42 =
        builder.CreateInsertValue(PoisonValue::get(vecType), val41, {0});
    //   %43 = insertvalue { i64, i32 } %42, i32 %37, 1
    Value *val43 = builder.CreateInsertValue(val42, val37, {1});
    //   ret { i64, i32 } %43
    builder.CreateRet(val43);
  }

  // define dso_local { i64, i32 } @v_neg(i64 %0, i32 %1)
  // local_unnamed_addr #0 {
  ArrayRef<Type *> vNegParamTypes = {Type::getInt64Ty(context),
                                     Type::getInt32Ty(context)};
  FunctionType *vNegFuncType =
      FunctionType::get(vecType, vNegParamTypes, false);
  Function *vNegFunc = Function::Create(vNegFuncType, Function::ExternalLinkage,
                                        "v_neg", module);

  {
    builder.SetInsertPoint(&vNegFunc->getEntryBlock());
    Value *val0 = vNegFunc->getArg(0);
    Value *val1 = vNegFunc->getArg(1);

    // %3 = and i64 %0, -4294967296
    Value *val3 = builder.CreateAnd(val0, builder.getInt64(-4294967296));
    // %4 = sub i64 0, %0
    Value *val4 = builder.CreateSub(builder.getInt64(0), val0);
    // %5 = sub nsw i32 0, %1
    Value *val5 = builder.CreateNSWSub(builder.getInt32(0), val1);
    // %6 = and i64 %4, 4294967295
    Value *val6 = builder.CreateAnd(val4, builder.getInt64(4294967295));
    // %7 = sub i64 %6, %3
    Value *val7 = builder.CreateSub(val6, val3);
    // %8 = insertvalue { i64, i32 } poison, i64 %7, 0
    Value *val8 =
        builder.CreateInsertValue(PoisonValue::get(vecType), val7, {0});
    // %9 = insertvalue { i64, i32 } %8, i32 %5, 1
    Value *val9 = builder.CreateInsertValue(val8, val5, {1});
    // ret { i64, i32 } %9
    builder.CreateRet(val9);
  }

  // define dso_local { i64, i32 } @v_from_scalars(i32 %0, i32 %1, i32 %2)
  // local_unnamed_addr #0 {
  ArrayRef<Type *> vFromScalarsParamTypes = {Type::getInt32Ty(context),
                                             Type::getInt32Ty(context),
                                             Type::getInt32Ty(context)};
  FunctionType *vFromScalarsFuncType =
      FunctionType::get(vecType, vFromScalarsParamTypes, false);
  Function *vFromScalarsFunc =
      Function::Create(vFromScalarsFuncType, Function::ExternalLinkage,
                       "v_from_scalars", module);
  {
    builder.SetInsertPoint(&vFromScalarsFunc->getEntryBlock());
    Value *val0 = vFromScalarsFunc->getArg(0);
    Value *val1 = vFromScalarsFunc->getArg(1);
    Value *val2 = vFromScalarsFunc->getArg(2);

    // %4 = zext i32 %1 to i64
    Value *val4 = builder.CreateZExt(val1, Type::getInt64Ty(context));
    // %5 = shl nuw i64 %4, 32
    Value *val5 = builder.CreateShl(val4, builder.getInt64(32), "", true);
    // %6 = zext i32 %0 to i64
    Value *val6 = builder.CreateZExt(val0, Type::getInt64Ty(context));
    // %7 = or i64 %5, %6
    Value *val7 = builder.CreateOr(val5, val6);
    // %8 = insertvalue { i64, i32 } poison, i64 %7, 0
    Value *val8 =
        builder.CreateInsertValue(PoisonValue::get(vecType), val7, {0});
    // %9 = insertvalue { i64, i32 } %8, i32 %2, 1
    Value *val9 = builder.CreateInsertValue(val8, val2, {1});
    // ret { i64, i32 } %9
    builder.CreateRet(val9);
  }

  // define dso_local { i64, i32 } @v_from_scalar(i32 noundef %0)
  // local_unnamed_addr #0 {
  ArrayRef<Type *> vFromScalarParamTypes = {Type::getInt32Ty(context)};
  FunctionType *vFromScalarFuncType =
      FunctionType::get(vecType, vFromScalarParamTypes, false);
  Function *vFromScalarFunc = Function::Create(
      vFromScalarFuncType, Function::ExternalLinkage, "v_from_scalar", module);
  {
    builder.SetInsertPoint(&vFromScalarFunc->getEntryBlock());
    Value *val0 = vFromScalarFunc->getArg(0);

    // %2 = zext i32 %0 to i64
    Value *val2 = builder.CreateZExt(val0, Type::getInt64Ty(context));
    // %3 = mul nuw i64 %2, 4294967297
    Value *val3 = builder.CreateNUWMul(val2, builder.getInt64(4294967297));
    // %4 = insertvalue { i64, i32 } poison, i64 %3, 0
    Value *val4 =
        builder.CreateInsertValue(PoisonValue::get(vecType), val3, {0});
    // %5 = insertvalue { i64, i32 } %4, i32 %0, 1
    Value *val5 = builder.CreateInsertValue(val4, val0, {1});
    // ret { i64, i32 } %5
    builder.CreateRet(val5);
  }


  */

  Function *absIntrinsic = Intrinsic::getDeclaration(
      module, Intrinsic::abs, {Type::getInt32Ty(context)});
  // define dso_local i32 @get_color(i64 %0, i32 %1, i64 %2, i32 %3)
  // local_unnamed_addr #1 {
  ArrayRef<Type *> getColorParamTypes = {
      Type::getInt64Ty(context), Type::getInt32Ty(context),
      Type::getInt64Ty(context), Type::getInt32Ty(context)};
  FunctionType *getColorFuncType =
      FunctionType::get(i32Type, getColorParamTypes, false);
  Function *getColorFunc = Function::Create(
      getColorFuncType, Function::ExternalLinkage, "get_color", module);

  {
    Value *val0 = getColorFunc->getArg(0);
    Value *val1 = getColorFunc->getArg(1);
    Value *val2 = getColorFunc->getArg(2);
    Value *val3 = getColorFunc->getArg(3);

    BasicBlock *BB0 = BasicBlock::Create(context, "", getColorFunc);
    BasicBlock *BB8 = BasicBlock::Create(context, "", getColorFunc);
    BasicBlock *BB10 = BasicBlock::Create(context, "", getColorFunc);
    BasicBlock *BB16 = BasicBlock::Create(context, "", getColorFunc);
    BasicBlock *BB18 = BasicBlock::Create(context, "", getColorFunc);
    BasicBlock *BB40 = BasicBlock::Create(context, "", getColorFunc);
    BasicBlock *BB42 = BasicBlock::Create(context, "", getColorFunc);
    BasicBlock *BB44 = BasicBlock::Create(context, "", getColorFunc);

    builder.SetInsertPoint(BB0);
    //   %5 = lshr i64 %2, 32
    Value *val5 = builder.CreateLShr(val2, builder.getInt64(32));
    //   %6 = trunc i64 %5 to i32
    Value *val6 = builder.CreateTrunc(val5, Type::getInt32Ty(context));
    //   %7 = icmp eq i32 %6, 0
    Value *val7 = builder.CreateICmpEQ(val6, builder.getInt32(0));
    //   br i1 %7, label %8, label %10
    builder.CreateCondBr(val7, BB8, BB10);

    // 8:                                                ; preds = %4
    builder.SetInsertPoint(BB8);
    //   %9 = icmp sgt i64 %0, -1
    Value *val9 = builder.CreateICmpSGT(val0, builder.getInt64(-1));
    //   br i1 %9, label %18, label %16
    builder.CreateCondBr(val9, BB18, BB16);

    // 10:                                               ; preds = %4
    builder.SetInsertPoint(BB10);
    //   %11 = lshr i64 %0, 21
    Value *val11 = builder.CreateLShr(val0, builder.getInt64(21));
    //   %12 = trunc i64 %11 to i32
    Value *val12 = builder.CreateTrunc(val11, Type::getInt32Ty(context));
    //   %13 = and i32 %12, -2048
    Value *val13 = builder.CreateAnd(val12, builder.getInt32(-2048));
    //   %14 = sdiv i32 %13, %6
    Value *val14 = builder.CreateSDiv(val13, val6);
    //   %15 = icmp slt i32 %14, -2048
    Value *val15 = builder.CreateICmpSLT(val14, builder.getInt32(-2048));
    //   br i1 %15, label %16, label %18
    builder.CreateCondBr(val15, BB16, BB18);

    // 16:                                               ; preds = %8, %10
    builder.SetInsertPoint(BB16);
    //   %17 = tail call i32 @ARGB(i8 noundef zeroext 0, i8 noundef zeroext 127,
    //   i8 noundef zeroext 127) #4
    Value *ARGBArgs1[] = {builder.getInt8(0), builder.getInt8(127),
                          builder.getInt8(127)};
    Value *val17 = builder.CreateCall(ARGBFunc, ARGBArgs1);
    //   br label %44
    builder.CreateBr(BB44);

    // 18:                                               ; preds = %8, %10
    builder.SetInsertPoint(BB18);
    //   %19 = phi i32 [ %14, %10 ], [ 2147483647, %8 ]
    PHINode *val19 = builder.CreatePHI(builder.getInt32Ty(), 2);
    val19->addIncoming(val14, BB10);
    val19->addIncoming(builder.getInt32(2147483647), BB8);
    //   %20 = trunc i64 %2 to i32
    Value *val20 = builder.CreateTrunc(val2, Type::getInt32Ty(context));
    //   %21 = sdiv i32 %19, -2048
    Value *val21 = builder.CreateSDiv(val19, builder.getInt32(-2048));
    //   %22 = mul nsw i32 %21, %20
    Value *val22 = builder.CreateNSWMul(val21, val20);
    //   %23 = mul nsw i32 %21, %3
    Value *val23 = builder.CreateNSWMul(val21, val3);
    //   %24 = add nsw i32 %23, %1
    Value *val24 = builder.CreateNSWAdd(val23, val1);
    //   %25 = trunc i64 %0 to i32
    Value *val25 = builder.CreateTrunc(val0, Type::getInt32Ty(context));
    //   %26 = add i32 %22, %25
    Value *val26 = builder.CreateAdd(val22, val25);
    //   %27 = sdiv i32 %26, 4
    Value *val27 = builder.CreateSDiv(val26, builder.getInt32(4));
    //   %28 = tail call i32 @llvm.abs.i32(i32 %27, i1 true)
    Value *absArgs1[] = {val27, builder.getInt1(true)};
    Value *val28 = builder.CreateCall(absIntrinsic, absArgs1);
    //   %29 = and i32 %28, 16383
    Value *val29 = builder.CreateAnd(val28, builder.getInt32(16383));
    //   %30 = sdiv i32 %24, 4
    Value *val30 = builder.CreateSDiv(val24, builder.getInt32(4));
    //   %31 = tail call i32 @llvm.abs.i32(i32 %30, i1 true)
    Value *absArgs2[] = {val30, builder.getInt1(true)};
    Value *val31 = builder.CreateCall(absIntrinsic, absArgs2);
    //   %32 = and i32 %31, 16383
    Value *val32 = builder.CreateAnd(val31, builder.getInt32(16383));
    //   %33 = icmp ugt i32 %29, 8192
    Value *val33 = builder.CreateICmpUGT(val29, builder.getInt32(8192));
    //   %34 = zext i1 %33 to i32
    Value *val34 = builder.CreateZExt(val33, Type::getInt32Ty(context));
    //   %35 = icmp ugt i32 %32, 8192
    Value *val35 = builder.CreateICmpUGT(val32, builder.getInt32(8192));
    //   %36 = zext i1 %35 to i32
    Value *val36 = builder.CreateZExt(val35, Type::getInt32Ty(context));
    //   %37 = add nuw nsw i32 %34, %36
    Value *val37 = builder.CreateAdd(val34, val36, "", true, true);
    //   %38 = and i32 %37, 1
    Value *val38 = builder.CreateAnd(val37, builder.getInt32(1));
    //   %39 = icmp eq i32 %38, 0
    Value *val39 = builder.CreateICmpEQ(val38, builder.getInt32(0));
    //   br i1 %39, label %42, label %40
    builder.CreateCondBr(val39, BB42, BB40);

    // 40:                                               ; preds = %18
    builder.SetInsertPoint(BB40);
    //   %41 = tail call i32 @ARGB(i8 noundef zeroext -1, i8 noundef zeroext -1,
    //   i8 noundef zeroext -1) #4
    Value *ARGBArgs2[] = {builder.getInt8(-1), builder.getInt8(-1),
                          builder.getInt8(-1)};
    Value *val41 = builder.CreateCall(ARGBFunc, ARGBArgs2);
    //   br label %44
    builder.CreateBr(BB44);

    // 42:                                               ; preds = %18
    builder.SetInsertPoint(BB42);
    //   %43 = tail call i32 @ARGB(i8 noundef zeroext 0, i8 noundef zeroext 0,
    //   i8 noundef zeroext 0) #4
    Value *ARGBArgs3[] = {builder.getInt8(0), builder.getInt8(0),
                          builder.getInt8(0)};
    Value *val43 = builder.CreateCall(ARGBFunc, ARGBArgs3);
    //   br label %44
    builder.CreateBr(BB44);

    // 44:                                               ; preds = %40, %42, %16
    builder.SetInsertPoint(BB44);
    //   %45 = phi i32 [ %17, %16 ], [ %41, %40 ], [ %43, %42 ]
    PHINode *val45 = builder.CreatePHI(builder.getInt32Ty(), 3);
    val45->addIncoming(val17, BB16);
    val45->addIncoming(val41, BB40);
    val45->addIncoming(val43, BB42);
    //   ret i32 %45
    builder.CreateRet(val45);
  }

  // define dso_local void @app()
  // local_unnamed_addr #1 {
  FunctionType *appFuncType = FunctionType::get(builder.getVoidTy(), false);
  Function *appFunc =
      Function::Create(appFuncType, Function::ExternalLinkage, "app", module);
  {
    BasicBlock *BB0 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB3 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB11 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB17 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB23 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB26 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB36 = BasicBlock::Create(context, "", appFunc);
    builder.SetInsertPoint(BB0);
    //   %1 = tail call i32 (...) @simCheckQuit() #4
    Value *val1 = builder.CreateCall(simCheckQuitFunc);
    //   %2 = icmp eq i32 %1, 0
    Value *val2 = builder.CreateICmpEQ(val1, builder.getInt32(0));
    //   br i1 %2, label %3, label %36
    builder.CreateCondBr(val2, BB3, BB36);

    // 3:                                                ; preds = %0, %17
    builder.SetInsertPoint(BB3);
    //   %4 = phi i64 [ %18, %17 ], [ 0, %0 ]
    PHINode *val4 = builder.CreatePHI(builder.getInt64Ty(), 2);
    val4->addIncoming(builder.getInt64(0), BB0);
    //   tail call void (...) @simPrepareScreen() #4
    builder.CreateCall(simPrepareScreenFunc, {});
    //   %5 = shl nuw nsw i64 %4, 11
    Value *val5 = builder.CreateShl(val4, builder.getInt64(11), "", true, true);
    //   %6 = or i64 %5, 175921860444160
    Value *val6 = builder.CreateOr(val5, builder.getInt64(175921860444160));
    //   %7 = trunc i64 %5 to i32
    Value *val7 = builder.CreateTrunc(val5, Type::getInt32Ty(context));
    //   %8 = lshr exact i32 %7, 3
    Value *val8 = builder.CreateLShr(val7, builder.getInt32(3), "", true);
    //   %9 = or i32 %8, -16777216
    Value *val9 = builder.CreateOr(val8, builder.getInt32(-16777216));
    //   %10 = trunc i64 %5 to i32
    Value *val10 = builder.CreateTrunc(val5, Type::getInt32Ty(context));
    //   br label %11
    builder.CreateBr(BB11);

    // 11:                                               ; preds = %3, %23
    builder.SetInsertPoint(BB11);
    //   %12 = phi i64 [ 0, %3 ], [ %24, %23 ]
    PHINode *val12 = builder.CreatePHI(builder.getInt64Ty(), 2);
    val12->addIncoming(builder.getInt64(0), BB3);
    //   %13 = shl nuw i64 %12, 1
    Value *val13 = builder.CreateShl(val12, builder.getInt64(1), "", true);
    //   %14 = add i64 %13, 4294966272
    Value *val14 = builder.CreateAdd(val13, builder.getInt64(4294966272));
    //   %15 = and i64 %14, 4294967294
    Value *val15 = builder.CreateAnd(val14, builder.getInt64(4294967294));
    //   %16 = trunc i64 %12 to i32
    Value *val16 = builder.CreateTrunc(val12, Type::getInt32Ty(context));
    //   br label %26
    builder.CreateBr(BB26);

    // 17:                                               ; preds = %23
    builder.SetInsertPoint(BB17);
    //   %18 = add nuw nsw i64 %4, 1
    Value *val18 = builder.CreateAdd(val4, builder.getInt64(1), "", true, true);
    val4->addIncoming(val18, BB17);
    //   tail call void (...) @simFlush() #4
    builder.CreateCall(simFlushFunc, {});
    //   %19 = tail call i32 (...) @simCheckQuit() #4
    Value *val19 = builder.CreateCall(simCheckQuitFunc, {});
    //   %20 = icmp eq i32 %19, 0
    Value *val20 = builder.CreateICmpEQ(val19, builder.getInt32(0));
    //   %21 = icmp ult i64 %4, 599
    Value *val21 = builder.CreateICmpULT(val4, builder.getInt64(599));
    //   %22 = select i1 %20, i1 %21, i1 false
    Value *val22 = builder.CreateSelect(val20, val21, builder.getInt1(false));
    //   br i1 %22, label %3, label %36, !llvm.loop !5
    builder.CreateCondBr(val22, BB3, BB36);

    // 23:                                               ; preds = %26
    builder.SetInsertPoint(BB23);
    //   %24 = add nuw nsw i64 %12, 1
    Value *val24 =
        builder.CreateAdd(val12, builder.getInt64(1), "", true, true);
    val12->addIncoming(val24, BB23);
    //   %25 = icmp eq i64 %24, 320
    Value *val25 = builder.CreateICmpEQ(val24, builder.getInt64(320));
    //   br i1 %25, label %17, label %11, !llvm.loop !7
    builder.CreateCondBr(val25, BB17, BB11);

    // 26:                                               ; preds = %11, %26
    builder.SetInsertPoint(BB26);
    //   %27 = phi i64 [ 0, %11 ], [ %34, %26 ]
    PHINode *val27 = builder.CreatePHI(builder.getInt64Ty(), 2);
    val27->addIncoming(builder.getInt64(0), BB11);
    //   %28 = shl i64 %27, 32
    Value *val28 = builder.CreateShl(val27, builder.getInt64(32));
    //   %29 = add i64 %28, -549755813888
    Value *val29 = builder.CreateAdd(val28, builder.getInt64(-549755813888));
    //   %30 = or i64 %29, %15
    Value *val30 = builder.CreateOr(val29, val15);
    //   %31 = tail call i32 @get_color(i64 %6, i32 %10, i64 %30, i32 -2048)
    Value *getColorArgs[] = {val6, val10, val30, builder.getInt32(-2048)};
    Value *val31 = builder.CreateCall(getColorFunc, getColorArgs);
    //   %32 = sub i32 %31, %9
    Value *val32 = builder.CreateSub(val31, val9);
    //   %33 = trunc i64 %27 to i32
    Value *val33 = builder.CreateTrunc(val27, Type::getInt32Ty(context));
    //   tail call void @simSetPixel(i32 noundef %16, i32 noundef %33, i32
    //   noundef %32) #4
    Value *simSetPixelArgs[] = {val16, val33, val32};
    builder.CreateCall(simSetPixelFunc, simSetPixelArgs);
    //   %34 = add nuw nsw i64 %27, 1
    Value *val34 =
        builder.CreateAdd(val27, builder.getInt64(1), "", true, true);
    val27->addIncoming(val34, BB26);
    //   %35 = icmp eq i64 %34, 240
    Value *val35 = builder.CreateICmpEQ(val34, builder.getInt64(240));
    //   br i1 %35, label %23, label %26, !llvm.loop !8
    builder.CreateCondBr(val35, BB23, BB26);

    // 36:                                               ; preds = %17, %0
    builder.SetInsertPoint(BB36);
    //   ret void
    builder.CreateRetVoid();
  }
  // Dump LLVM IR
  module->print(outs(), nullptr);

  // Interpreter of LLVM IR
  outs() << "Building code...\n";
  InitializeNativeTarget();
  InitializeNativeTargetAsmPrinter();

  ExecutionEngine *ee = EngineBuilder(std::unique_ptr<Module>(module)).create();
  ee->InstallLazyFunctionCreator([&](const std::string &fnName) -> void * {
    if (fnName == "simPrepareScreen") {
      return reinterpret_cast<void *>(simPrepareScreen);
    }
    if (fnName == "simCheckQuit") {
      return reinterpret_cast<void *>(simCheckQuit);
    }
    if (fnName == "simSetPixel") {
      return reinterpret_cast<void *>(simSetPixel);
    }
    if (fnName == "simFlush") {
      return reinterpret_cast<void *>(simFlush);
    }
    if (fnName == "ARGB") {
      return reinterpret_cast<void *>(ARGB);
    }
    return nullptr;
  });
  ee->finalizeObject();

  outs() << "Running code...\n";
  simInit();
  ArrayRef<GenericValue> noargs;
  GenericValue v = ee->runFunction(appFunc, noargs);
  simClose();
  outs() << "Code was run.\n";
  return EXIT_SUCCESS;
}