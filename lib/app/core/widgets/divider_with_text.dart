import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/color.dart';
import '../../config/theme/text_font_style.dart';


class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColor.borderColor(context))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: TextFontStyle.myAppText(
            context,
            text,
            style: TextStyleType.small,
            color: AppColor.richTextColor(context),
          ),
        ),
        Expanded(child: Divider(color: AppColor.borderColor(context))),
      ],
    );
  }
}