; ModuleID = 'src/raytrace.c'
source_filename = "src/raytrace.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.vec3 = type { i32, i32, i32 }

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local i32 @f_mul(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = sdiv i32 %6, 2048
  %8 = mul nsw i32 %5, %7
  ret i32 %8
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local i32 @f_div(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  %6 = load i32, ptr %5, align 4
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %13

8:                                                ; preds = %2
  %9 = load i32, ptr %4, align 4
  %10 = icmp sge i32 %9, 0
  %11 = zext i1 %10 to i64
  %12 = select i1 %10, i32 2147483647, i32 -2147483648
  store i32 %12, ptr %3, align 4
  br label %18

13:                                               ; preds = %2
  %14 = load i32, ptr %4, align 4
  %15 = mul nsw i32 %14, 2048
  %16 = load i32, ptr %5, align 4
  %17 = sdiv i32 %15, %16
  store i32 %17, ptr %3, align 4
  br label %18

18:                                               ; preds = %13, %8
  %19 = load i32, ptr %3, align 4
  ret i32 %19
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local { i64, i32 } @v_add(i64 %0, i32 %1, i64 %2, i32 %3) #0 {
  %5 = alloca %struct.vec3, align 4
  %6 = alloca %struct.vec3, align 4
  %7 = alloca { i64, i32 }, align 4
  %8 = alloca %struct.vec3, align 4
  %9 = alloca { i64, i32 }, align 4
  %10 = alloca { i64, i32 }, align 8
  %11 = getelementptr inbounds { i64, i32 }, ptr %7, i32 0, i32 0
  store i64 %0, ptr %11, align 4
  %12 = getelementptr inbounds { i64, i32 }, ptr %7, i32 0, i32 1
  store i32 %1, ptr %12, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %6, ptr align 4 %7, i64 12, i1 false)
  %13 = getelementptr inbounds { i64, i32 }, ptr %9, i32 0, i32 0
  store i64 %2, ptr %13, align 4
  %14 = getelementptr inbounds { i64, i32 }, ptr %9, i32 0, i32 1
  store i32 %3, ptr %14, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %8, ptr align 4 %9, i64 12, i1 false)
  %15 = getelementptr inbounds %struct.vec3, ptr %5, i32 0, i32 0
  %16 = getelementptr inbounds %struct.vec3, ptr %6, i32 0, i32 0
  %17 = load i32, ptr %16, align 4
  %18 = getelementptr inbounds %struct.vec3, ptr %8, i32 0, i32 0
  %19 = load i32, ptr %18, align 4
  %20 = add nsw i32 %17, %19
  store i32 %20, ptr %15, align 4
  %21 = getelementptr inbounds %struct.vec3, ptr %5, i32 0, i32 1
  %22 = getelementptr inbounds %struct.vec3, ptr %6, i32 0, i32 1
  %23 = load i32, ptr %22, align 4
  %24 = getelementptr inbounds %struct.vec3, ptr %8, i32 0, i32 1
  %25 = load i32, ptr %24, align 4
  %26 = add nsw i32 %23, %25
  store i32 %26, ptr %21, align 4
  %27 = getelementptr inbounds %struct.vec3, ptr %5, i32 0, i32 2
  %28 = getelementptr inbounds %struct.vec3, ptr %6, i32 0, i32 2
  %29 = load i32, ptr %28, align 4
  %30 = getelementptr inbounds %struct.vec3, ptr %8, i32 0, i32 2
  %31 = load i32, ptr %30, align 4
  %32 = add nsw i32 %29, %31
  store i32 %32, ptr %27, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %10, ptr align 4 %5, i64 12, i1 false)
  %33 = load { i64, i32 }, ptr %10, align 8
  ret { i64, i32 } %33
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local { i64, i32 } @v_sub(i64 %0, i32 %1, i64 %2, i32 %3) #0 {
  %5 = alloca %struct.vec3, align 4
  %6 = alloca %struct.vec3, align 4
  %7 = alloca { i64, i32 }, align 4
  %8 = alloca %struct.vec3, align 4
  %9 = alloca { i64, i32 }, align 4
  %10 = alloca { i64, i32 }, align 8
  %11 = getelementptr inbounds { i64, i32 }, ptr %7, i32 0, i32 0
  store i64 %0, ptr %11, align 4
  %12 = getelementptr inbounds { i64, i32 }, ptr %7, i32 0, i32 1
  store i32 %1, ptr %12, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %6, ptr align 4 %7, i64 12, i1 false)
  %13 = getelementptr inbounds { i64, i32 }, ptr %9, i32 0, i32 0
  store i64 %2, ptr %13, align 4
  %14 = getelementptr inbounds { i64, i32 }, ptr %9, i32 0, i32 1
  store i32 %3, ptr %14, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %8, ptr align 4 %9, i64 12, i1 false)
  %15 = getelementptr inbounds %struct.vec3, ptr %5, i32 0, i32 0
  %16 = getelementptr inbounds %struct.vec3, ptr %6, i32 0, i32 0
  %17 = load i32, ptr %16, align 4
  %18 = getelementptr inbounds %struct.vec3, ptr %8, i32 0, i32 0
  %19 = load i32, ptr %18, align 4
  %20 = sub nsw i32 %17, %19
  store i32 %20, ptr %15, align 4
  %21 = getelementptr inbounds %struct.vec3, ptr %5, i32 0, i32 1
  %22 = getelementptr inbounds %struct.vec3, ptr %6, i32 0, i32 1
  %23 = load i32, ptr %22, align 4
  %24 = getelementptr inbounds %struct.vec3, ptr %8, i32 0, i32 1
  %25 = load i32, ptr %24, align 4
  %26 = sub nsw i32 %23, %25
  store i32 %26, ptr %21, align 4
  %27 = getelementptr inbounds %struct.vec3, ptr %5, i32 0, i32 2
  %28 = getelementptr inbounds %struct.vec3, ptr %6, i32 0, i32 2
  %29 = load i32, ptr %28, align 4
  %30 = getelementptr inbounds %struct.vec3, ptr %8, i32 0, i32 2
  %31 = load i32, ptr %30, align 4
  %32 = sub nsw i32 %29, %31
  store i32 %32, ptr %27, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %10, ptr align 4 %5, i64 12, i1 false)
  %33 = load { i64, i32 }, ptr %10, align 8
  ret { i64, i32 } %33
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local { i64, i32 } @v_mul(i64 %0, i32 %1, i64 %2, i32 %3) #0 {
  %5 = alloca %struct.vec3, align 4
  %6 = alloca %struct.vec3, align 4
  %7 = alloca { i64, i32 }, align 4
  %8 = alloca %struct.vec3, align 4
  %9 = alloca { i64, i32 }, align 4
  %10 = alloca { i64, i32 }, align 8
  %11 = getelementptr inbounds { i64, i32 }, ptr %7, i32 0, i32 0
  store i64 %0, ptr %11, align 4
  %12 = getelementptr inbounds { i64, i32 }, ptr %7, i32 0, i32 1
  store i32 %1, ptr %12, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %6, ptr align 4 %7, i64 12, i1 false)
  %13 = getelementptr inbounds { i64, i32 }, ptr %9, i32 0, i32 0
  store i64 %2, ptr %13, align 4
  %14 = getelementptr inbounds { i64, i32 }, ptr %9, i32 0, i32 1
  store i32 %3, ptr %14, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %8, ptr align 4 %9, i64 12, i1 false)
  %15 = getelementptr inbounds %struct.vec3, ptr %5, i32 0, i32 0
  %16 = getelementptr inbounds %struct.vec3, ptr %6, i32 0, i32 0
  %17 = load i32, ptr %16, align 4
  %18 = getelementptr inbounds %struct.vec3, ptr %8, i32 0, i32 0
  %19 = load i32, ptr %18, align 4
  %20 = call i32 @f_mul(i32 noundef %17, i32 noundef %19)
  store i32 %20, ptr %15, align 4
  %21 = getelementptr inbounds %struct.vec3, ptr %5, i32 0, i32 1
  %22 = getelementptr inbounds %struct.vec3, ptr %6, i32 0, i32 1
  %23 = load i32, ptr %22, align 4
  %24 = getelementptr inbounds %struct.vec3, ptr %8, i32 0, i32 1
  %25 = load i32, ptr %24, align 4
  %26 = call i32 @f_mul(i32 noundef %23, i32 noundef %25)
  store i32 %26, ptr %21, align 4
  %27 = getelementptr inbounds %struct.vec3, ptr %5, i32 0, i32 2
  %28 = getelementptr inbounds %struct.vec3, ptr %6, i32 0, i32 2
  %29 = load i32, ptr %28, align 4
  %30 = getelementptr inbounds %struct.vec3, ptr %8, i32 0, i32 2
  %31 = load i32, ptr %30, align 4
  %32 = call i32 @f_mul(i32 noundef %29, i32 noundef %31)
  store i32 %32, ptr %27, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %10, ptr align 4 %5, i64 12, i1 false)
  %33 = load { i64, i32 }, ptr %10, align 8
  ret { i64, i32 } %33
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local { i64, i32 } @v_div(i64 %0, i32 %1, i64 %2, i32 %3) #0 {
  %5 = alloca %struct.vec3, align 4
  %6 = alloca %struct.vec3, align 4
  %7 = alloca { i64, i32 }, align 4
  %8 = alloca %struct.vec3, align 4
  %9 = alloca { i64, i32 }, align 4
  %10 = alloca { i64, i32 }, align 8
  %11 = getelementptr inbounds { i64, i32 }, ptr %7, i32 0, i32 0
  store i64 %0, ptr %11, align 4
  %12 = getelementptr inbounds { i64, i32 }, ptr %7, i32 0, i32 1
  store i32 %1, ptr %12, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %6, ptr align 4 %7, i64 12, i1 false)
  %13 = getelementptr inbounds { i64, i32 }, ptr %9, i32 0, i32 0
  store i64 %2, ptr %13, align 4
  %14 = getelementptr inbounds { i64, i32 }, ptr %9, i32 0, i32 1
  store i32 %3, ptr %14, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %8, ptr align 4 %9, i64 12, i1 false)
  %15 = getelementptr inbounds %struct.vec3, ptr %5, i32 0, i32 0
  %16 = getelementptr inbounds %struct.vec3, ptr %6, i32 0, i32 0
  %17 = load i32, ptr %16, align 4
  %18 = getelementptr inbounds %struct.vec3, ptr %8, i32 0, i32 0
  %19 = load i32, ptr %18, align 4
  %20 = call i32 @f_div(i32 noundef %17, i32 noundef %19)
  store i32 %20, ptr %15, align 4
  %21 = getelementptr inbounds %struct.vec3, ptr %5, i32 0, i32 1
  %22 = getelementptr inbounds %struct.vec3, ptr %6, i32 0, i32 1
  %23 = load i32, ptr %22, align 4
  %24 = getelementptr inbounds %struct.vec3, ptr %8, i32 0, i32 1
  %25 = load i32, ptr %24, align 4
  %26 = call i32 @f_div(i32 noundef %23, i32 noundef %25)
  store i32 %26, ptr %21, align 4
  %27 = getelementptr inbounds %struct.vec3, ptr %5, i32 0, i32 2
  %28 = getelementptr inbounds %struct.vec3, ptr %6, i32 0, i32 2
  %29 = load i32, ptr %28, align 4
  %30 = getelementptr inbounds %struct.vec3, ptr %8, i32 0, i32 2
  %31 = load i32, ptr %30, align 4
  %32 = call i32 @f_div(i32 noundef %29, i32 noundef %31)
  store i32 %32, ptr %27, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %10, ptr align 4 %5, i64 12, i1 false)
  %33 = load { i64, i32 }, ptr %10, align 8
  ret { i64, i32 } %33
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local { i64, i32 } @v_neg(i64 %0, i32 %1) #0 {
  %3 = alloca %struct.vec3, align 4
  %4 = alloca %struct.vec3, align 4
  %5 = alloca { i64, i32 }, align 4
  %6 = alloca { i64, i32 }, align 8
  %7 = getelementptr inbounds { i64, i32 }, ptr %5, i32 0, i32 0
  store i64 %0, ptr %7, align 4
  %8 = getelementptr inbounds { i64, i32 }, ptr %5, i32 0, i32 1
  store i32 %1, ptr %8, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %4, ptr align 4 %5, i64 12, i1 false)
  %9 = getelementptr inbounds %struct.vec3, ptr %3, i32 0, i32 0
  %10 = getelementptr inbounds %struct.vec3, ptr %4, i32 0, i32 0
  %11 = load i32, ptr %10, align 4
  %12 = sub nsw i32 0, %11
  store i32 %12, ptr %9, align 4
  %13 = getelementptr inbounds %struct.vec3, ptr %3, i32 0, i32 1
  %14 = getelementptr inbounds %struct.vec3, ptr %4, i32 0, i32 1
  %15 = load i32, ptr %14, align 4
  %16 = sub nsw i32 0, %15
  store i32 %16, ptr %13, align 4
  %17 = getelementptr inbounds %struct.vec3, ptr %3, i32 0, i32 2
  %18 = getelementptr inbounds %struct.vec3, ptr %4, i32 0, i32 2
  %19 = load i32, ptr %18, align 4
  %20 = sub nsw i32 0, %19
  store i32 %20, ptr %17, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %6, ptr align 4 %3, i64 12, i1 false)
  %21 = load { i64, i32 }, ptr %6, align 8
  ret { i64, i32 } %21
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local { i64, i32 } @v_from_scalars(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca %struct.vec3, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca { i64, i32 }, align 8
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  %9 = getelementptr inbounds %struct.vec3, ptr %4, i32 0, i32 0
  %10 = load i32, ptr %5, align 4
  store i32 %10, ptr %9, align 4
  %11 = getelementptr inbounds %struct.vec3, ptr %4, i32 0, i32 1
  %12 = load i32, ptr %6, align 4
  store i32 %12, ptr %11, align 4
  %13 = getelementptr inbounds %struct.vec3, ptr %4, i32 0, i32 2
  %14 = load i32, ptr %7, align 4
  store i32 %14, ptr %13, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %8, ptr align 4 %4, i64 12, i1 false)
  %15 = load { i64, i32 }, ptr %8, align 8
  ret { i64, i32 } %15
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local { i64, i32 } @v_from_scalar(i32 noundef %0) #0 {
  %2 = alloca %struct.vec3, align 4
  %3 = alloca i32, align 4
  %4 = alloca { i64, i32 }, align 8
  store i32 %0, ptr %3, align 4
  %5 = getelementptr inbounds %struct.vec3, ptr %2, i32 0, i32 0
  %6 = load i32, ptr %3, align 4
  store i32 %6, ptr %5, align 4
  %7 = getelementptr inbounds %struct.vec3, ptr %2, i32 0, i32 1
  %8 = load i32, ptr %3, align 4
  store i32 %8, ptr %7, align 4
  %9 = getelementptr inbounds %struct.vec3, ptr %2, i32 0, i32 2
  %10 = load i32, ptr %3, align 4
  store i32 %10, ptr %9, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 8 %4, ptr align 4 %2, i64 12, i1 false)
  %11 = load { i64, i32 }, ptr %4, align 8
  ret { i64, i32 } %11
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local i32 @get_color(i64 %0, i32 %1, i64 %2, i32 %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca %struct.vec3, align 4
  %7 = alloca { i64, i32 }, align 4
  %8 = alloca %struct.vec3, align 4
  %9 = alloca { i64, i32 }, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.vec3, align 4
  %12 = alloca %struct.vec3, align 4
  %13 = alloca %struct.vec3, align 4
  %14 = alloca { i64, i32 }, align 8
  %15 = alloca { i64, i32 }, align 4
  %16 = alloca { i64, i32 }, align 4
  %17 = alloca { i64, i32 }, align 8
  %18 = alloca { i64, i32 }, align 4
  %19 = alloca { i64, i32 }, align 4
  %20 = alloca { i64, i32 }, align 8
  %21 = alloca i32, align 4
  %22 = alloca i32, align 4
  %23 = getelementptr inbounds { i64, i32 }, ptr %7, i32 0, i32 0
  store i64 %0, ptr %23, align 4
  %24 = getelementptr inbounds { i64, i32 }, ptr %7, i32 0, i32 1
  store i32 %1, ptr %24, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %6, ptr align 4 %7, i64 12, i1 false)
  %25 = getelementptr inbounds { i64, i32 }, ptr %9, i32 0, i32 0
  store i64 %2, ptr %25, align 4
  %26 = getelementptr inbounds { i64, i32 }, ptr %9, i32 0, i32 1
  store i32 %3, ptr %26, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %8, ptr align 4 %9, i64 12, i1 false)
  %27 = getelementptr inbounds %struct.vec3, ptr %6, i32 0, i32 1
  %28 = load i32, ptr %27, align 4
  %29 = getelementptr inbounds %struct.vec3, ptr %8, i32 0, i32 1
  %30 = load i32, ptr %29, align 4
  %31 = call i32 @f_div(i32 noundef %28, i32 noundef %30)
  %32 = sub nsw i32 0, %31
  store i32 %32, ptr %10, align 4
  %33 = load i32, ptr %10, align 4
  %34 = icmp sgt i32 %33, 2048
  br i1 %34, label %35, label %37

