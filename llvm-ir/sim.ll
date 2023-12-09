; ModuleID = 'src/sim.c'
source_filename = "src/sim.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.ScreenMeta = type { %struct.SDL_Window*, %struct.SDL_Renderer*, %struct.SDL_Texture*, i32*, i32 }
%struct.SDL_Window = type opaque
%struct.SDL_Renderer = type opaque
%struct.SDL_Texture = type opaque
%struct.SDL_Rect = type { i32, i32, i32, i32 }
%union.SDL_Event = type { %struct.SDL_TouchFingerEvent, [8 x i8] }
%struct.SDL_TouchFingerEvent = type { i32, i32, i64, i64, float, float, float, float, float, i32 }
%struct.SDL_WindowEvent = type { i32, i32, i32, i8, i8, i8, i8, i32, i32 }

@.str = private unnamed_addr constant [7 x i8] c"INT RT\00", align 1
@meta = dso_local global %struct.ScreenMeta zeroinitializer, align 8

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn
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

; Function Attrs: nounwind uwtable
define dso_local void @simInit() local_unnamed_addr #1 {
  %1 = alloca i32, align 4
  %2 = tail call %struct.SDL_Window* @SDL_CreateWindow(i8* noundef getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i64 0, i64 0), i32 noundef 0, i32 noundef 0, i32 noundef 320, i32 noundef 240, i32 noundef 4) #5
  store %struct.SDL_Window* %2, %struct.SDL_Window** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 0), align 8, !tbaa !5
  %3 = tail call %struct.SDL_Renderer* @SDL_CreateRenderer(%struct.SDL_Window* noundef %2, i32 noundef -1, i32 noundef 0) #5
  store %struct.SDL_Renderer* %3, %struct.SDL_Renderer** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 1), align 8, !tbaa !11
  %4 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %4) #5
  %5 = load %struct.SDL_Texture*, %struct.SDL_Texture** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 2), align 8, !tbaa !12
  %6 = call i32 @SDL_LockTexture(%struct.SDL_Texture* noundef %5, %struct.SDL_Rect* noundef null, i8** noundef bitcast (i32** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 3) to i8**), i32* noundef nonnull %1) #5
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %4) #5
  %7 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 1), align 8, !tbaa !11
  %8 = call %struct.SDL_Texture* @SDL_CreateTexture(%struct.SDL_Renderer* noundef %7, i32 noundef 372645892, i32 noundef 1, i32 noundef 320, i32 noundef 240) #5
  store %struct.SDL_Texture* %8, %struct.SDL_Texture** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 2), align 8, !tbaa !12
  %9 = call i32 @SDL_GetTicks() #5
  %10 = load i32, i32* getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 4), align 8, !tbaa !13
  %11 = sub i32 %9, %10
  %12 = icmp ugt i32 %11, 16
  br i1 %12, label %13, label %14

13:                                               ; preds = %0
  store i32 %9, i32* getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 4), align 8, !tbaa !13
  br label %16

14:                                               ; preds = %0
  %15 = sub nuw nsw i32 16, %11
  call void @SDL_Delay(i32 noundef %15) #5
  br label %16

16:                                               ; preds = %13, %14
  %17 = load %struct.SDL_Texture*, %struct.SDL_Texture** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 2), align 8, !tbaa !12
  call void @SDL_UnlockTexture(%struct.SDL_Texture* noundef %17) #5
  %18 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 1), align 8, !tbaa !11
  %19 = load %struct.SDL_Texture*, %struct.SDL_Texture** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 2), align 8, !tbaa !12
  %20 = call i32 @SDL_RenderCopy(%struct.SDL_Renderer* noundef %18, %struct.SDL_Texture* noundef %19, %struct.SDL_Rect* noundef null, %struct.SDL_Rect* noundef null) #5
  %21 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 1), align 8, !tbaa !11
  call void @SDL_RenderPresent(%struct.SDL_Renderer* noundef %21) #5
  ret void
}

declare %struct.SDL_Window* @SDL_CreateWindow(i8* noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

declare %struct.SDL_Renderer* @SDL_CreateRenderer(%struct.SDL_Window* noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

declare %struct.SDL_Texture* @SDL_CreateTexture(%struct.SDL_Renderer* noundef, i32 noundef, i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define dso_local void @simPrepareScreen() local_unnamed_addr #1 {
  %1 = alloca i32, align 4
  %2 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %2) #5
  %3 = load %struct.SDL_Texture*, %struct.SDL_Texture** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 2), align 8, !tbaa !12
  %4 = call i32 @SDL_LockTexture(%struct.SDL_Texture* noundef %3, %struct.SDL_Rect* noundef null, i8** noundef bitcast (i32** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 3) to i8**), i32* noundef nonnull %1) #5
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %2) #5
  ret void
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #3

declare i32 @SDL_LockTexture(%struct.SDL_Texture* noundef, %struct.SDL_Rect* noundef, i8** noundef, i32* noundef) local_unnamed_addr #2

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #3

; Function Attrs: mustprogress nofree norecurse nosync nounwind uwtable willreturn
define dso_local void @simSetPixel(i32 noundef %0, i32 noundef %1, i32 noundef %2) local_unnamed_addr #4 {
  %4 = load i32*, i32** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 3), align 8, !tbaa !14
  %5 = mul nsw i32 %1, 320
  %6 = add nsw i32 %5, %0
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds i32, i32* %4, i64 %7
  store i32 %2, i32* %8, align 4, !tbaa !15
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @simCheckQuit() local_unnamed_addr #1 {
  %1 = alloca %union.SDL_Event, align 8
  %2 = bitcast %union.SDL_Event* %1 to i8*
  call void @llvm.lifetime.start.p0i8(i64 56, i8* nonnull %2) #5
  %3 = call i32 @SDL_PollEvent(%union.SDL_Event* noundef nonnull %1) #5
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %23, label %5

