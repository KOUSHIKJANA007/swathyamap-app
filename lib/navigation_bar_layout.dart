import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/common/widgets/containers/app_container.dart';
import 'package:swasthyamap/common/widgets/scaffold/app_scaffold.dart';
import 'package:swasthyamap/core/config/assets/app_vector.dart';
import 'package:swasthyamap/core/config/routes/route_name.dart';
import 'package:swasthyamap/core/config/theme/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationBarLayout extends StatelessWidget {
  const NavigationBarLayout({super.key, required this.child});

  final Widget child;

  int _calculateIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    if (location.startsWith('/${RouteName.homeScreen}')) return 0;
    if (location.startsWith('/${RouteName.institutionScreen}')) return 1;
    if (location.startsWith('/${RouteName.searchScreen}')) return 2;
    if (location.startsWith('/${RouteName.appointmentScreen}')) return 3;
    if (location.startsWith('/${RouteName.appMenuScreen}')) return 4;

    return 0;
  }

  static List<Widget> iconList = [
    SvgPicture.asset(
      AppVector.homeIcon,
      height: 39,
      width: 39,
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        AppColor.lightBgColor,
        BlendMode.srcIn,
      ),
    ),
    SvgPicture.asset(
      AppVector.instituteIcon,
      height: 36,
      width: 36,
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        AppColor.lightBgColor,
        BlendMode.srcIn,
      ),
    ),
    FittedBox(
      fit: BoxFit.fill,
      child: SvgPicture.asset(
        AppVector.searchIcon,
        colorFilter: ColorFilter.mode(
          AppColor.lightBgColor,
          BlendMode.srcIn,
        ),
      ),
    ),
    FittedBox(
      fit: BoxFit.fill,
      child: SvgPicture.asset(
        AppVector.appointmentIcon,
        colorFilter: ColorFilter.mode(
          AppColor.lightBgColor,
          BlendMode.srcIn,
        ),
      ),
    ),
    FittedBox(
      fit: BoxFit.fill,
      child: SvgPicture.asset(
        AppVector.menuIcon,
        colorFilter: ColorFilter.mode(
          AppColor.lightBgColor,
          BlendMode.srcIn,
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateIndex(context);
    return AppScaffold(
      body: child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SafeArea(
        child: AppContainer(
          height: 56,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          color: AppColor.primaryColor,
          borderRadius: 24,
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor.withAlpha(46),
              offset: Offset(0, 20),
              blurRadius: 20,
            ),
          ],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              5,
              (index) => Column(
                children: [
                  if (currentIndex == index)
                    AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      height: 4,
                      width: 20,
                      margin: EdgeInsets.only(bottom: 2),
                      decoration: BoxDecoration(
                        color: AppColor.lightBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        switch (index) {
                          case 0:
                            context.go('/${RouteName.homeScreen}');
                            break;
                          case 1:
                            context.go('/${RouteName.institutionScreen}');
                            break;
                          case 2:
                            context.go('/${RouteName.searchScreen}');
                            break;
                          case 3:
                            context.go('/${RouteName.appointmentScreen}');
                            break;
                          case 4:
                            context.go('/${RouteName.appMenuScreen}');
                            break;
                        }
                      },
                      child: iconList[index],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
