import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meow_world_app/constants/mw_constants.dart';

class SubAppBar extends StatelessWidget implements PreferredSizeWidget{
  // Properties
  final String titleScreen;
  final String icon = AppImagePaths.backIconPath;
  final VoidCallback? onBackBtnPressed;

  // Constructor
  const SubAppBar(this.titleScreen,{
    this.onBackBtnPressed
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      toolbarHeight: 100,
      title: Text(
          titleScreen,
          style: TextStyle(
            color: AppColors.neutralColor100,
            fontSize: AppFontSizes.fsTitleScreen,
            fontWeight: AppFontWeights.semiBoldOS,
          ),
      ),
      leading: IconButton(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Container(
          padding: EdgeInsets.all(7.5),
          decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(8)
          ),
          child: SvgPicture.asset(
            icon,
            width: 15,
            height: 15,
            colorFilter: ColorFilter.mode(AppColors.neutralColor10, BlendMode.srcIn),
          ),
        ),
        onPressed: onBackBtnPressed ?? () {
          Navigator.of(context).pop();
        },
      )
    );
  }
}