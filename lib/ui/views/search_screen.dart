import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        appBarPreferredSize: Size.fromHeight(60.0),
        title: Text(
          AppLocalizations.of(context).appTitle,
        ),
        subTitle: LocalPeopleLocalizations.of(context).menuTitleSearch,
        appBar: AppBar(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(186, 207, 216, 1),
                ),
              ),
            ),
          ),
        ),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: size.height,
        width: size.width,
      ),
    );
  }
}