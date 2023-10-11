; ModuleID = 'src/vec.c'
source_filename = "src/vec.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.vec3 = type { i32, i32, i32 }

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

declare i32 @f_mul(i32 noundef, i32 noundef) #2

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

declare i32 @f_div(i32 noundef, i32 noundef) #2

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

attributes #0 = { noinline nounwind optnone sspstrong uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 16.0.6"}
