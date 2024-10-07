import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constant.dart';

class SignContainer extends StatelessWidget {
  const SignContainer({super.key,required this.image,this.onTap});

  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            border: Border.all(
                color: greyColor
            )
        ),
        child: SvgPicture.asset(image,height: 30,),
      ),
    );
  }
}
