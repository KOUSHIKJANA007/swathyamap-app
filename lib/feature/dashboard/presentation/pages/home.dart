import 'package:flutter/material.dart';
import 'package:swasthyamap/common/widgets/scaffold/app_scaffold.dart';
import 'package:swasthyamap/core/extentions/auth_extention.dart';
import 'package:swasthyamap/feature/auth/domain/entities/user.dart';

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

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Center(child: Text(_user.toString())));
  }
}