5:                                                ; preds = %0
  %6 = getelementptr inbounds %union.SDL_Event, %union.SDL_Event* %1, i64 0, i32 0, i32 0
  %7 = bitcast %union.SDL_Event* %1 to %struct.SDL_WindowEvent*
  %8 = getelementptr inbounds %struct.SDL_WindowEvent, %struct.SDL_WindowEvent* %7, i64 0, i32 3
  br label %9

9:                                                ; preds = %5, %19
  %10 = phi i32 [ 0, %5 ], [ %20, %19 ]
  %11 = load i32, i32* %6, align 8, !tbaa !16
  %12 = icmp eq i32 %11, 256
  br i1 %12, label %18, label %13

13:                                               ; preds = %9
  %14 = icmp eq i32 %11, 512
  %15 = load i8, i8* %8, align 4
  %16 = icmp eq i8 %15, 14
  %17 = select i1 %14, i1 %16, i1 false
  br i1 %17, label %18, label %19

18:                                               ; preds = %13, %9
  br label %19

19:                                               ; preds = %18, %13
  %20 = phi i32 [ 1, %18 ], [ %10, %13 ]
  %21 = call i32 @SDL_PollEvent(%union.SDL_Event* noundef nonnull %1) #5
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %23, label %9, !llvm.loop !17

23:                                               ; preds = %19, %0
  %24 = phi i32 [ 0, %0 ], [ %20, %19 ]
  call void @llvm.lifetime.end.p0i8(i64 56, i8* nonnull %2) #5
  ret i32 %24
}

declare i32 @SDL_PollEvent(%union.SDL_Event* noundef) local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define dso_local void @simFlush() local_unnamed_addr #1 {
  %1 = tail call i32 @SDL_GetTicks() #5
  %2 = load i32, i32* getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 4), align 8, !tbaa !13
  %3 = sub i32 %1, %2
  %4 = icmp ugt i32 %3, 16
  br i1 %4, label %5, label %6

5:                                                ; preds = %0
  store i32 %1, i32* getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 4), align 8, !tbaa !13
  br label %8

6:                                                ; preds = %0
  %7 = sub nuw nsw i32 16, %3
  tail call void @SDL_Delay(i32 noundef %7) #5
  br label %8

8:                                                ; preds = %6, %5
  %9 = load %struct.SDL_Texture*, %struct.SDL_Texture** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 2), align 8, !tbaa !12
  tail call void @SDL_UnlockTexture(%struct.SDL_Texture* noundef %9) #5
  %10 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 1), align 8, !tbaa !11
  %11 = load %struct.SDL_Texture*, %struct.SDL_Texture** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 2), align 8, !tbaa !12
  %12 = tail call i32 @SDL_RenderCopy(%struct.SDL_Renderer* noundef %10, %struct.SDL_Texture* noundef %11, %struct.SDL_Rect* noundef null, %struct.SDL_Rect* noundef null) #5
  %13 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 1), align 8, !tbaa !11
  tail call void @SDL_RenderPresent(%struct.SDL_Renderer* noundef %13) #5
  ret void
}

declare i32 @SDL_GetTicks() local_unnamed_addr #2

declare void @SDL_Delay(i32 noundef) local_unnamed_addr #2

declare void @SDL_UnlockTexture(%struct.SDL_Texture* noundef) local_unnamed_addr #2

declare i32 @SDL_RenderCopy(%struct.SDL_Renderer* noundef, %struct.SDL_Texture* noundef, %struct.SDL_Rect* noundef, %struct.SDL_Rect* noundef) local_unnamed_addr #2

declare void @SDL_RenderPresent(%struct.SDL_Renderer* noundef) local_unnamed_addr #2

; Function Attrs: nounwind uwtable
define dso_local void @simClose() local_unnamed_addr #1 {
  %1 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 1), align 8, !tbaa !11
  tail call void @SDL_DestroyRenderer(%struct.SDL_Renderer* noundef %1) #5
  %2 = load %struct.SDL_Window*, %struct.SDL_Window** getelementptr inbounds (%struct.ScreenMeta, %struct.ScreenMeta* @meta, i64 0, i32 0), align 8, !tbaa !5
  tail call void @SDL_DestroyWindow(%struct.SDL_Window* noundef %2) #5
  tail call void @SDL_Quit() #5
  ret void
}

declare void @SDL_DestroyRenderer(%struct.SDL_Renderer* noundef) local_unnamed_addr #2

declare void @SDL_DestroyWindow(%struct.SDL_Window* noundef) local_unnamed_addr #2

declare void @SDL_Quit() local_unnamed_addr #2

attributes #0 = { mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #4 = { mustprogress nofree norecurse nosync nounwind uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!5 = !{!6, !7, i64 0}
!6 = !{!"ScreenMeta", !7, i64 0, !7, i64 8, !7, i64 16, !7, i64 24, !10, i64 32}
!7 = !{!"any pointer", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = !{!"int", !8, i64 0}
!11 = !{!6, !7, i64 8}
!12 = !{!6, !7, i64 16}
!13 = !{!6, !10, i64 32}
!14 = !{!6, !7, i64 24}
!15 = !{!10, !10, i64 0}
!16 = !{!8, !8, i64 0}
!17 = distinct !{!17, !18}
!18 = !{!"llvm.loop.mustprogress"}
