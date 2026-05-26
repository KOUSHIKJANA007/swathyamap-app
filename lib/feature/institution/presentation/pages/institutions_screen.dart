import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:swasthyamap/common/widgets/text/app_text_widget.dart';
import 'package:swasthyamap/core/config/routes/route_name.dart';
import 'package:swasthyamap/core/config/theme/app_color.dart';
import 'package:swasthyamap/core/extentions/auth_extention.dart';
import 'package:swasthyamap/feature/institution/presentation/widgets/institute_card.dart';

import '../../../../common/widgets/scaffold/app_scaffold.dart';
import '../bloc/institute_bloc.dart';

class InstitutionsScreen extends StatefulWidget {
  const InstitutionsScreen({super.key});

  @override
  State<InstitutionsScreen> createState() => _InstitutionsScreenState();
}

class _InstitutionsScreenState extends State<InstitutionsScreen> {

  @override
  void initState() {
    super.initState();
    context.read<InstituteBloc>().add(FindInstitutesForOwner(
        userId: context.currentUser!.id,
        pageNumber: 0,
        pageSize: 50,
      searchKey: ''
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: AppTextWidget(
          text: "Medical Institutes",
          color: AppColor.darkBgColor,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: () =>
                GoRouter.of(context).pushNamed(RouteName.addInstituteScreen),
            child: Row(
              children: [
                Icon(Icons.add, color: AppColor.primaryColor),
                AppTextWidget(
                  text: "Add Institute",
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: BlocBuilder<InstituteBloc, InstituteState>(
        builder: (context, state) {
          if (state is InstituteLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is InstituteLoaded) {
            return ListView.builder(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 60),
              itemCount: state.institutes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InstituteCard(institute: state.institutes[index]),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
