import 'package:flutter/material.dart';

import '../../../../common/widgets/scaffold/app_scaffold.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Center(child: Text('Doctors')));
  }
}
