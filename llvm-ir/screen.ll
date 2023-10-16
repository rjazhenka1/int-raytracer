; ModuleID = 'src/sim.c'
source_filename = "src/sim.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ScreenMeta = type { ptr, ptr, ptr, ptr, i32 }
%union.SDL_Event = type { %struct.SDL_SensorEvent, [8 x i8] }
%struct.SDL_SensorEvent = type { i32, i32, i32, [6 x float], i64 }
%struct.SDL_WindowEvent = type { i32, i32, i32, i8, i8, i8, i8, i32, i32 }

@.str = private unnamed_addr constant [7 x i8] c"INT RT\00", align 1
@meta = dso_local global %struct.ScreenMeta zeroinitializer, align 8

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local i32 @ARGB(i8 noundef zeroext %0, i8 noundef zeroext %1, i8 noundef zeroext %2) #0 {
  %4 = alloca i8, align 1
  %5 = alloca i8, align 1
  %6 = alloca i8, align 1
  store i8 %0, ptr %4, align 1
  store i8 %1, ptr %5, align 1
  store i8 %2, ptr %6, align 1
  %7 = load i8, ptr %4, align 1
  %8 = zext i8 %7 to i32
  %9 = shl i32 %8, 16
  %10 = or i32 -16777216, %9
  %11 = load i8, ptr %5, align 1
  %12 = zext i8 %11 to i32
  %13 = shl i32 %12, 8
  %14 = or i32 %10, %13
  %15 = load i8, ptr %6, align 1
  %16 = zext i8 %15 to i32
  %17 = or i32 %14, %16
  ret i32 %17
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local void @simInit() #0 {
  %1 = call ptr @SDL_CreateWindow(ptr noundef @.str, i32 noundef 0, i32 noundef 0, i32 noundef 1024, i32 noundef 768, i32 noundef 4)
  store ptr %1, ptr @meta, align 8
  %2 = load ptr, ptr @meta, align 8
  %3 = call ptr @SDL_CreateRenderer(ptr noundef %2, i32 noundef -1, i32 noundef 0)
  store ptr %3, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i32 0, i32 1), align 8
  call void @simPrepareScreen()
  %4 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i32 0, i32 1), align 8
  %5 = call ptr @SDL_CreateTexture(ptr noundef %4, i32 noundef 372645892, i32 noundef 1, i32 noundef 1024, i32 noundef 768)
  store ptr %5, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i32 0, i32 2), align 8
  ret void
}

declare ptr @SDL_CreateWindow(ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef) #1

declare ptr @SDL_CreateRenderer(ptr noundef, i32 noundef, i32 noundef) #1

declare ptr @SDL_CreateTexture(ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local void @simPrepareScreen() #0 {
  %1 = alloca i32, align 4
  %2 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i32 0, i32 2), align 8
  %3 = call i32 @SDL_LockTexture(ptr noundef %2, ptr noundef null, ptr noundef getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i32 0, i32 3), ptr noundef %1)
  ret void
}

declare i32 @SDL_LockTexture(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local void @simSetPixel(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %7 = load i32, ptr %6, align 4
  %8 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i32 0, i32 3), align 8
  %9 = load i32, ptr %4, align 4
  %10 = load i32, ptr %5, align 4
  %11 = mul nsw i32 %10, 1024
  %12 = add nsw i32 %9, %11
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds i32, ptr %8, i64 %13
  store i32 %7, ptr %14, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local i32 @simCheckQuit() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %union.SDL_Event, align 8
  store i32 0, ptr %1, align 4
  br label %3

3:                                                ; preds = %18, %0
  %4 = call i32 @SDL_PollEvent(ptr noundef %2)
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %6, label %19

6:                                                ; preds = %3
  %7 = load i32, ptr %2, align 8
  %8 = icmp eq i32 %7, 256
  br i1 %8, label %17, label %9

9:                                                ; preds = %6
  %10 = load i32, ptr %2, align 8
  %11 = icmp eq i32 %10, 512
  br i1 %11, label %12, label %18

12:                                               ; preds = %9
  %13 = getelementptr inbounds %struct.SDL_WindowEvent, ptr %2, i32 0, i32 3
  %14 = load i8, ptr %13, align 4
  %15 = zext i8 %14 to i32
  %16 = icmp eq i32 %15, 14
  br i1 %16, label %17, label %18

17:                                               ; preds = %12, %6
  store i32 1, ptr %1, align 4
  br label %18

18:                                               ; preds = %17, %12, %9
  br label %3, !llvm.loop !6

19:                                               ; preds = %3
  %20 = load i32, ptr %1, align 4
  ret i32 %20
}

declare i32 @SDL_PollEvent(ptr noundef) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local void @simFlush() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = call i32 @SDL_GetTicks()
  store i32 %3, ptr %1, align 4
  %4 = load i32, ptr %1, align 4
  %5 = load i32, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i32 0, i32 4), align 8
  %6 = sub i32 %4, %5
  store i32 %6, ptr %2, align 4
  %7 = load i32, ptr %2, align 4
  %8 = icmp ugt i32 %7, 16
  br i1 %8, label %9, label %11

9:                                                ; preds = %0
  %10 = load i32, ptr %1, align 4
  store i32 %10, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i32 0, i32 4), align 8
  br label %14

11:                                               ; preds = %0
  %12 = load i32, ptr %2, align 4
  %13 = sub i32 16, %12
  call void @SDL_Delay(i32 noundef %13)
  br label %14

14:                                               ; preds = %11, %9
  %15 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i32 0, i32 2), align 8
  call void @SDL_UnlockTexture(ptr noundef %15)
  %16 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i32 0, i32 1), align 8
  %17 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i32 0, i32 2), align 8
  %18 = call i32 @SDL_RenderCopy(ptr noundef %16, ptr noundef %17, ptr noundef null, ptr noundef null)
  %19 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i32 0, i32 1), align 8
  call void @SDL_RenderPresent(ptr noundef %19)
  ret void
}

declare i32 @SDL_GetTicks() #1

declare void @SDL_Delay(i32 noundef) #1

declare void @SDL_UnlockTexture(ptr noundef) #1

declare i32 @SDL_RenderCopy(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

declare void @SDL_RenderPresent(ptr noundef) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local void @simClose() #0 {
  %1 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i32 0, i32 1), align 8
  call void @SDL_DestroyRenderer(ptr noundef %1)
  %2 = load ptr, ptr @meta, align 8
  call void @SDL_DestroyWindow(ptr noundef %2)
  call void @SDL_Quit()
  ret void
}

declare void @SDL_DestroyRenderer(ptr noundef) #1

declare void @SDL_DestroyWindow(ptr noundef) #1

declare void @SDL_Quit() #1

attributes #0 = { noinline nounwind optnone sspstrong uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

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