35:                                               ; preds = %4
  %36 = call i32 @ARGB(i8 noundef zeroext 0, i8 noundef zeroext 127, i8 noundef zeroext 127)
  store i32 %36, ptr %5, align 4
  br label %81

37:                                               ; preds = %4
  %38 = load i32, ptr %10, align 4
  %39 = call { i64, i32 } @v_from_scalar(i32 noundef %38)
  store { i64, i32 } %39, ptr %14, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %13, ptr align 8 %14, i64 12, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %15, ptr align 4 %8, i64 12, i1 false)
  %40 = getelementptr inbounds { i64, i32 }, ptr %15, i32 0, i32 0
  %41 = load i64, ptr %40, align 4
  %42 = getelementptr inbounds { i64, i32 }, ptr %15, i32 0, i32 1
  %43 = load i32, ptr %42, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %16, ptr align 4 %13, i64 12, i1 false)
  %44 = getelementptr inbounds { i64, i32 }, ptr %16, i32 0, i32 0
  %45 = load i64, ptr %44, align 4
  %46 = getelementptr inbounds { i64, i32 }, ptr %16, i32 0, i32 1
  %47 = load i32, ptr %46, align 4
  %48 = call { i64, i32 } @v_mul(i64 %41, i32 %43, i64 %45, i32 %47)
  store { i64, i32 } %48, ptr %17, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %12, ptr align 8 %17, i64 12, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %18, ptr align 4 %6, i64 12, i1 false)
  %49 = getelementptr inbounds { i64, i32 }, ptr %18, i32 0, i32 0
  %50 = load i64, ptr %49, align 4
  %51 = getelementptr inbounds { i64, i32 }, ptr %18, i32 0, i32 1
  %52 = load i32, ptr %51, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %19, ptr align 4 %12, i64 12, i1 false)
  %53 = getelementptr inbounds { i64, i32 }, ptr %19, i32 0, i32 0
  %54 = load i64, ptr %53, align 4
  %55 = getelementptr inbounds { i64, i32 }, ptr %19, i32 0, i32 1
  %56 = load i32, ptr %55, align 4
  %57 = call { i64, i32 } @v_add(i64 %50, i32 %52, i64 %54, i32 %56)
  store { i64, i32 } %57, ptr %20, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %11, ptr align 8 %20, i64 12, i1 false)
  %58 = getelementptr inbounds %struct.vec3, ptr %11, i32 0, i32 0
  %59 = load i32, ptr %58, align 4
  %60 = call i32 @f_div(i32 noundef %59, i32 noundef 8192)
  %61 = call i32 @abs(i32 noundef %60) #4
  %62 = srem i32 %61, 16384
  store i32 %62, ptr %21, align 4
  %63 = getelementptr inbounds %struct.vec3, ptr %11, i32 0, i32 2
  %64 = load i32, ptr %63, align 4
  %65 = call i32 @f_div(i32 noundef %64, i32 noundef 8192)
  %66 = call i32 @abs(i32 noundef %65) #4
  %67 = srem i32 %66, 16384
  store i32 %67, ptr %22, align 4
  %68 = load i32, ptr %21, align 4
  %69 = icmp sgt i32 %68, 8192
  %70 = zext i1 %69 to i32
  %71 = load i32, ptr %22, align 4
  %72 = icmp sgt i32 %71, 8192
  %73 = zext i1 %72 to i32
  %74 = add nsw i32 %70, %73
  %75 = srem i32 %74, 2
  %76 = icmp ne i32 %75, 0
  br i1 %76, label %77, label %79

