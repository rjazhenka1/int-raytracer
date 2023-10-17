; ModuleID = 'src/raytrace.c'
source_filename = "src/raytrace.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind sspstrong willreturn memory(none) uwtable
define dso_local i32 @f_mul(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = sdiv i32 %1, 2048
  %4 = mul nsw i32 %3, %0
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind sspstrong willreturn memory(none) uwtable
define dso_local i32 @f_div(i32 noundef %0, i32 noundef %1) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %4, label %7

4:                                                ; preds = %2
  %5 = icmp sgt i32 %0, -1
  %6 = select i1 %5, i32 2147483647, i32 -2147483648
  br label %10

7:                                                ; preds = %2
  %8 = shl nsw i32 %0, 11
  %9 = sdiv i32 %8, %1
  br label %10

10:                                               ; preds = %7, %4
  %11 = phi i32 [ %6, %4 ], [ %9, %7 ]
  ret i32 %11
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind sspstrong willreturn memory(none) uwtable
define dso_local { i64, i32 } @v_add(i64 %0, i32 %1, i64 %2, i32 %3) local_unnamed_addr #0 {
  %5 = and i64 %0, -4294967296
  %6 = add i64 %2, %0
  %7 = add nsw i32 %3, %1
  %8 = add i64 %5, %2
  %9 = and i64 %8, -4294967296
  %10 = and i64 %6, 4294967295
  %11 = or i64 %9, %10
  %12 = insertvalue { i64, i32 } poison, i64 %11, 0
  %13 = insertvalue { i64, i32 } %12, i32 %7, 1
  ret { i64, i32 } %13
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind sspstrong willreturn memory(none) uwtable
define dso_local { i64, i32 } @v_sub(i64 %0, i32 %1, i64 %2, i32 %3) local_unnamed_addr #0 {
  %5 = and i64 %2, -4294967296
  %6 = sub i64 %0, %2
  %7 = sub nsw i32 %1, %3
  %8 = sub i64 %0, %5
  %9 = and i64 %8, -4294967296
  %10 = and i64 %6, 4294967295
  %11 = or i64 %9, %10
  %12 = insertvalue { i64, i32 } poison, i64 %11, 0
  %13 = insertvalue { i64, i32 } %12, i32 %7, 1
  ret { i64, i32 } %13
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind sspstrong willreturn memory(none) uwtable
define dso_local { i64, i32 } @v_mul(i64 %0, i32 %1, i64 %2, i32 %3) local_unnamed_addr #0 {
  %5 = trunc i64 %0 to i32
  %6 = lshr i64 %0, 32
  %7 = trunc i64 %6 to i32
  %8 = trunc i64 %2 to i32
  %9 = lshr i64 %2, 32
  %10 = trunc i64 %9 to i32
  %11 = sdiv i32 %8, 2048
  %12 = mul nsw i32 %11, %5
  %13 = sdiv i32 %10, 2048
  %14 = mul nsw i32 %13, %7
  %15 = sdiv i32 %3, 2048
  %16 = mul nsw i32 %15, %1
  %17 = zext i32 %14 to i64
  %18 = shl nuw i64 %17, 32
  %19 = zext i32 %12 to i64
  %20 = or i64 %18, %19
  %21 = insertvalue { i64, i32 } poison, i64 %20, 0
  %22 = insertvalue { i64, i32 } %21, i32 %16, 1
  ret { i64, i32 } %22
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind sspstrong willreturn memory(none) uwtable
define dso_local { i64, i32 } @v_div(i64 %0, i32 %1, i64 %2, i32 %3) local_unnamed_addr #0 {
  %5 = trunc i64 %0 to i32
  %6 = trunc i64 %2 to i32
  %7 = lshr i64 %2, 32
  %8 = trunc i64 %7 to i32
  %9 = icmp eq i32 %6, 0
  br i1 %9, label %10, label %13

10:                                               ; preds = %4
  %11 = icmp sgt i32 %5, -1
  %12 = select i1 %11, i32 2147483647, i32 -2147483648
  br label %16

13:                                               ; preds = %4
  %14 = shl nsw i32 %5, 11
  %15 = sdiv i32 %14, %6
  br label %16

16:                                               ; preds = %10, %13
  %17 = phi i32 [ %12, %10 ], [ %15, %13 ]
  %18 = icmp eq i32 %8, 0
  br i1 %18, label %19, label %22

19:                                               ; preds = %16
  %20 = icmp sgt i64 %0, -1
  %21 = select i1 %20, i32 2147483647, i32 -2147483648
  br label %27

22:                                               ; preds = %16
  %23 = lshr i64 %0, 21
  %24 = trunc i64 %23 to i32
  %25 = and i32 %24, -2048
  %26 = sdiv i32 %25, %8
  br label %27

27:                                               ; preds = %19, %22
  %28 = phi i32 [ %21, %19 ], [ %26, %22 ]
  %29 = icmp eq i32 %3, 0
  br i1 %29, label %30, label %33

30:                                               ; preds = %27
  %31 = icmp sgt i32 %1, -1
  %32 = select i1 %31, i32 2147483647, i32 -2147483648
  br label %36

33:                                               ; preds = %27
  %34 = shl nsw i32 %1, 11
  %35 = sdiv i32 %34, %3
  br label %36

36:                                               ; preds = %30, %33
  %37 = phi i32 [ %32, %30 ], [ %35, %33 ]
  %38 = zext i32 %28 to i64
  %39 = shl nuw i64 %38, 32
  %40 = zext i32 %17 to i64
  %41 = or i64 %39, %40
  %42 = insertvalue { i64, i32 } poison, i64 %41, 0
  %43 = insertvalue { i64, i32 } %42, i32 %37, 1
  ret { i64, i32 } %43
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind sspstrong willreturn memory(none) uwtable
define dso_local { i64, i32 } @v_neg(i64 %0, i32 %1) local_unnamed_addr #0 {
  %3 = and i64 %0, -4294967296
  %4 = sub i64 0, %0
  %5 = sub nsw i32 0, %1
  %6 = and i64 %4, 4294967295
  %7 = sub i64 %6, %3
  %8 = insertvalue { i64, i32 } poison, i64 %7, 0
  %9 = insertvalue { i64, i32 } %8, i32 %5, 1
  ret { i64, i32 } %9
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind sspstrong willreturn memory(none) uwtable
define dso_local { i64, i32 } @v_from_scalars(i32 noundef %0, i32 noundef %1, i32 noundef %2) local_unnamed_addr #0 {
  %4 = zext i32 %1 to i64
  %5 = shl nuw i64 %4, 32
  %6 = zext i32 %0 to i64
  %7 = or i64 %5, %6
  %8 = insertvalue { i64, i32 } poison, i64 %7, 0
  %9 = insertvalue { i64, i32 } %8, i32 %2, 1
  ret { i64, i32 } %9
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind sspstrong willreturn memory(none) uwtable
define dso_local { i64, i32 } @v_from_scalar(i32 noundef %0) local_unnamed_addr #0 {
  %2 = zext i32 %0 to i64
  %3 = mul nuw i64 %2, 4294967297
  %4 = insertvalue { i64, i32 } poison, i64 %3, 0
  %5 = insertvalue { i64, i32 } %4, i32 %0, 1
  ret { i64, i32 } %5
}

