import 'package:flutter/material.dart';


const int _kModelStringWidth = 14;


class AnnouncementButton extends StatelessWidget {
  const AnnouncementButton({
    @required this.disabledColor,
    @required this.enabledColor,
    @required this.innerPadding,
    @required this.onPressedCallback,
    @required this.outerPadding,
    @required this.text,
    @required this.textStyle,
  });
  
  final Color
    disabledColor, enabledColor;
  final VoidCallback onPressedCallback;
  final String text;
  final TextStyle textStyle;
  final EdgeInsetsGeometry
    outerPadding, innerPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outerPadding ?? EdgeInsets.zero,
      child: OutlineButton(
        borderSide         : BorderSide(width: 1.5, color: enabledColor,),
        disabledBorderColor   : disabledColor.withOpacity(0.8),
        disabledTextColor     : disabledColor,
        highlightedBorderColor: enabledColor.withOpacity(0.8),
        padding               : innerPadding ?? EdgeInsets.zero,
        shape                 : BeveledRectangleBorder(
                                  borderRadius: const BorderRadius.only(
                                    topLeft    : Radius.circular(17.5),
                                    bottomRight: Radius.circular(17.5)
                                  ),
                                ),
        splashColor           : enabledColor.withOpacity(0.4),
        onPressed             : onPressedCallback,
        child                 : Text( text.padOnBothSides(_kModelStringWidth),
                                 style: textStyle.copyWith(color: enabledColor)
                                ),
      ),
    );
  }
}


//region Helper Extensions
extension PadOnBothSides on String {
  String padOnBothSides(int expectedWidth, [String padding = " "]) {
    if (this.length - expectedWidth <= 0) {
      return this;
    } else {
      int padWidth = (this.length - expectedWidth) ~/ 2;
      return this.padLeft(padWidth, padding)
                 .padRight(
                   (this.length.isOdd)?
                     padWidth + 1 : padWidth,
                   padding
                 );
    }
  }
}
//endregion