; ModuleID = 'src/screen.c'
source_filename = "src/screen.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ScreenMeta = type { ptr, ptr, ptr, ptr, i32, i32 }

@.str = private unnamed_addr constant [7 x i8] c"INT RT\00", align 1

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
define dso_local void @make_screen(ptr noalias sret(%struct.ScreenMeta) align 8 %0) #0 {
  %2 = call ptr @SDL_CreateWindow(ptr noundef @.str, i32 noundef 0, i32 noundef 0, i32 noundef 640, i32 noundef 480, i32 noundef 36)
  %3 = getelementptr inbounds %struct.ScreenMeta, ptr %0, i32 0, i32 0
  store ptr %2, ptr %3, align 8
  %4 = getelementptr inbounds %struct.ScreenMeta, ptr %0, i32 0, i32 0
  %5 = load ptr, ptr %4, align 8
  %6 = call ptr @SDL_CreateRenderer(ptr noundef %5, i32 noundef -1, i32 noundef 0)
  %7 = getelementptr inbounds %struct.ScreenMeta, ptr %0, i32 0, i32 1
  store ptr %6, ptr %7, align 8
  call void @update_screen(ptr noundef %0)
  ret void
}

declare ptr @SDL_CreateWindow(ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef) #1

declare ptr @SDL_CreateRenderer(ptr noundef, i32 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local void @update_screen(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %5 = load ptr, ptr %2, align 8
  %6 = getelementptr inbounds %struct.ScreenMeta, ptr %5, i32 0, i32 0
  %7 = load ptr, ptr %6, align 8
  call void @SDL_GetWindowSize(ptr noundef %7, ptr noundef %3, ptr noundef %4)
  %8 = load ptr, ptr %2, align 8
  %9 = getelementptr inbounds %struct.ScreenMeta, ptr %8, i32 0, i32 5
  %10 = load i32, ptr %9, align 4
  %11 = load i32, ptr %3, align 4
  %12 = icmp ne i32 %10, %11
  br i1 %12, label %19, label %13

13:                                               ; preds = %1
  %14 = load ptr, ptr %2, align 8
  %15 = getelementptr inbounds %struct.ScreenMeta, ptr %14, i32 0, i32 4
  %16 = load i32, ptr %15, align 8
  %17 = load i32, ptr %4, align 4
  %18 = icmp ne i32 %16, %17
  br i1 %18, label %19, label %38

19:                                               ; preds = %13, %1
  %20 = load i32, ptr %3, align 4
  %21 = load ptr, ptr %2, align 8
  %22 = getelementptr inbounds %struct.ScreenMeta, ptr %21, i32 0, i32 5
  store i32 %20, ptr %22, align 4
  %23 = load i32, ptr %4, align 4
  %24 = load ptr, ptr %2, align 8
  %25 = getelementptr inbounds %struct.ScreenMeta, ptr %24, i32 0, i32 4
  store i32 %23, ptr %25, align 8
  %26 = load ptr, ptr %2, align 8
  %27 = getelementptr inbounds %struct.ScreenMeta, ptr %26, i32 0, i32 1
  %28 = load ptr, ptr %27, align 8
  %29 = load ptr, ptr %2, align 8
  %30 = getelementptr inbounds %struct.ScreenMeta, ptr %29, i32 0, i32 5
  %31 = load i32, ptr %30, align 4
  %32 = load ptr, ptr %2, align 8
  %33 = getelementptr inbounds %struct.ScreenMeta, ptr %32, i32 0, i32 4
  %34 = load i32, ptr %33, align 8
  %35 = call ptr @SDL_CreateTexture(ptr noundef %28, i32 noundef 372645892, i32 noundef 1, i32 noundef %31, i32 noundef %34)
  %36 = load ptr, ptr %2, align 8
  %37 = getelementptr inbounds %struct.ScreenMeta, ptr %36, i32 0, i32 2
  store ptr %35, ptr %37, align 8
  br label %38

38:                                               ; preds = %19, %13
  ret void
}

declare void @SDL_GetWindowSize(ptr noundef, ptr noundef, ptr noundef) #1

declare ptr @SDL_CreateTexture(ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local void @lock_texture(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  store ptr %0, ptr %2, align 8
  %4 = load ptr, ptr %2, align 8
  %5 = getelementptr inbounds %struct.ScreenMeta, ptr %4, i32 0, i32 2
  %6 = load ptr, ptr %5, align 8
  %7 = load ptr, ptr %2, align 8
  %8 = getelementptr inbounds %struct.ScreenMeta, ptr %7, i32 0, i32 3
  %9 = call i32 @SDL_LockTexture(ptr noundef %6, ptr noundef null, ptr noundef %8, ptr noundef %3)
  ret void
}

declare i32 @SDL_LockTexture(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local void @unlock_texture(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct.ScreenMeta, ptr %3, i32 0, i32 2
  %5 = load ptr, ptr %4, align 8
  call void @SDL_UnlockTexture(ptr noundef %5)
  ret void
}

declare void @SDL_UnlockTexture(ptr noundef) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local void @put_pixel(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store ptr %0, ptr %5, align 8
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store i32 %3, ptr %8, align 4
  %9 = load i32, ptr %8, align 4
  %10 = load ptr, ptr %5, align 8
  %11 = getelementptr inbounds %struct.ScreenMeta, ptr %10, i32 0, i32 3
  %12 = load ptr, ptr %11, align 8
  %13 = load i32, ptr %6, align 4
  %14 = load i32, ptr %7, align 4
  %15 = load ptr, ptr %5, align 8
  %16 = getelementptr inbounds %struct.ScreenMeta, ptr %15, i32 0, i32 5
  %17 = load i32, ptr %16, align 4
  %18 = mul nsw i32 %14, %17
  %19 = add nsw i32 %13, %18
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds i32, ptr %12, i64 %20
  store i32 %9, ptr %21, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local void @flush(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct.ScreenMeta, ptr %3, i32 0, i32 1
  %5 = load ptr, ptr %4, align 8
  %6 = load ptr, ptr %2, align 8
  %7 = getelementptr inbounds %struct.ScreenMeta, ptr %6, i32 0, i32 2
  %8 = load ptr, ptr %7, align 8
  %9 = call i32 @SDL_RenderCopy(ptr noundef %5, ptr noundef %8, ptr noundef null, ptr noundef null)
  %10 = load ptr, ptr %2, align 8
  %11 = getelementptr inbounds %struct.ScreenMeta, ptr %10, i32 0, i32 1
  %12 = load ptr, ptr %11, align 8
  call void @SDL_RenderPresent(ptr noundef %12)
  ret void
}

declare i32 @SDL_RenderCopy(ptr noundef, ptr noundef, ptr noundef, ptr noundef) #1

declare void @SDL_RenderPresent(ptr noundef) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local void @destroy_screen(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = getelementptr inbounds %struct.ScreenMeta, ptr %3, i32 0, i32 1
  %5 = load ptr, ptr %4, align 8
  call void @SDL_DestroyRenderer(ptr noundef %5)
  %6 = load ptr, ptr %2, align 8
  %7 = getelementptr inbounds %struct.ScreenMeta, ptr %6, i32 0, i32 0
  %8 = load ptr, ptr %7, align 8
  call void @SDL_DestroyWindow(ptr noundef %8)
  ret void
}

declare void @SDL_DestroyRenderer(ptr noundef) #1

declare void @SDL_DestroyWindow(ptr noundef) #1

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
