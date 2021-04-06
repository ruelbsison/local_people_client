import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/login.dart';
import 'ui/views/main_screen.dart';
import 'ui/router.dart';
import 'injection_container.dart';

class ClientApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocProvider<AuthenticationBloc>(
      create: (_) => sl<AuthenticationBloc>(),
      child: ClientView(),
    );
    /*return RepositoryProvider.value(
      value: sl<AuthenticationRepository>(),
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: sl<AuthenticationRepository>(),
        ),
        child: ClientView(),
      ),
    );
    return MaterialApp(
      title: AppLocalizations().clientAppTitle,
      theme: themeData(AppThemeConfig.lightTheme),
      darkTheme: themeData(AppThemeConfig.darkTheme),
      localizationsDelegates: [
        LocalPeopleLocalizationsDelegate(),
        AppLocalizationsDelegate(),
      ],
      supportedLocales: [
        const Locale('en', ''), // English
      ],
      //home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
    return ClientView();*/
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
}

class ClientView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<ClientView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: theme,
      title: AppLocalizations().clientAppTitle,
      theme: themeData(AppThemeConfig.lightTheme),
      darkTheme: themeData(AppThemeConfig.darkTheme),
      localizationsDelegates: [
        LocalPeopleLocalizationsDelegate(),
        AppLocalizationsDelegate(),
      ],
      supportedLocales: [
        const Locale('en', ''), // English
      ],
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
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
      initialRoute: ClientAppRouter.LOGIN,
    );
  }

  // Apply font to our app's theme
  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.interTextTheme(
        theme.textTheme,
      ),
    );
  }
}
