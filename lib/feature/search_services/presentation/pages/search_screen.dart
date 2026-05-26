import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/common/widgets/search_field/app_search_field.dart';
import 'package:swasthyamap/core/config/assets/app_vector.dart';
import 'package:swasthyamap/core/config/routes/route_name.dart';
import 'package:swasthyamap/core/utils/data_parse_helper/data_parse_helper.dart';
import 'package:swasthyamap/feature/search_services/presentation/bloc/search_bloc.dart';
import 'package:swasthyamap/feature/search_services/presentation/widgets/doctor_card.dart';

import '../../../../common/widgets/containers/app_container.dart';
import '../../../../common/widgets/scaffold/app_scaffold.dart';
import '../../../../common/widgets/text/app_text_widget.dart';
import '../../../../core/config/theme/app_color.dart';
import '../../../../core/utils/debounce/debounce.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.specialization});
  final String? specialization;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _debounce = Debounce(milliseconds: 400);
  final ScrollController _scrollController = ScrollController();
  Map<String,dynamic> filterData = {};
  String searchKey = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    List<String> specialization = [];
    if(widget.specialization!=null){
      filterData = {'specialization':[widget.specialization]};
      specialization = [widget.specialization!];
    }
    context.read<SearchBloc>().add(
      SearchDoctor(
        latitude: 22.33,
        longitude: 87.32,
        search: '',
        specialization: specialization,
        dayOfWeek: '',
        lastDistance: 0,
        limit: 30,
        institutionType: [],
        availableNowOnly: false,
        radiusKm: 10,
      ),
    );
  }


  void _scrollListener() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.offset) {
      if (!mounted) return;
      var state = context.read<SearchBloc>().state;
      if (state is SearchLoaded) {
        if (!state.hasMoreDoctor) return;
        context.read<SearchBloc>().add(
          SearchDoctor(
            latitude: 22.33,
            longitude: 87.32,
            search: searchKey,
            specialization: filterData['specialization']??[],
            dayOfWeek: filterData['day']??'',
            lastDistance: state.doctors.last.distanceKm,
            lastDoctorId: state.doctors.last.doctorId,
            limit: 30,
            institutionType: [],
            availableNowOnly: false,
            radiusKm: filterData['search_radius']??10.0,
          ),
        );
      }
    }
  }



