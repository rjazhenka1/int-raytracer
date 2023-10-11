; ModuleID = 'src/raytrace.c'
source_filename = "src/raytrace.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.vec3 = type { i32, i32, i32 }

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
  %34 = icmp sgt i32 %33, 1024
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
  %60 = call i32 @f_div(i32 noundef %59, i32 noundef 4096)
  %61 = call i32 @abs(i32 noundef %60) #4
  %62 = srem i32 %61, 8192
  store i32 %62, ptr %21, align 4
  %63 = getelementptr inbounds %struct.vec3, ptr %11, i32 0, i32 2
  %64 = load i32, ptr %63, align 4
  %65 = call i32 @f_div(i32 noundef %64, i32 noundef 4096)
  %66 = call i32 @abs(i32 noundef %65) #4
  %67 = srem i32 %66, 8192
  store i32 %67, ptr %22, align 4
  %68 = load i32, ptr %21, align 4
  %69 = icmp sgt i32 %68, 4096
  %70 = zext i1 %69 to i32
  %71 = load i32, ptr %22, align 4
  %72 = icmp sgt i32 %71, 4096
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

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

declare i32 @f_div(i32 noundef, i32 noundef) #2

declare i32 @ARGB(i8 noundef zeroext, i8 noundef zeroext, i8 noundef zeroext) #2

declare { i64, i32 } @v_add(i64, i32, i64, i32) #2

declare { i64, i32 } @v_mul(i64, i32, i64, i32) #2

declare { i64, i32 } @v_from_scalar(i32 noundef) #2

; Function Attrs: nounwind willreturn memory(none)
declare i32 @abs(i32 noundef) #3

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
