import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/login.dart';
import 'ui/views/main_screen.dart';
import 'ui/router.dart';
//import 'injection_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    /*return ScreenUtilInit(
      designSize: Size(375, 812), //1125 x 2436 pixels
      //allowFontScaling: false,
      builder: () => MaterialApp(
        title: AppLocalizations().clientAppTitle,
        theme: AppThemeConfig().kLocalPeopleClientTheme, //themeData(Theme.of(context), AppThemeConfig.clientTheme),
        darkTheme: AppThemeConfig().kLocalPeopleTraderTheme, //themeData(Theme.of(context), AppThemeConfig.lightTheme),
        themeMode: ThemeMode.light,
        //fontFamily: 'Inter',
        localizationsDelegates: [
          LocalPeopleLocalizationsDelegate(),
          AppLocalizationsDelegate(),

        ],
        supportedLocales: [
          const Locale('en', ''), // English
        ],
        debugShowCheckedModeBanner: false,
        onGenerateRoute: ClientAppRouter.generateRoute,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return LoginScreen();
          } else if (state is Unauthenticated) {
            return MainScreen();
          } else if (state is Authenticated) {
            return MainScreen();
          }
          return Container(
            child: Center(child: Text('Unhandle State $state')),
          );
        },
      ),
      ),
    );*/
    return MaterialApp(
      title: AppLocalizations().clientAppTitle,
      theme: AppThemeConfig().kLocalPeopleClientTheme, //themeData(Theme.of(context), AppThemeConfig.clientTheme),
      darkTheme: AppThemeConfig().kLocalPeopleTraderTheme, //themeData(Theme.of(context), AppThemeConfig.lightTheme),
      themeMode: ThemeMode.light,
      //fontFamily: 'Inter',
      localizationsDelegates: [
        LocalPeopleLocalizationsDelegate(),
        AppLocalizationsDelegate(),
      ],
      supportedLocales: [
        const Locale('en', ''), // English
      ],
      debugShowCheckedModeBanner: false,
      onGenerateRoute: ClientAppRouter.generateRoute,
      /*home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return LoginScreen();
          } else if (state is Unauthenticated) {
            return MainScreen();
          } else if (state is Authenticated) {
            return MainScreen();
          }
          return Container(
            child: Center(child: Text('Unhandle State $state')),
          );
        },
      ),*/
     home: ResponsiveWrapper.builder(
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Uninitialized) {
              return LoginScreen();
            } else if (state is Unauthenticated) {
              //context.bloc<AuthenticationBloc>().add(AuthenticateUser());
              return MainScreen();
            } else if (state is Authenticated) {
              return MainScreen();
            }
            return Container(
              child: Center(child: Text('Unhandle State $state')),
            );
          },
        ),
        defaultScale: true,
        //maxWidth: 812,
        //minWidth: 375,
        maxWidth: 2436,
        minWidth: 1125,
        defaultName: MOBILE,
        breakpoints: [
          ResponsiveBreakpoint.autoScale(375, name: MOBILE),
          ResponsiveBreakpoint.autoScale(600, name: MOBILE),
          ResponsiveBreakpoint.resize(850, name: TABLET),
          ResponsiveBreakpoint.resize(1080, name: DESKTOP),
        ],
        //mediaQueryData: MediaQueryData(size: Size(375, 812), devicePixelRatio: 3),
      ),
    );
  }

  // Apply font to our app's theme
  ThemeData themeData(ThemeData baseTheme, ThemeData theme) {
    return baseTheme.copyWith(
      backgroundColor: theme.backgroundColor,
      primaryColor: theme.primaryColor,
      accentColor: theme.accentColor,
      scaffoldBackgroundColor: theme.scaffoldBackgroundColor,
      appBarTheme: theme.appBarTheme,
      textTheme: theme.textTheme,
      elevatedButtonTheme: theme.elevatedButtonTheme,
      textButtonTheme: theme.textButtonTheme,
      outlinedButtonTheme: theme.outlinedButtonTheme,
      inputDecorationTheme: theme.inputDecorationTheme,
    );
  }

  static void initSystemDefault() {
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle
          .loadString('packages/local_people_core/assets/fonts/Inter/OFL.txt');
      yield LicenseEntryWithLineBreaks(
          ['packages/local_people_core/assets/fonts'], license);
    });
  }

  static void setupLogging() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((rec) {
      print('${rec.level.name}: ${rec.time}: ${rec.message}');
    });
  }

  static Widget runWidget(AppType appType) {

    //return TraderApp();
    //final UserRepository userRepository = UserRepositoryImpl();
    AuthLocalDataSource authLocalDataSource = AuthLocalDataSourceImpl(
      authorizationConfig: AuthorizationConfig.devClientAuthorizationConfig(),
    );
    AuthenticationDataSource authenticationDataSource = AuthenticationDataSourceImpl(
      authorizationConfig: AuthorizationConfig.devClientAuthorizationConfig(),
    );
    JobRemoteDataSource jobRemoteDataSource = JobRemoteDataSourceImpl(RestAPIConfig().baseURL);
    TagRemoteDataSource tagRemoteDataSource = TagRemoteDataSourceImpl(RestAPIConfig().baseURL);
    LocationRemoteDataSource locationRemoteDataSource = LocationRemoteDataSourceImpl(RestAPIConfig().baseURL);

    final AuthenticationRepository authenticationRepository =
    AuthenticationRepositoryImpl(
      authLocalDataSource: authLocalDataSource,
      authenticationDataSource: authenticationDataSource,
    );

    JobRepository jobRepository = JobRepositoryImpl(
        authLocalDataSource: authLocalDataSource,
        jobRemoteDataSource: jobRemoteDataSource
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => authenticationRepository,
        ),
        RepositoryProvider<JobRepository>(
          create: (context) => jobRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          /*BlocProvider(
            create: (context) => LoginBloc(userRepository: userRepository),
          ),*/
          BlocProvider(
            create: (context) =>
            AuthenticationBloc(
                authenticationRepository: authenticationRepository)
              ..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) => JobBloc(
                jobRepository: jobRepository,
                appType: appType
            ),
          ),
        ],
        child: ClientApp(),
      ),
    );
  }
}