@override
void dispose() {
  _scrollController.removeListener(_scrollListener);
  _scrollController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: AppTextWidget(
          text: "Find Doctors",
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
        ),
        actions: [
          GestureDetector(
            onTap: () =>
                GoRouter.of(context)
                    .pushNamed(RouteName.searchFilterScreen)
                    .then((data) {
                  if (data != null) {
                    final Map<String, dynamic> mapData =
                    data as Map<String, dynamic>;
                    filterData = mapData;
                    context.read<SearchBloc>().add(SearchDoctor(
                      latitude: 22.33,
                      longitude: 87.32,
                      search: '',
                      specialization: filterData['specialization']??[],
                      dayOfWeek: filterData['day']??'',
                      lastDistance: 0,
                      limit: 30,
                      institutionType: [],
                      availableNowOnly: false,
                      radiusKm: filterData['search_radius']??10.0,
                    ));
                  }
                }),
            child: Icon(Icons.filter_list, color: AppColor.subTextColor),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            AppSearchField(
              hintText: 'Search..',
              prefixIcon: SvgPicture.asset(AppVector.searchIcon2),
              value: searchKey,
              onChange: (val){
                searchKey = val;
                _debounce.run((){
                  context.read<SearchBloc>().add(
                    SearchDoctor(
                      latitude: 22.33,
                      longitude: 87.32,
                      search: val,
                      specialization: filterData['specialization']??[],
                      dayOfWeek: filterData['day']??'',
                      lastDistance: 0,
                      limit: 30,
                      institutionType: [],
                      availableNowOnly: false,
                      radiusKm: filterData['search_radius']??10.0,
                    ),
                  );
                });
              },
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...(filterData['specialization']??[]).map((data)=>
                        AppContainer(
                          color: AppColor.primaryColor.withAlpha(45),
                          padding: EdgeInsets.only(left: 10,top: 2,bottom: 2,right: 2),
                          margin: EdgeInsets.only(right: 7),
                          borderRadius: 7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppTextWidget(text: DataParseHelper.normalizeAndCapitalize(data),fontWeight: FontWeight.w400,color: AppColor.primaryColor,fontSize: 14.sp,),
                              const SizedBox(width: 7),
                              GestureDetector(
                                  onTap: (){
                                   List<String> list = filterData['specialization']??[];
                                   list.remove(data);
                                   filterData['specialization'] = list;
                                   context.read<SearchBloc>().add(
                                     SearchDoctor(
                                       latitude: 22.33,
                                       longitude: 87.32,
                                       search: searchKey,
                                       specialization: filterData['specialization']??[],
                                       dayOfWeek: filterData['day']??'',
                                       lastDistance: 0,
                                       limit: 30,
                                       institutionType: [],
                                       availableNowOnly: false,
                                       radiusKm: filterData['search_radius']??10.0,
                                     ),
                                   );
                                   setState(() {

                                   });
                                  },
                                  child: Icon(Icons.close,color: AppColor.primaryColor,size: 20))
                            ],
                          ),
                        )
                    ),
                    if(filterData['day']!=null)
                    AppContainer(
                      color: AppColor.primaryColor.withAlpha(45),
                      padding: EdgeInsets.only(left: 10,top: 2,bottom: 2,right: 2),
                      margin: EdgeInsets.only(right: 7),
                      borderRadius: 7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppTextWidget(text: filterData['day'],fontWeight: FontWeight.w400,color: AppColor.primaryColor,fontSize: 14.sp,),
                          const SizedBox(width: 7),
                          GestureDetector(
                              onTap: (){
                                filterData['day']=null;
                                context.read<SearchBloc>().add(
                                  SearchDoctor(
                                    latitude: 22.33,
                                    longitude: 87.32,
                                    search: searchKey,
                                    specialization: filterData['specialization']??[],
                                    dayOfWeek: filterData['day']??'',
                                    lastDistance: 0,
                                    limit: 30,
                                    institutionType: [],
                                    availableNowOnly: false,
                                    radiusKm: filterData['search_radius']??10.0,
                                  ),
                                );
                                setState(() {

                                });
                              },
                              child: Icon(Icons.close,color: AppColor.primaryColor,size: 20))
                        ],
                      ),
                    ),
                    if(filterData['search_radius']!=null)
                      AppContainer(
                        color: AppColor.primaryColor.withAlpha(45),
                        padding: EdgeInsets.only(left: 10,top: 2,bottom: 2,right: 2),
                        margin: EdgeInsets.only(right: 7),
                        borderRadius: 7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppTextWidget(text: "Search Radius: ${filterData['search_radius']} km",fontWeight: FontWeight.w400,color: AppColor.primaryColor,fontSize: 14.sp,),
                            const SizedBox(width: 7),
                            GestureDetector(
                                onTap: (){
                                  filterData['search_radius']=null;
                                  context.read<SearchBloc>().add(
                                    SearchDoctor(
                                      latitude: 22.33,
                                      longitude: 87.32,
                                      search: searchKey,
                                      specialization: filterData['specialization']??[],
                                      dayOfWeek: filterData['day']??'',
                                      lastDistance: 0,
                                      limit: 30,
                                      institutionType: [],
                                      availableNowOnly: false,
                                      radiusKm: filterData['search_radius']??10.0,
                                    ),
                                  );
                                  setState(() {

                                  });
                                },
                                child: Icon(Icons.close,color: AppColor.primaryColor,size: 20))
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if(state is SearchLoaded){
                  return Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.only(bottom: 60.h),
                      itemCount: state.doctors.length,
                      itemBuilder: (context, index) {
                        return DoctorCard(doctor: state.doctors[index]);
                      },
                    ),
                  );
                }else if(state is SearchLoading){
                  return CircularProgressIndicator();
                }else{
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
