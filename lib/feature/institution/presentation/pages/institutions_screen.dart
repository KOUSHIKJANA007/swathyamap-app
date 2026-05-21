import 'package:flutter/material.dart';

import '../../../../common/widgets/scaffold/app_scaffold.dart';

class InstitutionsScreen extends StatefulWidget {
  const InstitutionsScreen({super.key});

  @override
  State<InstitutionsScreen> createState() => _InstitutionsScreenState();
}

class _InstitutionsScreenState extends State<InstitutionsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Center(child: Text('Institution')));
  }
}