77:                                               ; preds = %37
  %78 = call i32 @ARGB(i8 noundef zeroext -1, i8 noundef zeroext -1, i8 noundef zeroext -1)
  store i32 %78, ptr %5, align 4
  br label %81

79:                                               ; preds = %37
  %80 = call i32 @ARGB(i8 noundef zeroext 0, i8 noundef zeroext 0, i8 noundef zeroext 0)
  store i32 %80, ptr %5, align 4
  br label %81

81:                                               ; preds = %79, %77, %35
  %82 = load i32, ptr %5, align 4
  ret i32 %82
}

declare i32 @ARGB(i8 noundef zeroext, i8 noundef zeroext, i8 noundef zeroext) #2

; Function Attrs: nounwind willreturn memory(none)
declare i32 @abs(i32 noundef) #3

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local void @app() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca %struct.vec3, align 4
  %5 = alloca { i64, i32 }, align 8
  %6 = alloca %struct.vec3, align 4
  %7 = alloca { i64, i32 }, align 8
  %8 = alloca { i64, i32 }, align 4
  %9 = alloca { i64, i32 }, align 4
  store i32 0, ptr %1, align 4
  br label %10

10:                                               ; preds = %57, %0
  %11 = call i32 (...) @simCheckQuit()
  %12 = icmp ne i32 %11, 0
  %13 = xor i1 %12, true
  br i1 %13, label %14, label %60

