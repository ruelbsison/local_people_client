import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';

class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: AppLocalizations.of(context).appTitle,
        appBar: AppBar(),
      ),
    );
  }
}