; Function Attrs: nounwind sspstrong uwtable
define dso_local i32 @get_color(i64 %0, i32 %1, i64 %2, i32 %3) local_unnamed_addr #1 {
  %5 = lshr i64 %2, 32
  %6 = trunc i64 %5 to i32
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %10

8:                                                ; preds = %4
  %9 = icmp sgt i64 %0, -1
  br i1 %9, label %18, label %16

10:                                               ; preds = %4
  %11 = lshr i64 %0, 21
  %12 = trunc i64 %11 to i32
  %13 = and i32 %12, -2048
  %14 = sdiv i32 %13, %6
  %15 = icmp slt i32 %14, -2048
  br i1 %15, label %16, label %18

16:                                               ; preds = %8, %10
  %17 = tail call i32 @ARGB(i8 noundef zeroext 0, i8 noundef zeroext 127, i8 noundef zeroext 127) #4
  br label %40

18:                                               ; preds = %8, %10
  %19 = phi i32 [ %14, %10 ], [ 2147483647, %8 ]
  %20 = trunc i64 %2 to i32
  %21 = sdiv i32 %19, -2048
  %22 = mul nsw i32 %21, %20
  %23 = mul nsw i32 %21, %3
  %24 = add nsw i32 %23, %1
  %25 = trunc i64 %0 to i32
  %26 = add i32 %22, %25
  %27 = sdiv i32 %26, 4
  %28 = tail call i32 @llvm.abs.i32(i32 %27, i1 true)
  %29 = and i32 %28, 16383
  %30 = sdiv i32 %24, 4
  %31 = tail call i32 @llvm.abs.i32(i32 %30, i1 true)
  %32 = and i32 %31, 16383
  %33 = icmp ugt i32 %29, 8192
  %34 = icmp ugt i32 %32, 8192
  %35 = xor i1 %33, %34
  br i1 %35, label %36, label %38

