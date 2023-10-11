; ModuleID = 'src/main.c'
source_filename = "src/main.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ScreenMeta = type { ptr, ptr, ptr, ptr, i32, i32 }
%union.SDL_Event = type { %struct.SDL_SensorEvent, [8 x i8] }
%struct.SDL_SensorEvent = type { i32, i32, i32, [6 x float], i64 }
%struct.vec3 = type { i32, i32, i32 }
%struct.SDL_WindowEvent = type { i32, i32, i32, i8, i8, i8, i8, i32, i32 }

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca %struct.ScreenMeta, align 8
  %7 = alloca %union.SDL_Event, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca %struct.vec3, align 4
  %18 = alloca { i64, i32 }, align 8
  %19 = alloca %struct.vec3, align 4
  %20 = alloca { i64, i32 }, align 8
  %21 = alloca { i64, i32 }, align 4
  %22 = alloca { i64, i32 }, align 4
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  call void (ptr, ...) @make_screen(ptr sret(%struct.ScreenMeta) align 8 %6)
  store i32 0, ptr %8, align 4
  store i32 0, ptr %9, align 4
  store i32 0, ptr %11, align 4
  store i32 0, ptr %13, align 4
  br label %23

23:                                               ; preds = %104, %2
  %24 = load i32, ptr %13, align 4
  %25 = icmp ne i32 %24, 0
  %26 = xor i1 %25, true
  br i1 %26, label %27, label %105

27:                                               ; preds = %23
  %28 = call i32 @SDL_GetTicks()
  store i32 %28, ptr %10, align 4
  %29 = load i32, ptr %10, align 4
  %30 = load i32, ptr %11, align 4
  %31 = sub i32 %29, %30
  store i32 %31, ptr %12, align 4
  %32 = load i32, ptr %12, align 4
  %33 = icmp ugt i32 %32, 16
  br i1 %33, label %34, label %36

34:                                               ; preds = %27
  %35 = load i32, ptr %10, align 4
  store i32 %35, ptr %11, align 4
  br label %39

36:                                               ; preds = %27
  %37 = load i32, ptr %12, align 4
  %38 = sub i32 16, %37
  call void @SDL_Delay(i32 noundef %38)
  br label %39

39:                                               ; preds = %36, %34
  br label %40

40:                                               ; preds = %55, %39
  %41 = call i32 @SDL_PollEvent(ptr noundef %7)
  %42 = icmp ne i32 %41, 0
  br i1 %42, label %43, label %56

43:                                               ; preds = %40
  %44 = load i32, ptr %7, align 8
  %45 = icmp eq i32 %44, 256
  br i1 %45, label %54, label %46

46:                                               ; preds = %43
  %47 = load i32, ptr %7, align 8
  %48 = icmp eq i32 %47, 512
  br i1 %48, label %49, label %55

49:                                               ; preds = %46
  %50 = getelementptr inbounds %struct.SDL_WindowEvent, ptr %7, i32 0, i32 3
  %51 = load i8, ptr %50, align 4
  %52 = zext i8 %51 to i32
  %53 = icmp eq i32 %52, 14
  br i1 %53, label %54, label %55

54:                                               ; preds = %49, %43
  store i32 1, ptr %13, align 4
  br label %55

55:                                               ; preds = %54, %49, %46
  br label %40, !llvm.loop !6

56:                                               ; preds = %40
  call void @update_screen(ptr noundef %6)
  call void @lock_texture(ptr noundef %6)
  store i32 0, ptr %14, align 4
  br label %57

57:                                               ; preds = %101, %56
  %58 = load i32, ptr %14, align 4
  %59 = getelementptr inbounds %struct.ScreenMeta, ptr %6, i32 0, i32 5
  %60 = load i32, ptr %59, align 4
  %61 = icmp slt i32 %58, %60
  br i1 %61, label %62, label %104

62:                                               ; preds = %57
  store i32 0, ptr %15, align 4
  br label %63

63:                                               ; preds = %97, %62
  %64 = load i32, ptr %15, align 4
  %65 = getelementptr inbounds %struct.ScreenMeta, ptr %6, i32 0, i32 4
  %66 = load i32, ptr %65, align 8
  %67 = icmp slt i32 %64, %66
  br i1 %67, label %68, label %100

