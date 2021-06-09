import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
//import 'package:provider/provider.dart';

import 'package:local_people_core/core.dart';
import 'package:local_people_core/login.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/messages.dart';
import 'ui/views/main_screen.dart';
import 'ui/router.dart';
//import 'injection_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import'dart:io' show Platform;

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
      theme: AppThemeConfig().kLocalPeopleTraderTheme, //AppThemeConfig().kLocalPeopleClientTheme, //themeData(Theme.of(context), AppThemeConfig.clientTheme),
      darkTheme: AppThemeConfig().kLocalPeopleClientTheme, //AppThemeConfig().kLocalPeopleTraderTheme, //themeData(Theme.of(context), AppThemeConfig.lightTheme),
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
              context.read<AuthenticationBloc>().add(AuthenticateUser());
              return LoginScreen();
            } else if (state is ReAuthenticate) {
              context.read<AuthenticationBloc>().add(ReAuthenticateUser());
              return LoginScreen();
            } else if (state is Authenticated) {
              return MainScreen();
            }
            return Container(
              child: Center(child: Text('Unhandle State $state')),
            );
          },
        ),
        defaultScale: true,
        maxWidth: 812,
        minWidth: 375,
        //maxWidth: 2436,
        //minWidth: 1125,
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

    DataConnectionChecker dataConnectionChecker = DataConnectionChecker();
    NetworkInfoImpl networkInfo = NetworkInfoImpl(dataConnectionChecker: dataConnectionChecker);
    //return TraderApp();
    //final UserRepository userRepository = UserRepositoryImpl();
    //Theme.of(context).platform == TargetPlatform.iOS
    // AuthLocalDataSource authLocalDataSource = AuthLocalDataSourceImpl(
    //   authorizationConfig: AuthorizationConfig.prodClientAuthorizationConfig(),
    // );
    AuthorizationConfig authorizationConfig;
    if (Platform.isIOS == true) {
      authorizationConfig = AuthorizationConfig.prodIOSClientAuthorizationConfig();
    }
    if (Platform.isAndroid == true) {
      authorizationConfig = AuthorizationConfig.prodClientAuthorizationConfig();
    }
    locatorInit(authorizationConfig);
    AuthLocalDataSource authLocalDataSource = sl<AuthLocalDataSource>();
    RestClientInterceptor restClientInterceptor = RestClientInterceptor(
      authLocalDataSource: authLocalDataSource,
    );


    AuthenticationDataSource authenticationDataSource = AuthenticationDataSourceImpl(
      authorizationConfig: authorizationConfig,
    );
    // AuthenticationDataSource authenticationDataSource = AuthenticationDataSourceByPass(
    //   authorizationConfig: AuthorizationConfig.prodClientAuthorizationConfig(),
    // );
    ClientRestApiClient clientRestApiClient = ClientRestApiClient(
        //RestAPIConfig.getDioOptions(),
        restClientInterceptor.dio,
        baseUrl: RestAPIConfig().baseURL,
    );
    TraderRestApiClient traderRestApiClient = TraderRestApiClient(
      //RestAPIConfig.getDioOptions(),
      restClientInterceptor.dio,
        baseUrl: RestAPIConfig().baseURL,
    );
    ClientRemoteDataSource clientRemoteDataSource = ClientRemoteDataSourceImpl(
      clientRestApiClient: clientRestApiClient,
    );
    TraderRemoteDataSource traderRemoteDataSource = TraderRemoteDataSourceImpl(
      traderRestApiClient: traderRestApiClient,
    );

    JobRestApiClient jobRestApiClient = JobRestApiClient(
      restClientInterceptor.dio,
      baseUrl: RestAPIConfig().baseURL,
    );
    JobRemoteDataSource jobRemoteDataSource = JobRemoteDataSourceImpl(
      jobRestApiClient: jobRestApiClient,
    );

    TagRestApiClient tagRestApiClient = TagRestApiClient(
      restClientInterceptor.dio,
      baseUrl: RestAPIConfig().baseURL,
    );
    TagRemoteDataSource tagRemoteDataSource = TagRemoteDataSourceImpl(
        tagRestApiClient: tagRestApiClient
    );

    LocationRestApiClient locationRestApiClient = LocationRestApiClient(
      restClientInterceptor.dio,
      baseUrl: RestAPIConfig().baseURL,
    );
    LocationRemoteDataSource locationRemoteDataSource = LocationRemoteDataSourceImpl(
        locationRestApiClient: locationRestApiClient,
    );

    MessageRestApiClient messageRestApiClient = MessageRestApiClient(
      restClientInterceptor.dio,
      baseUrl: RestAPIConfig().baseURL,
    );
    MessageRemoteDataSource messageRemoteDataSource = MessageRemoteDataSourceImpl(
      messageRestApiClient: messageRestApiClient,
    );

    final AuthenticationRepository authenticationRepository =
    AuthenticationRepositoryImpl(
      networkInfo: networkInfo,
      authenticationDataSource: authenticationDataSource,
    );

    final ProfileRepository profileRepository = ProfileRepositoryImpl(
        networkInfo: networkInfo,
        clientRemoteDataSource: clientRemoteDataSource,
        traderRemoteDataSource: traderRemoteDataSource
    );

    final JobRepository jobRepository = JobRepositoryImpl(
        networkInfo: networkInfo,
        jobRemoteDataSource: jobRemoteDataSource
    );

    final TagRepository tagRepository = TagRepositoryImpl(
        networkInfo: networkInfo,
        tagRemoteDataSource: tagRemoteDataSource,
    );

    final LocationRepository locationRepository = LocationRepositoryImpl(
      networkInfo: networkInfo,
      locationRemoteDataSource: locationRemoteDataSource,
    );

    final MessageRepository messageRepository = MessageRepositoryImpl(
      networkInfo: networkInfo,
      messageRemoteDataSource: messageRemoteDataSource,
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => authenticationRepository,
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => profileRepository,
        ),
        RepositoryProvider<JobRepository>(
          create: (context) => jobRepository,
        ),
        RepositoryProvider<TagRepository>(
          create: (context) => tagRepository,
        ),
        RepositoryProvider<LocationRepository>(
          create: (context) => locationRepository,
        ),
        RepositoryProvider<MessageRepository>(
          create: (context) => messageRepository,
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
                authLocalDataSource: authLocalDataSource,
                authenticationRepository: authenticationRepository)
              ..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
                profileRepository: profileRepository,
                appType: appType,
                authLocalDataSource: authLocalDataSource,
            ),
          ),
          BlocProvider(
            create: (context) => TagBloc(
              tagRepository: tagRepository,
            ),
          ),
          BlocProvider(
            create: (context) => LocationBloc(
              locationRepository: locationRepository,
            ),
          ),
          BlocProvider(
            create: (context) => JobBloc(
                jobRepository: jobRepository,
                tagRepository: tagRepository,
                locationRepository: locationRepository,
                appType: appType,
                authLocalDataSource: authLocalDataSource,
            ),
          ),
          BlocProvider(
            create: (context) => JobFormBloc(
                jobRepository: jobRepository,
                tagRepository: tagRepository,
              locationRepository: locationRepository
            ),
          ),
          BlocProvider(
            create: (context) => MessageBoxBloc(
              messageRepository: messageRepository,
              appType: appType,
              authLocalDataSource: authLocalDataSource,
            ),
          ),
          BlocProvider(
            create: (context) => MessageBloc(
              messageRepository: messageRepository,
              appType: appType,
              authLocalDataSource: authLocalDataSource,
            ),
          ),
        ],
        child: ClientApp(),
        // child: MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider(create: (_) => ClientProfile()),
        //   ],
        //   child: ClientApp(),
        // ),
      ),
    );
  }
}