36:                                               ; preds = %18
  %37 = tail call i32 @ARGB(i8 noundef zeroext -1, i8 noundef zeroext -1, i8 noundef zeroext -1) #4
  br label %40

38:                                               ; preds = %18
  %39 = tail call i32 @ARGB(i8 noundef zeroext 0, i8 noundef zeroext 0, i8 noundef zeroext 0) #4
  br label %40

40:                                               ; preds = %36, %38, %16
  %41 = phi i32 [ %17, %16 ], [ %37, %36 ], [ %39, %38 ]
  ret i32 %41
}

declare i32 @ARGB(i8 noundef zeroext, i8 noundef zeroext, i8 noundef zeroext) local_unnamed_addr #2

; Function Attrs: nounwind sspstrong uwtable
define dso_local void @app() local_unnamed_addr #1 {
  %1 = tail call i32 (...) @simCheckQuit() #4
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %53

3:                                                ; preds = %0, %12
  %4 = phi i32 [ %13, %12 ], [ 0, %0 ]
  tail call void (...) @simPrepareScreen() #4
  %5 = shl i32 %4, 11
  %6 = lshr exact i32 %5, 3
  %7 = or i32 %6, -16777216
  br label %8

8:                                                ; preds = %3, %16
  %9 = phi i32 [ 0, %3 ], [ %17, %16 ]
  %10 = shl nuw nsw i32 %9, 1
  %11 = add nsw i32 %10, -1024
  br label %19

12:                                               ; preds = %16
  %13 = add i32 %4, 1
  tail call void (...) @simFlush() #4
  %14 = tail call i32 (...) @simCheckQuit() #4
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %3, label %53, !llvm.loop !5

16:                                               ; preds = %48
  %17 = add nuw nsw i32 %9, 1
  %18 = icmp eq i32 %17, 1024
  br i1 %18, label %12, label %8, !llvm.loop !7

19:                                               ; preds = %8, %48
  %20 = phi i32 [ 0, %8 ], [ %51, %48 ]
  %21 = add nsw i32 %20, -128
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %28, label %23

23:                                               ; preds = %19
  %24 = sdiv i32 83886080, %21
  %25 = icmp slt i32 %24, -2048
  br i1 %25, label %26, label %28

26:                                               ; preds = %23
  %27 = tail call i32 @ARGB(i8 noundef zeroext 0, i8 noundef zeroext 127, i8 noundef zeroext 127) #4
  br label %48

28:                                               ; preds = %19, %23
  %29 = phi i32 [ %24, %23 ], [ 2147483647, %19 ]
  %30 = sdiv i32 %29, -2048
  %31 = mul nsw i32 %30, %11
  %32 = sub i32 %4, %30
  %33 = shl i32 %32, 11
  %34 = add i32 %31, %5
  %35 = sdiv i32 %34, 4
  %36 = tail call i32 @llvm.abs.i32(i32 %35, i1 true)
  %37 = and i32 %36, 16383
  %38 = ashr exact i32 %33, 2
  %39 = tail call i32 @llvm.abs.i32(i32 %38, i1 true)
  %40 = and i32 %39, 15872
  %41 = icmp ugt i32 %37, 8192
  %42 = icmp ugt i32 %40, 8192
  %43 = xor i1 %41, %42
  br i1 %43, label %44, label %46

44:                                               ; preds = %28
  %45 = tail call i32 @ARGB(i8 noundef zeroext -1, i8 noundef zeroext -1, i8 noundef zeroext -1) #4
  br label %48

46:                                               ; preds = %28
  %47 = tail call i32 @ARGB(i8 noundef zeroext 0, i8 noundef zeroext 0, i8 noundef zeroext 0) #4
  br label %48

48:                                               ; preds = %26, %44, %46
  %49 = phi i32 [ %27, %26 ], [ %45, %44 ], [ %47, %46 ]
  %50 = sub i32 %49, %7
  tail call void @simSetPixel(i32 noundef %9, i32 noundef %20, i32 noundef %50) #4
  %51 = add nuw nsw i32 %20, 1
  %52 = icmp eq i32 %51, 768
  br i1 %52, label %16, label %19, !llvm.loop !8

53:                                               ; preds = %12, %0
  ret void
}

declare i32 @simCheckQuit(...) local_unnamed_addr #2

declare void @simPrepareScreen(...) local_unnamed_addr #2

declare void @simSetPixel(i32 noundef, i32 noundef, i32 noundef) local_unnamed_addr #2

declare void @simFlush(...) local_unnamed_addr #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.abs.i32(i32, i1 immarg) #3

attributes #0 = { mustprogress nofree norecurse nosync nounwind sspstrong willreturn memory(none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind sspstrong uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 16.0.6"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !6}
!8 = distinct !{!8, !6}
