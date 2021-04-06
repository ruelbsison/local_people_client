import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProviderCard extends StatelessWidget {
  final String name;

  ProviderCard({
    Key key,
    @required this.name,
  }) : super(key: key);

  static final uuid = Uuid();
  final String imgTag = uuid.v4();
  final String titleTag = uuid.v4();
  final String authorTag = uuid.v4();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
        width: 119,
        height: 119,
        decoration: BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(3),
            topRight: Radius.circular(3),
            bottomLeft: Radius.circular(3),
            bottomRight: Radius.circular(3),
          ),
          color : Color.fromRGBO(196, 196, 196, 1),
          /* border : Border.all(
            color: Color.fromRGBO(0, 0, 0, 1),
            width: 2,
          ),*/
        ),
        child: Padding (
          padding: EdgeInsets.all(12.0),
          child: Text(name, textAlign: TextAlign.left, style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1),
            fontFamily: 'Inter',
            fontSize: 14,
            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.bold,
          ),),
        )
    );
  }
}