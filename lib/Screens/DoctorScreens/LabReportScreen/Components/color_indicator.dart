import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

class ColorIndicator extends StatelessWidget {
  const ColorIndicator({
    super.key,
    required this.text,
    required this.color,
  });
  
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle
          ),
        ),
        TextWidget(
            text: text, fontSize: 12.sp,
            fontWeight: FontWeight.w500, isTextCenter: false,
            textColor: textColor)
      ],
    );
  }
}
