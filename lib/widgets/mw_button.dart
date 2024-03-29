import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meow_world_app/constants/mw_constants.dart';

class MWButton extends StatelessWidget {
  // Properties
  final String? pathIcon;
  final String titleButton;
  final VoidCallback onPressed;

  // Constructor
  MWButton({
    required this.pathIcon,
    required this.titleButton,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          elevation: MaterialStateProperty.all<double>(0),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 12.0)),
          backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(
                color: Colors.transparent,
                width: 0
              )
            )
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (this.pathIcon != null)
              SvgPicture.asset(
                this.pathIcon!,
                width: 20,
                height: 20,
              ),
            if (this.pathIcon != null)
              SizedBox(width: 15),
            Text(
              this.titleButton,
              style: TextStyle(
                color: AppColors.neutralColor10,
                fontSize: 14,
                fontWeight: AppFontWeights.semiBoldOS
              ),
            ),
          ],
        ),
        onPressed: this.onPressed,
      ),
    );
  }
}