import 'package:flutter/material.dart';
import 'package:meow_world_app/constants/mw_constants.dart';

class MWButton extends StatefulWidget {
  // Properties
  final String nameButton;
  final VoidCallback onPressed;

  // Constructor
  MWButton({
    required this.nameButton,
    required this.onPressed
  });

  @override
  _MWButtonState createState() => _MWButtonState();
}

class _MWButtonState extends State<MWButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          elevation: MaterialStateProperty.all<double>(0),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0)
          ),
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
        child: Text(
          widget.nameButton.toUpperCase(),
          style: TextStyle(
            color: AppColors.neutralColor10,
            fontSize: 14,
            fontWeight: AppFontWeights.semiBoldOS
          ),
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}