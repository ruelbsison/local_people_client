import 'package:flutter/material.dart';
//import 'package:uuid/uuid.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/core.dart';

class ProviderCard extends StatelessWidget {
  final TraderProfile profile;
  final ClientProfile clientProfile;

  ProviderCard({
    Key key,
    @required this.profile,
    @required this.clientProfile,
  }) : super(key: key);

  // static final uuid = Uuid();
  // final String imgTag = uuid.v4();
  // final String titleTag = uuid.v4();
  // final String authorTag = uuid.v4();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
        onTap: (){
          AppRouter.pushPage(context, DialogManager(
              child: ProfileScreen(
                profile: profile,
                otherProfile: clientProfile,
              ),
          ),
          );
    },
    child: Card(
        elevation: 1,
        //color: Color.fromRGBO(255, 255, 255, 1),
        color : Color.fromRGBO(196, 196, 196, 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Padding (
          padding: EdgeInsets.all(12.0),
          child: Text(profile.fullName, textAlign: TextAlign.left, style: theme.textTheme.subtitle1,),
        )
    ),
    );
  }
}