// class ClientView extends StatefulWidget {
//   @override
//   _AppViewState createState() => _AppViewState();
// }
//
// class _AppViewState extends State<ClientView> {
//   final _navigatorKey = GlobalKey<NavigatorState>();
//
//   NavigatorState get _navigator => _navigatorKey.currentState;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       //theme: theme,
//       title: AppLocalizations().clientAppTitle,
//       theme: themeData(AppThemeConfig.lightTheme),
//       darkTheme: themeData(AppThemeConfig.darkTheme),
//       localizationsDelegates: [
//         LocalPeopleLocalizationsDelegate(),
//         AppLocalizationsDelegate(),
//       ],
//       supportedLocales: [
//         const Locale('en', ''), // English
//       ],
//       debugShowCheckedModeBanner: false,
//       navigatorKey: _navigatorKey,
//       onGenerateRoute: ClientAppRouter.generateRoute,
//       home: ResponsiveWrapper.builder(
//         BlocBuilder<AuthenticationBloc, AuthenticationState>(
//           builder: (context, state) {
//             if (state is Uninitialized) {
//               return LoginScreen();
//             } else if (state is Unauthenticated) {
//               return MainScreen();
//             } else if (state is Authenticated) {
//               return MainScreen();
//             }
//             return Container(
//               child: Center(child: Text('Unhandle State $state')),
//             );
//           },
//         ),
//         maxWidth: 812,
//         minWidth: 375,
//         defaultName: MOBILE,
//         breakpoints: [
//           ResponsiveBreakpoint.autoScale(375, name: MOBILE),
//           ResponsiveBreakpoint.resize(600, name: MOBILE),
//           ResponsiveBreakpoint.resize(850, name: TABLET),
//           ResponsiveBreakpoint.resize(1080, name: DESKTOP),
//         ],
//         //mediaQueryData: MediaQueryData(size: Size(375, 812), devicePixelRatio: 3),
//       ),
//       /*home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//         builder: (context, state) {
//           if (state is Uninitialized) {
//             return LoginScreen();
//           } else if (state is Unauthenticated) {
//             return MainScreen();
//           } else if (state is Authenticated) {
//             return MainScreen();
//           }
//           return Container(
//             child: Center(child: Text('Unhandle State $state')),
//           );
//         },
//       ),*/
//       //initialRoute: ClientAppRouter.LOGIN,
//     );
//   }
//
//   // Apply font to our app's theme
//   ThemeData themeData(ThemeData theme) {
//     return theme.copyWith(
//       textTheme: GoogleFonts.interTextTheme(
//         theme.textTheme,
//       ),
//     );
//   }
// }
