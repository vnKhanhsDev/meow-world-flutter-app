import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meow_world_app/widgets/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meow_world_app/constants/mw_constants.dart';
import 'package:meow_world_app/screens/favorite_screen.dart';
import 'package:meow_world_app/widgets/discover_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _activeTab = 0;
  final List barItems = [
    {
      "icon": "assets/icons/home-outlined.svg",
      "active_icon": "assets/icons/home-filled.svg",
      "page": Container(
        color: AppColors.neutralColor20,
        child: Center(
          child: Text("Home Page"),
        ),
      )
    },
    {
      "icon": "assets/icons/paw-outlined.svg",
      "active_icon": "assets/icons/paw-filled.svg",
      "page": Container(
        color: AppColors.neutralColor20,
        child: DiscoverPage(),
      )
    },
    {
      "icon": "assets/icons/heart-outlined.svg",
      "active_icon": "assets/icons/heart-filled.svg",
      "page": FavoriteScreen(),
    },
    {
      "icon": "assets/icons/setting-outlined.svg",
      "active_icon": "assets/icons/setting-filled.svg",
      "page": Container(
        color: AppColors.neutralColor20,
        child: Setting(),
      )
    }
  ];

  //====== begin: set animation ======
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 500), vsync: this
  );

  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  _buildAnimatedPage(page) {
    return FadeTransition(child: page, opacity: _animation);
  }

  void onPageChanged(int index) {
    _controller.reset();
    setState(() {
      _activeTab = index;
    });
    _controller.forward();
  }

  //====== end: set animation ======

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralColor10,
      body: _buildPage(),
      floatingActionButton: _buildBottomBar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Widget _buildPage() {
    return IndexedStack(
        index: _activeTab,
        children: List.generate(barItems.length,
            (index) => _buildAnimatedPage(barItems[index]["page"])));
  }

  Widget _buildBottomBar() {
    return Container(
      height: 70,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: AppColors.neutralColor10,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: AppColors.neutralColor100.withOpacity(0.2),
                blurRadius: 2,
                offset: Offset(0, 0))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
            barItems.length,
            (index) => BottomBarItem(
                  _activeTab == index
                      ? barItems[index]["active_icon"]
                      : barItems[index]["icon"],
                  isActive: _activeTab == index,
                  onTap: () => onPageChanged(index),
                )),
      ),
    );
  }
}

/* Bottom Navigation Bar Item Style */
class BottomBarItem extends StatelessWidget {
  // Properties
  final String icon;
  final bool isActive;
  final GestureTapCallback? onTap;

  // Constructors
  const BottomBarItem(this.icon, {this.onTap, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: SvgPicture.asset(
            icon,
            colorFilter: isActive
                ? ColorFilter.mode(AppColors.mainColor, BlendMode.srcIn)
                : ColorFilter.mode(AppColors.neutralColor70, BlendMode.srcIn),
            width: 30,
            height: 30,
          ),
        ),
      ),
    );
  }
}
