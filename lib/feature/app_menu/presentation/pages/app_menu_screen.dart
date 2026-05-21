import 'package:flutter/material.dart';

import '../../../../common/widgets/scaffold/app_scaffold.dart';

class AppMenuScreen extends StatefulWidget {
  const AppMenuScreen({super.key});

  @override
  State<AppMenuScreen> createState() => _AppMenuScreenState();
}

class _AppMenuScreenState extends State<AppMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Center(child: Text('App Menu')));
  }
}
