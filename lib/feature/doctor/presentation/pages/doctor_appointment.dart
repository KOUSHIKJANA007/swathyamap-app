import 'package:flutter/material.dart';

import '../../../../common/widgets/scaffold/app_scaffold.dart';

class DoctorAppointment extends StatefulWidget {
  const DoctorAppointment({super.key});

  @override
  State<DoctorAppointment> createState() => _DoctorAppointmentState();
}

class _DoctorAppointmentState extends State<DoctorAppointment> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Center(child: Text('Appointments')));
  }
}
