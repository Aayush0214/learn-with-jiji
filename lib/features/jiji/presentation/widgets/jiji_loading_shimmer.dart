import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/shimmer_skeleton.dart';

class JijiLoadingShimmer extends StatelessWidget {
  const JijiLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          spacing: 10.h,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: ShimmerSkeleton(
                height: 20.h,
                width: 100.w,
                borderRadius: 5.r,
              ),
            ),
            Expanded(
              flex: 5,
              child: ShimmerSkeleton(
                height: 150.h,
                width: double.infinity,
                borderRadius: 5.r,
              ),
            ),
            Expanded(
              flex: 2,
              child: ShimmerSkeleton(
                height: 50.h,
                width: double.maxFinite,
                borderRadius: 5.r,
              ),
            ),
            Expanded(
              flex: 2,
              child: ShimmerSkeleton(
                height: 50.h,
                width: double.maxFinite,
                borderRadius: 5.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}