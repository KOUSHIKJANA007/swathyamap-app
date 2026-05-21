import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:swasthyamap/core/config/routes/app_routes.dart';
import 'package:swasthyamap/core/config/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swasthyamap/injection_container.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  String envFile = const String.fromEnvironment(
    'ENV',
    defaultValue: '.env.dev',
  );
  await dotenv.load(fileName: envFile);
  await initDependency();
  final appRoutes = sl<AppRoutes>();
  runApp(MyApp(appRoutes: appRoutes));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRoutes});
  final AppRoutes appRoutes;
  Size _getDesignSize() {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final width = view.physicalSize.width / view.devicePixelRatio;
    return width > 600 ? const Size(600, 1024) : const Size(375, 812);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: _getDesignSize(),
      minTextAdapt: true,
      splitScreenMode: true,
       builder: (context,child){
         return MaterialApp.router(
           theme: AppTheme.lightTheme,
           debugShowCheckedModeBanner: false,
           routerConfig: appRoutes.router,
           // builder: (context, child) {
           //   return ErrorBoundary(
           //     child: child ?? Container(),
           //   );
           // },
         );
       },
    );
  }
}

