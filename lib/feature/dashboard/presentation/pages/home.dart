import 'package:flutter/material.dart';
import 'package:swasthyamap/common/widgets/scaffold/app_scaffold.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Center(child: Text('Home')));
  }
}
