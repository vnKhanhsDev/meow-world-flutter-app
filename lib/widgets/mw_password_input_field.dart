import 'package:flutter/material.dart';
import 'package:meow_world_app/constants/mw_constants.dart';

class MWPasswordInputField extends StatefulWidget {
  // Properties
  final TextEditingController controller;

  // Constructor
  MWPasswordInputField({
    required this.controller,
  });

  @override
  _MWPasswordInputFieldState createState() => _MWPasswordInputFieldState();
}

class _MWPasswordInputFieldState extends State<MWPasswordInputField> {
  bool _obscurePassword = true;

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Mật khẩu không được để trống";
    } else if (value.length < 8) {
      return "Mật khẩu phải chứa ít nhất 8 ký tự";
    } else {
      return null;
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mật khẩu',
            style: TextStyle(
              color: AppColors.neutralColor50,
              fontSize: 12,
              fontWeight: AppFontWeights.mediumOS,
            ),
          ),
          SizedBox(height: 4),
          TextFormField(
            controller: widget.controller,
            obscureText: _obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
              color: AppColors.neutralColor100,
              fontSize: 12,
              fontWeight: AppFontWeights.regularOS,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              fillColor: Colors.transparent,
              hintText: 'Nhập mật khẩu',
              hintStyle: TextStyle(
                color: AppColors.neutralColor50,
                fontSize: 12,
                fontWeight: AppFontWeights.regularOS,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColors.primaryColorLightest,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColors.mainColor,
                  width: 2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColors.mainColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: AppColors.mainColor,
                  width: 2,
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 10.0), // Margin cho icon
                child: GestureDetector(
                  onTap: _togglePasswordVisibility,
                  child: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: _obscurePassword ? AppColors.neutralColor50 : AppColors.neutralColor100,
                    size: 20, // Kích thước của icon
                  ),
                ),
              ),
            ),
            validator: passwordValidator,
          ),
        ],
      ),
    );
  }
}
