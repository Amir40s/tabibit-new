import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constant.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({super.key,required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: themeColor,
          shape: BoxShape.circle
      ),
      child: Icon(icon,color: bgColor,size: 30.sp,),
    );
  }
}
