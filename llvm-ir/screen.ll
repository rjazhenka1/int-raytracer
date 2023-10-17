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

; Function Attrs: mustprogress nofree norecurse nosync nounwind sspstrong willreturn memory(none) uwtable
define dso_local i32 @ARGB(i8 noundef zeroext %0, i8 noundef zeroext %1, i8 noundef zeroext %2) local_unnamed_addr #0 {
  %4 = zext i8 %0 to i32
  %5 = shl nuw nsw i32 %4, 16
  %6 = zext i8 %1 to i32
  %7 = shl nuw nsw i32 %6, 8
  %8 = or i32 %7, %5
  %9 = zext i8 %2 to i32
  %10 = or i32 %8, %9
  %11 = or i32 %10, -16777216
  ret i32 %11
}

; Function Attrs: nounwind sspstrong uwtable
define dso_local void @simInit() local_unnamed_addr #1 {
  %1 = alloca i32, align 4
  %2 = tail call ptr @SDL_CreateWindow(ptr noundef nonnull @.str, i32 noundef 0, i32 noundef 0, i32 noundef 1024, i32 noundef 768, i32 noundef 4) #5
  store ptr %2, ptr @meta, align 8, !tbaa !5
  %3 = tail call ptr @SDL_CreateRenderer(ptr noundef %2, i32 noundef -1, i32 noundef 0) #5
  store ptr %3, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i64 0, i32 1), align 8, !tbaa !11
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %1) #5
  %4 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i64 0, i32 2), align 8, !tbaa !12
  %5 = call i32 @SDL_LockTexture(ptr noundef %4, ptr noundef null, ptr noundef nonnull getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i64 0, i32 3), ptr noundef nonnull %1) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %1) #5
  %6 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i64 0, i32 1), align 8, !tbaa !11
  %7 = call ptr @SDL_CreateTexture(ptr noundef %6, i32 noundef 372645892, i32 noundef 1, i32 noundef 1024, i32 noundef 768) #5
  store ptr %7, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i64 0, i32 2), align 8, !tbaa !12
  ret void
}

declare ptr @SDL_CreateWindow(ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

declare ptr @SDL_CreateRenderer(ptr noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

declare ptr @SDL_CreateTexture(ptr noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

; Function Attrs: nounwind sspstrong uwtable
define dso_local void @simPrepareScreen() local_unnamed_addr #1 {
  %1 = alloca i32, align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %1) #5
  %2 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i64 0, i32 2), align 8, !tbaa !12
  %3 = call i32 @SDL_LockTexture(ptr noundef %2, ptr noundef null, ptr noundef nonnull getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i64 0, i32 3), ptr noundef nonnull %1) #5
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %1) #5
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #3

declare i32 @SDL_LockTexture(ptr noundef, ptr noundef, ptr noundef, ptr noundef) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #3

; Function Attrs: mustprogress nofree norecurse nosync nounwind sspstrong willreturn memory(readwrite, argmem: write, inaccessiblemem: none) uwtable
define dso_local void @simSetPixel(i32 noundef %0, i32 noundef %1, i32 noundef %2) local_unnamed_addr #4 {
  %4 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i64 0, i32 3), align 8, !tbaa !13
  %5 = shl nsw i32 %1, 10
  %6 = add nsw i32 %5, %0
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds i32, ptr %4, i64 %7
  store i32 %2, ptr %8, align 4, !tbaa !14
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define dso_local i32 @simCheckQuit() local_unnamed_addr #1 {
  %1 = alloca %union.SDL_Event, align 8
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %1) #5
  %2 = call i32 @SDL_PollEvent(ptr noundef nonnull %1) #5
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %20, label %4

4:                                                ; preds = %0
  %5 = getelementptr inbounds %struct.SDL_WindowEvent, ptr %1, i64 0, i32 3
  br label %6

6:                                                ; preds = %4, %16
  %7 = phi i32 [ 0, %4 ], [ %17, %16 ]
  %8 = load i32, ptr %1, align 8, !tbaa !15
  %9 = icmp eq i32 %8, 256
  br i1 %9, label %15, label %10

10:                                               ; preds = %6
  %11 = icmp eq i32 %8, 512
  %12 = load i8, ptr %5, align 4
  %13 = icmp eq i8 %12, 14
  %14 = select i1 %11, i1 %13, i1 false
  br i1 %14, label %15, label %16