68:                                               ; preds = %63
  %69 = load i32, ptr %10, align 4
  %70 = load i32, ptr %14, align 4
  %71 = add i32 %69, %70
  %72 = load i32, ptr %15, align 4
  %73 = add i32 %71, %72
  store i32 %73, ptr %16, align 4
  %74 = load i32, ptr %14, align 4
  %75 = load i32, ptr %15, align 4
  %76 = load i32, ptr %10, align 4
  %77 = mul i32 %76, 20
  %78 = load i32, ptr %10, align 4
  %79 = mul i32 %78, 50
  %80 = call { i64, i32 } @v_from_scalars(i32 noundef %77, i32 noundef 20480, i32 noundef %79)
  store { i64, i32 } %80, ptr %18, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %17, ptr align 8 %18, i64 12, i1 false)
  %81 = load i32, ptr %14, align 4
  %82 = mul nsw i32 2, %81
  %83 = add nsw i32 -2048, %82
  %84 = load i32, ptr %15, align 4
  %85 = mul nsw i32 %84, 2
  %86 = add nsw i32 -512, %85
  %87 = call { i64, i32 } @v_from_scalars(i32 noundef %83, i32 noundef %86, i32 noundef -1024)
  store { i64, i32 } %87, ptr %20, align 8
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %19, ptr align 8 %20, i64 12, i1 false)
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %21, ptr align 4 %17, i64 12, i1 false)
  %88 = getelementptr inbounds { i64, i32 }, ptr %21, i32 0, i32 0
  %89 = load i64, ptr %88, align 4
  %90 = getelementptr inbounds { i64, i32 }, ptr %21, i32 0, i32 1
  %91 = load i32, ptr %90, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %22, ptr align 4 %19, i64 12, i1 false)
  %92 = getelementptr inbounds { i64, i32 }, ptr %22, i32 0, i32 0
  %93 = load i64, ptr %92, align 4
  %94 = getelementptr inbounds { i64, i32 }, ptr %22, i32 0, i32 1
  %95 = load i32, ptr %94, align 4
  %96 = call i32 @get_color(i64 %89, i32 %91, i64 %93, i32 %95)
  call void @put_pixel(ptr noundef %6, i32 noundef %74, i32 noundef %75, i32 noundef %96)
  br label %97

97:                                               ; preds = %68
  %98 = load i32, ptr %15, align 4
  %99 = add nsw i32 %98, 1
  store i32 %99, ptr %15, align 4
  br label %63, !llvm.loop !8

100:                                              ; preds = %63
  br label %101

101:                                              ; preds = %100
  %102 = load i32, ptr %14, align 4
  %103 = add nsw i32 %102, 1
  store i32 %103, ptr %14, align 4
  br label %57, !llvm.loop !9

104:                                              ; preds = %57
  call void @unlock_texture(ptr noundef %6)
  call void @flush(ptr noundef %6)
  br label %23, !llvm.loop !10

105:                                              ; preds = %23
  call void @destroy_screen(ptr noundef %6)
  call void @SDL_Quit()
  ret i32 0
}

declare void @make_screen(ptr sret(%struct.ScreenMeta) align 8, ...) #1

declare i32 @SDL_GetTicks() #1

declare void @SDL_Delay(i32 noundef) #1

declare i32 @SDL_PollEvent(ptr noundef) #1

declare void @update_screen(ptr noundef) #1

declare void @lock_texture(ptr noundef) #1

declare void @put_pixel(ptr noundef, i32 noundef, i32 noundef, i32 noundef) #1

declare i32 @get_color(i64, i32, i64, i32) #1

declare { i64, i32 } @v_from_scalars(i32 noundef, i32 noundef, i32 noundef) #1

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #2

declare void @unlock_texture(ptr noundef) #1

declare void @flush(ptr noundef) #1

declare void @destroy_screen(ptr noundef) #1

declare void @SDL_Quit() #1

attributes #0 = { noinline nounwind optnone sspstrong uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

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
!10 = distinct !{!10, !7}
