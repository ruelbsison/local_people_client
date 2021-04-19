import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import '../widgets/provider_card.dart';
import '../widgets/package_card.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:local_people_core/jobs.dart';

class ClientHomeScreen extends StatefulWidget {
  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator DashboardWidget - FRAME
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBarWidget(
          appBarPreferredSize: Size.fromHeight(60.0),
          title: Text(
            AppLocalizations.of(context).appTitle,
          ),
          subTitle: DateFormatUtil.getFormattedDate(),
          appBar: AppBar(),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 14.0),
              child: ElevatedButton (
                child: Text(
                  LocalPeopleLocalizations.of(context).btnTitlePostJob,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onPressed: ()  {
                  AppRouter.pushPage(context, JobCreateScreen());
                },
              ),
              alignment: Alignment.center,
            )
          ],
        ),
      /* body: ResponsiveWrapper(
        child: _buildBody2(context),
        // child: _buildBodyList(),
        maxWidth: 1200,
        minWidth: 375, // 480,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(375, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: '4K'),
        ],
      ),*/
      body: _buildBody2(context),
    );
  }

  Widget _buildBody2(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack (
        children: <Widget>[
          SingleChildScrollView (
            // child: ResponsiveWrapper (
            //   // defaultScale: true,
            //   maxWidth: 1200,
            //   minWidth: 375,
            //   defaultName: MOBILE,
            //   breakpoints: [
            //     /* ResponsiveBreakpoint.resize(375, name: MOBILE),
            //     ResponsiveBreakpoint.autoScale(800, name: TABLET),
            //     ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            //     ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            //     ResponsiveBreakpoint.autoScale(2460, name: "4K"),*/
            //     ResponsiveBreakpoint.autoScale(375, name: MOBILE),
            //     ResponsiveBreakpoint.resize(600, name: MOBILE),
            //     ResponsiveBreakpoint.resize(850, name: TABLET),
            //     ResponsiveBreakpoint.resize(1080, name: DESKTOP),
            //   ],
              // padding: EdgeInsets.all(20),
              child: Column (
                children: <Widget> [
                  SizedBox(height: 20.0),
                  _buildSectionTitle('Find Local People'),
                  // SizedBox(height: 10.0),
                  //_buildFeaturedSection(),
                  Padding (
                    padding: EdgeInsets.all(18),
                    child: Container(
                      height: 119,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(3),
                          topRight: Radius.circular(3),
                          bottomLeft: Radius.circular(3),
                          bottomRight: Radius.circular(3),
                        ),
                        color : Color.fromRGBO(196, 196, 196, 1.0),
                      ),
                      child: Column (
                        // mainAxisSize: MainAxisSize.max,
                        children: <Widget> [
                          SizedBox(height: 20.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding (
                              padding: EdgeInsets.only(left: 16),
                              child: Text('Book your next job', textAlign: TextAlign.left, style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontFamily: 'Inter',
                                fontSize: 20,
                                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                          ),
                          SizedBox(height: 40.0),
                          Container (
                            alignment: Alignment.center,
                            child: Text('Search for services now', textAlign: TextAlign.center, style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Inter',
                              fontSize: 16,
                              letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                          // SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(height: 10.0),
                  _buildSectionTitle('Your Previous Providers'),
                  // SizedBox(height: 10.0),
                  _buildFeaturedSection(),
                  // SizedBox(height: 10.0),
                  _buildSectionTitle('Ready to book now'),
                  // SizedBox(height: 10.0),
                  _buildFeaturedSection(),
                  // SizedBox(height: 10.0),
                  _buildSectionTitle('Top Rated in your Area'),
                  // SizedBox(height: 10.0),
                  _buildFeaturedSection(),
                  // SizedBox(height: 10.0),
                  _buildSectionTitle('Latest Activity'),
                  // SizedBox(height: 10.0),
                  _buildFeaturedSection(),
                  // SizedBox(height: 10.0),
                  _buildSectionTitle('Most Recommended'),
                  _buildMostRecommendedSection(),
                ],
              ),
            //),
          ),
        ]
    );
  }

  _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontFamily: 'Inter',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  _buildFeaturedSection() {
    return Container(
      height: 119.0,
      // padding: EdgeInsets.only(left: 16, right: 16),
      // padding: EdgeInsets.symmetric(horizontal: 15.0),
      alignment: Alignment.centerLeft,
      child: ListView (
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        children: <Widget> [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ProviderCard(name: 'Provider Name 01'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ProviderCard(name: 'Provider Name 02'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ProviderCard(name: 'Provider Name 03'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ProviderCard(name: 'Provider Name 04'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ProviderCard(name: 'Provider Name 05'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ProviderCard(name: 'Provider Name 06'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ProviderCard(name: 'Provider Name 07'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ProviderCard(name: 'Provider Name 08'),
          ),
        ],
      ),
      /* decoration: BoxDecoration(
          color : Color.fromRGBO(50, 50, 50, 1),
        ),*/
    );
  }

  _buildMostRecommendedSection() {
    return Container(
      height: 120.0,
      // padding: EdgeInsets.only(left: 16, right: 16),
      // padding: EdgeInsets.symmetric(horizontal: 15.0),
      alignment: Alignment.centerLeft,
      child: ListView (
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        children: <Widget> [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ProviderCard(name: 'Supplier Name / Trade'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ProviderCard(name: 'Supplier Name / Trade'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ProviderCard(name: 'Supplier Name / Trade'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ProviderCard(name: 'Supplier Name / Trade'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ProviderCard(name: 'Supplier Name / Trade'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ProviderCard(name: 'Supplier Name / Trade'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ProviderCard(name: 'Supplier Name / Trade'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ProviderCard(name: 'Supplier Name / Trade'),
          ),
        ],
      ),
      /* decoration: BoxDecoration(
          color : Color.fromRGBO(50, 50, 50, 1),
        ),*/
    );
  }
}