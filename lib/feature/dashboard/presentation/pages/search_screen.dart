import 'package:flutter/material.dart';

import '../../../../common/widgets/scaffold/app_scaffold.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Center(child: Text('Search Doctor')));
  }
}
