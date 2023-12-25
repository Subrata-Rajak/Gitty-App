import 'package:flutter/material.dart';

mixin CommonWidgets {
  SizedBox verticalSpace({required double h}) {
    return SizedBox(
      height: h,
      width: 0,
    );
  }

  SizedBox horizontalSpace({required double w}) {
    return SizedBox(
      height: 0,
      width: w,
    );
  }

  SizedBox emptyContainer() {
    return const SizedBox(
      height: 0,
      width: 0,
    );
  }
}
