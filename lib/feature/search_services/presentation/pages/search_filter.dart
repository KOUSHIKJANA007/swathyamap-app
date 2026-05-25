import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/common/widgets/checkboxes/app_checkbox.dart';
import 'package:swasthyamap/common/widgets/radio_button/app_radio_button.dart';
import 'package:swasthyamap/common/widgets/scaffold/app_scaffold.dart';
import 'package:swasthyamap/core/utils/search_helper/search_helper.dart';

import '../../../../common/widgets/containers/app_container.dart';
import '../../../../common/widgets/text/app_text_widget.dart';
import '../../../../core/config/theme/app_color.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({super.key});

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();

  static const String SPECIALIZATION = 'specialization';
  static const String SEARCH_RADIUS = 'search_radius';
  static const String DAY = 'day';

  String filterType = SPECIALIZATION;
  List<String> specializationData = [];
  double? searchRadius;
  String? day;

  void handleCollectSpecializationData(bool val,String specialization){
    if(val){
      specializationData.add(specialization);
    }else{
      specializationData.remove(specialization);
    }
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sliderDrawerKey.currentState?.openSlider();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        leading: AppContainer(
          color: AppColor.lightBgColor,
          margin: EdgeInsets.all(10),
          borderRadius: 10,
          onTap: () => GoRouter.of(context).pop(),
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColor.subTextColor,
            size: 20,
          ),
        ),
        title: AppTextWidget(
          text: "Filter",
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: AppTextWidget(
              text: "Clear Filter",
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.subTextColor,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SliderDrawer(
        appBar: Container(),
        key: _sliderDrawerKey,
        animationDuration: 0,
        sliderOpenSize: 150,
        isDraggable: false,
        slider: AppContainer(
          color: AppColor.lightGrayColor.withAlpha(55),
          child: Column(
            children: [
              AppContainer(
                onTap: () => setState(() {
                  filterType = SPECIALIZATION;
                }),
                color: filterType == SPECIALIZATION
                    ? AppColor.primaryColor
                    : Colors.transparent,
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                borderRadius: 10,
                child: AppTextWidget(
                  text: "Specialization",
                  fontWeight: FontWeight.w400,
                ),
              ),
              AppContainer(
                onTap: () => setState(() {
                  filterType = SEARCH_RADIUS;
                }),
                color: filterType == SEARCH_RADIUS
                    ? AppColor.primaryColor
                    : Colors.transparent,
                width: double.infinity,
                borderRadius: 10,
                padding: const EdgeInsets.all(8.0),
                child: AppTextWidget(
                  text: "Search Radius",
                  fontWeight: FontWeight.w400,
                ),
              ),
              AppContainer(
                onTap: () => setState(() {
                  filterType = DAY;
                }),
                color: filterType == DAY
                    ? AppColor.primaryColor
                    : Colors.transparent,
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                borderRadius: 10,
                child: AppTextWidget(text: "Day", fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: AppContainer(
              child: Column(
                children: [
                  if (filterType == SPECIALIZATION)
                    ..._buildSpecializationOptions()
                  else if (filterType == SEARCH_RADIUS)
                    ..._buildRadiusOptions()
                  else if (filterType == DAY)
                    ..._buildDaysOptions(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 80,
        child: FloatingActionButton(
            onPressed: (){
              GoRouter.of(context).pop({
                SPECIALIZATION:specializationData,
                SEARCH_RADIUS: searchRadius,
                DAY: day
              });
            },
          backgroundColor: AppColor.primaryColor,

          child: AppTextWidget(text: 'Apply',color: AppColor.lightBgColor,fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  List<AppCheckbox> _buildSpecializationOptions() {
    var list = SearchHelper.commonDoctorSpecializationsIndia;
    return List.generate(list.length, (index) {
      return AppCheckbox(
        value: specializationData.contains(list[index]),
          onChange: (val)=> handleCollectSpecializationData(val??false, list[index]),
          title: list[index]
      );
    });
  }

  List<Padding> _buildRadiusOptions() {
    var list = SearchHelper.searchRadiusKmList;
    return List.generate(list.length, (index) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: AppRadioButton<double>(
          label: list[index].toString(),
          value: list[index],
          isSelected: searchRadius == list[index],
          onTap: (_) {
            setState(() {
              searchRadius = list[index];
            });
          },
        ),
      );
    });
  }

  List<Padding> _buildDaysOptions() {
    var list = SearchHelper.weekDays;
    return List.generate(list.length, (index) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: AppRadioButton<String>(
          label: list[index].toString(),
          value: list[index],
          isSelected: day == list[index],
          onTap: (_) {
            setState(() {
              day = list[index];
            });
          },
        ),
      );
    });
  }
}