14:                                               ; preds = %10
  call void (...) @simPrepareScreen()
  store i32 0, ptr %2, align 4
  br label %15

15:                                               ; preds = %54, %14
  %16 = load i32, ptr %2, align 4
  %17 = icmp slt i32 %16, 1024
  br i1 %17, label %18, label %57

18:                                               ; preds = %15
  store i32 0, ptr %3, align 4
  br label %19

19:                                               ; preds = %50, %18
  %20 = load i32, ptr %3, align 4
  %21 = icmp slt i32 %20, 768
  br i1 %21, label %22, label %53

22:                                               ; preds = %19
  %23 = load i32, ptr %2, align 4
  %24 = load i32, ptr %3, align 4
  %25 = load i32, ptr %1, align 4
  %26 = mul i32 %25, 2048
  %27 = load i32, ptr %1, align 4
  %28 = mul i32 %27, 2048
  %29 = call { i64, i32 } @v_from_scalars(i32 noundef %26, i32 noundef 40960, i32 noundef %28)
  store { i64, i32 } %29, ptr %5, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %4, ptr align 8 %5, i64 12, i1 false)
  %30 = load i32, ptr %2, align 4
  %31 = mul nsw i32 2, %30
  %32 = add nsw i32 -1024, %31
  %33 = load i32, ptr %3, align 4
  %34 = add nsw i32 -128, %33
  %35 = call { i64, i32 } @v_from_scalars(i32 noundef %32, i32 noundef %34, i32 noundef -2048)
  store { i64, i32 } %35, ptr %7, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %6, ptr align 8 %7, i64 12, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %8, ptr align 4 %4, i64 12, i1 false)
  %36 = getelementptr inbounds { i64, i32 }, ptr %8, i32 0, i32 0
  %37 = load i64, ptr %36, align 4
  %38 = getelementptr inbounds { i64, i32 }, ptr %8, i32 0, i32 1
  %39 = load i32, ptr %38, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %9, ptr align 4 %6, i64 12, i1 false)
  %40 = getelementptr inbounds { i64, i32 }, ptr %9, i32 0, i32 0
  %41 = load i64, ptr %40, align 4
  %42 = getelementptr inbounds { i64, i32 }, ptr %9, i32 0, i32 1
  %43 = load i32, ptr %42, align 4
  %44 = call i32 @get_color(i64 %37, i32 %39, i64 %41, i32 %43)
  %45 = load i32, ptr %1, align 4
  %46 = mul i32 %45, 2048
  %47 = udiv i32 %46, 8
  %48 = or i32 %47, -16777216
  %49 = sub i32 %44, %48
  call void @simSetPixel(i32 noundef %23, i32 noundef %24, i32 noundef %49)
  br label %50

50:                                               ; preds = %22
  %51 = load i32, ptr %3, align 4
  %52 = add nsw i32 %51, 1
  store i32 %52, ptr %3, align 4
  br label %19, !llvm.loop !6

53:                                               ; preds = %19
  br label %54

54:                                               ; preds = %53
  %55 = load i32, ptr %2, align 4
  %56 = add nsw i32 %55, 1
  store i32 %56, ptr %2, align 4
  br label %15, !llvm.loop !8

57:                                               ; preds = %15
  %58 = load i32, ptr %1, align 4
  %59 = add i32 %58, 1
  store i32 %59, ptr %1, align 4
  call void (...) @simFlush()
  br label %10, !llvm.loop !9

60:                                               ; preds = %10
  ret void
}

declare i32 @simCheckQuit(...) #2

declare void @simPrepareScreen(...) #2

declare void @simSetPixel(i32 noundef, i32 noundef, i32 noundef) #2

declare void @simFlush(...) #2

attributes #0 = { noinline nounwind optnone sspstrong uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind willreturn memory(none) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind willreturn memory(none) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 16.0.6"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