15:                                               ; preds = %10, %6
  br label %16

16:                                               ; preds = %15, %10
  %17 = phi i32 [ 1, %15 ], [ %7, %10 ]
  %18 = call i32 @SDL_PollEvent(ptr noundef nonnull %1) #5
  %19 = icmp eq i32 %18, 0
  br i1 %19, label %20, label %6, !llvm.loop !16

20:                                               ; preds = %16, %0
  %21 = phi i32 [ 0, %0 ], [ %17, %16 ]
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %1) #5
  ret i32 %21
}

declare i32 @SDL_PollEvent(ptr noundef) local_unnamed_addr #2

; Function Attrs: nounwind sspstrong uwtable
define dso_local void @simFlush() local_unnamed_addr #1 {
  %1 = tail call i32 @SDL_GetTicks() #5
  %2 = load i32, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i64 0, i32 4), align 8, !tbaa !18
  %3 = sub i32 %1, %2
  %4 = icmp ugt i32 %3, 16
  br i1 %4, label %5, label %6

5:                                                ; preds = %0
  store i32 %1, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i64 0, i32 4), align 8, !tbaa !18
  br label %8

6:                                                ; preds = %0
  %7 = sub nuw nsw i32 16, %3
  tail call void @SDL_Delay(i32 noundef %7) #5
  br label %8

8:                                                ; preds = %6, %5
  %9 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i64 0, i32 2), align 8, !tbaa !12
  tail call void @SDL_UnlockTexture(ptr noundef %9) #5
  %10 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i64 0, i32 1), align 8, !tbaa !11
  %11 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i64 0, i32 2), align 8, !tbaa !12
  %12 = tail call i32 @SDL_RenderCopy(ptr noundef %10, ptr noundef %11, ptr noundef null, ptr noundef null) #5
  %13 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i64 0, i32 1), align 8, !tbaa !11
  tail call void @SDL_RenderPresent(ptr noundef %13) #5
  ret void
}

declare i32 @SDL_GetTicks() local_unnamed_addr #2

declare void @SDL_Delay(i32 noundef) local_unnamed_addr #2

declare void @SDL_UnlockTexture(ptr noundef) local_unnamed_addr #2

declare i32 @SDL_RenderCopy(ptr noundef, ptr noundef, ptr noundef, ptr noundef) local_unnamed_addr #2

declare void @SDL_RenderPresent(ptr noundef) local_unnamed_addr #2

; Function Attrs: nounwind sspstrong uwtable
define dso_local void @simClose() local_unnamed_addr #1 {
  %1 = load ptr, ptr getelementptr inbounds (%struct.ScreenMeta, ptr @meta, i64 0, i32 1), align 8, !tbaa !11
  tail call void @SDL_DestroyRenderer(ptr noundef %1) #5
  %2 = load ptr, ptr @meta, align 8, !tbaa !5
  tail call void @SDL_DestroyWindow(ptr noundef %2) #5
  tail call void @SDL_Quit() #5
  ret void
}

declare void @SDL_DestroyRenderer(ptr noundef) local_unnamed_addr #2

declare void @SDL_DestroyWindow(ptr noundef) local_unnamed_addr #2

declare void @SDL_Quit() local_unnamed_addr #2

attributes #0 = { mustprogress nofree norecurse nosync nounwind sspstrong willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind sspstrong uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #4 = { mustprogress nofree norecurse nosync nounwind sspstrong willreturn memory(readwrite, argmem: write, inaccessiblemem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 16.0.6"}
!5 = !{!6, !7, i64 0}
!6 = !{!"ScreenMeta", !7, i64 0, !7, i64 8, !7, i64 16, !7, i64 24, !10, i64 32}
!7 = !{!"any pointer", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{!"int", !8, i64 0}
!11 = !{!6, !7, i64 8}
!12 = !{!6, !7, i64 16}
!13 = !{!6, !7, i64 24}
!14 = !{!10, !10, i64 0}
!15 = !{!8, !8, i64 0}
!16 = distinct !{!16, !17}
!17 = !{!"llvm.loop.mustprogress"}
!18 = !{!6, !10, i64 32}
