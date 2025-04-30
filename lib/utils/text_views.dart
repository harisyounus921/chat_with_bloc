import 'package:chat_app/chat_export.dart';
import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  const CommonText(this.text, this.fontFamily,this.fontSize,{
    super.key,
    this.color = Colors.white,

    this.textAlign = TextAlign.start,
    this.fontWeight= FontWeight.w400,
    this.lines, this.giveLinesAsText,
  } );
  final String text;
  final String? fontFamily;
  final Color? color;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final int? lines;
  final double? fontSize;
  final bool? giveLinesAsText;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: true,
      maxLines:giveLinesAsText == true?null: lines,
      overflow:giveLinesAsText == true?null: TextOverflow.ellipsis,
      style: TextStyle(
        inherit: false,
        fontSize: fontSize??24,
        fontWeight: fontWeight,
        fontFamily: fontFamily?? Assets.frauncesRegular,
        color: color??AppColors.blackColor,
      ),
    );
  }
}
