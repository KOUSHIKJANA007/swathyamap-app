import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/common/widgets/containers/app_container.dart';
import 'package:swasthyamap/common/widgets/images/cached_image_container.dart';
import 'package:swasthyamap/common/widgets/scaffold/app_scaffold.dart';
import 'package:swasthyamap/common/widgets/search_field/app_search_field.dart';
import 'package:swasthyamap/common/widgets/text/app_text_widget.dart';
import 'package:swasthyamap/core/config/assets/app_vector.dart';
import 'package:swasthyamap/core/config/routes/route_name.dart';
import 'package:swasthyamap/core/config/theme/app_color.dart';
import 'package:swasthyamap/core/extentions/auth_extention.dart';
import 'package:swasthyamap/feature/auth/domain/entities/user.dart';
import 'package:swasthyamap/feature/dashboard/presentation/widgets/popular_doctor_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = context.currentUser;
  }

  List<Map<String, dynamic>> quickList = [
    {
      'icon': AppVector.dentistIcon,
      'color': LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [const Color(0xFF2753F3), const Color(0xFF765AFC)],
      ),
    },
    {
      'icon': AppVector.cardiologistIcon,
      'color': LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [const Color(0xFF0EBE7E), const Color(0xFF07D9AD)],
      ),
    },
    {
      'icon': AppVector.ophthalmologistIcon,
      'color': LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [const Color(0xFFFE7F44), const Color(0xFFFFCF68)],
      ),
    },
    {
      'icon': AppVector.gynecologistIcon,
      'color': LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [const Color(0xFFFF484C), const Color(0xFFFF6C60)],
      ),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  margin: EdgeInsets.only(bottom: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF0EBE7E),
                        const Color(0xFF07D9AD),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextWidget(
                                    text:
                                        "Hi ${_user!.firstName} ${_user!.lastName}",
                                    color: AppColor.lightBgColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w300,
                                    maxLine: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                  AppTextWidget(
                                    text: "Find Your Doctor",
                                    color: AppColor.lightBgColor,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w600,
                                    maxLine: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            CachedImageContainer(
                              url: "url",
                              isImageExist: false,
                              height: 60,
                              width: 60,
                              borderRadius: 60,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: AppSearchField(
                      hintText: 'Search...',
                      prefixIcon: SvgPicture.asset(AppVector.searchIcon2),
                      onTap: () => GoRouter.of(
                        context,
                      ).pushNamed(RouteName.searchScreen),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppTextWidget(
                text: "Search Popular Doctor",
                color: AppColor.darkBgColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            AppContainer(
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                itemBuilder: (_, index) {
                  return AppContainer(
                    borderRadius: 10,
                    width: 90,
                    padding: EdgeInsets.all(25),
                    gradient: quickList[index]['color'],
                    child: Center(
                      child: SvgPicture.asset(quickList[index]['icon']),
                    ),
                  );
                },
                separatorBuilder: (_, _) {
                  return SizedBox(width: 10);
                },
                itemCount: quickList.length,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextWidget(
                      text: "Popular Doctor",
                    color: AppColor.darkBgColor,
                    fontWeight: FontWeight.w500,
                  ),
                  Row(
                    children: [
                      AppTextWidget(
                        text: "See All",
                        color: AppColor.subTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                      ),
                      Icon(Icons.arrow_forward_ios_rounded,color: AppColor.subTextColor,size: 13)
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            SingleChildScrollView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [1,2,3,4].map((data){
                  return Padding(
                    padding:const EdgeInsets.symmetric(horizontal: 10),
                    child: PopularDoctorCard(),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
