import 'package:flutter/material.dart';
import 'package:local_people_core/core.dart';
import '../widgets/provider_card.dart';
import '../widgets/package_card.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:local_people_core/jobs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/profile.dart';

class ClientHomeScreen extends StatefulWidget {
  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {

  void printScreenInformation() {
    print('Device width dp:${1.sw}dp');
    print('Device height dp:${1.sh}dp');
    print('Device pixel density:${ScreenUtil().pixelRatio}');
    print('Bottom safe zone distance dp:${ScreenUtil().bottomBarHeight}dp');
    print('Status bar height dp:${ScreenUtil().statusBarHeight}dp');
    print('The ratio of actual width to UI design:${ScreenUtil().scaleWidth}');
    print(
        'The ratio of actual height to UI design:${ScreenUtil().scaleHeight}');
    print('System font scaling:${ScreenUtil().textScaleFactor}');
    print('0.5 times the screen width:${0.5.sw}dp');
    print('0.5 times the screen height:${0.5.sh}dp');
    print('Screen orientation:${ScreenUtil().orientation}');
  }

  @override
  Widget build(BuildContext context) {
    //printScreenInformation();

    // Figma Flutter Generator DashboardWidget - FRAME
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(),
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
      //body: _buildBody2(context),
      body: BlocProvider.value(
        value: BlocProvider.of<ProfileBloc>(context),
        child: buildBody(),
      ),
    );
  }

  AppBarWidget buildAppBar() {
    return AppBarWidget(
      //appBarPreferredSize: Size.fromHeight(60.0),
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
    );
  }

  Widget buildBody() { //BuildContext context) {
    context.read<ProfileBloc>().add(ProfileGetEvent());
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileDoesNotExists) {
          context.read<ProfileBloc>().add(ProfileCreateEvent());
          return LoadingWidget();
        } else if (state is ProfileInitialState) {
          return LoadingWidget();
        } else if (state is ProfileCreating) {
          return LoadingWidget();
        } else if (state is ProfileLoading) {
          return LoadingWidget();
        } else if (state is ProfileCreated) {
          AppRouter.pushPage(context, ProfileScreen(profile: state.profile,));
          context.read<ProfileBloc>().add(ProfileGetTraderTopRatedEvent());
          return LoadingWidget();
        } else if (state is ProfileCreateFailed) {
          return ErrorWidget(state.toString());
        } else if (state is ProfileNotLoaded) {
          return ErrorWidget(state.toString());
        } else if (state is ProfileTraderTopRatedLoading) {
          return LoadingWidget();
        } else if (state is ProfileTraderTopRatedFailed) {
          return ErrorWidget(state.toString());
        } else if (state is ClientProfileLoaded) {
          context.read<ProfileBloc>().add(ProfileGetTraderTopRatedEvent());
          return LoadingWidget();
        } else if (state is ProfileTraderTopRatedCompleted) {
          return _buildBodyContent(state.topRatedTraders);
        }
        return ErrorWidget('Unhandle State $state');
      },
    );
  }

  // Widget buildBody() { //BuildContext context) {
  //   return BlocListener<ProfileBloc, ProfileState>(
  //     listener: (context, state) {
  //       if (state is ProfileDoesNotExists) {
  //         BlocProvider.of<ProfileBloc>(context).add(ProfileCreateEvent());
  //       } if (state is ProfileCreating) {
  //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //         ScaffoldMessenger.of(context)
  //           ..hideCurrentSnackBar()
  //           ..showSnackBar(
  //             const SnackBar(content: Text('Creating Profile...')),
  //           );
  //       } else if (state is ProfileLoading) {
  //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //         ScaffoldMessenger.of(context)
  //           ..hideCurrentSnackBar()
  //           ..showSnackBar(
  //             const SnackBar(content: Text('Loading Profile...')),
  //           );
  //       } else if (state is ProfileCreated) {
  //         //AppConfig.of(context).data.setUserId(state.profile.id);
  //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //         AppRouter.pushPage(context, ProfileScreen(profile: state.profile,));
  //         //BlocProvider.of<ProfileBloc>(context).add(ProfileGetTraderTopRatedEvent());
  //       } else if (state is ProfileCreateFailed) {
  //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //       } else if (state is ClientProfileLoaded) {
  //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //         //AppConfig.of(context).data.setUserId(state.profile.id);
  //         BlocProvider.of<ProfileBloc>(context).add(ProfileGetTraderTopRatedEvent());
  //       }
  //     },
  //     child: _buildBodyContent(context),
  //   );
  // }

  Widget _buildBodyContent(List<TraderProfile> topRatedTraders) {
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
                  _buildFeaturedSection(topRatedTraders),
                  // SizedBox(height: 10.0),
                  _buildSectionTitle('Ready to book now'),
                  // SizedBox(height: 10.0),
                  _buildFeaturedSection(topRatedTraders),
                  // SizedBox(height: 10.0),
                  _buildSectionTitle('Top Rated in your Area'),
                  // SizedBox(height: 10.0),
                  _buildTopRatedSection(topRatedTraders),
                  // SizedBox(height: 10.0),
                  _buildSectionTitle('Latest Activity'),
                  // SizedBox(height: 10.0),
                  _buildFeaturedSection(topRatedTraders),
                  // SizedBox(height: 10.0),
                  _buildSectionTitle('Most Recommended'),
                  _buildMostRecommendedSection(topRatedTraders),
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

  _buildFeaturedSection(List<TraderProfile> featuredTraders) {
    return Container(
      height: 119.0,
      // padding: EdgeInsets.only(left: 16, right: 16),
      // padding: EdgeInsets.symmetric(horizontal: 15.0),
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: featuredTraders.length,
        itemBuilder: (context, index) =>
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: ProviderCard(profile: featuredTraders[index]),
            ),
      ),
    );
  }

  _buildTopRatedSection(List<TraderProfile> topRatedTraders) {
    return Container(
      height: 119.0,
      // padding: EdgeInsets.only(left: 16, right: 16),
      // padding: EdgeInsets.symmetric(horizontal: 15.0),
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: topRatedTraders.length,
        itemBuilder: (context, index) =>
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: ProviderCard(profile: topRatedTraders[index]),
            ),
      ),
    );
  }

  _buildMostRecommendedSection(List<TraderProfile> mostRecommendedTraders) {
    return Container(
      height: 120.0,
      // padding: EdgeInsets.only(left: 16, right: 16),
      // padding: EdgeInsets.symmetric(horizontal: 15.0),
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: mostRecommendedTraders.length,
        itemBuilder: (context, index) =>
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: ProviderCard(profile: mostRecommendedTraders[index]),
            ),
      ),
    );
  }
}