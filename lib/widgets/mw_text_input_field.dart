import 'package:flutter/material.dart';
import 'package:meow_world_app/constants/mw_constants.dart';

class MWTextInputField extends StatefulWidget {
  // Properties
  final String titleInputField;
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  // Constructor
  MWTextInputField({
    required this.titleInputField,
    required this.controller,
    required this.hintText,
    this.validator
  });

  @override
  _MWTextInputFieldState createState() => _MWTextInputFieldState();
}

class _MWTextInputFieldState extends State<MWTextInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.titleInputField,
            style: TextStyle(
              color: AppColors.neutralColor50,
              fontSize: 12,
              fontWeight: AppFontWeights.mediumOS
            ),
          ),
          SizedBox(height: 4),
          TextFormField(
            controller: widget.controller,
            style: TextStyle(
              color: AppColors.neutralColor100,
              fontSize: 12,
              fontWeight: AppFontWeights.regularOS
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              fillColor: Colors.transparent,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: AppColors.neutralColor50,
                fontSize: 12,
                fontWeight: AppFontWeights.regularOS
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColors.primaryColorLightest,
                  width: 2
                )
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColors.mainColor,
                  width: 2
                )
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColors.mainColor,
                  width: 2,
                )
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColors.mainColor,
                  width: 2
                )
              )
            ),
            validator: widget.validator,
          )
        ],
      )
    );
  }
}