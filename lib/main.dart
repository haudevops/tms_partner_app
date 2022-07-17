import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/routes/route_settings.dart';
import 'package:tms_partner_app/utils/common_utils/prefs_util.dart';
import 'package:tms_partner_app/utils/providers/language_provider.dart';
import 'package:tms_partner_app/utils/screen_util/screen_util_init.dart';

import 'utils/providers/theme_provider.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   // FirebaseDatabase.instance.setPersistenceEnabled(true);
//   // Firebase.initializeApp();
//   SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
//   runApp(const MyApp());
// }

Future<Widget> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  //FirebaseDatabase.instance.setPersistenceEnabled(true);
  await PrefsUtil.getInstance();
  await Firebase.initializeApp();
  return const MyApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 820),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider<LanguageProvider>(
              create: (context) => LanguageProvider()),
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
          )
        ],
        child: Builder(builder: (context) => MaterialApp(
          title: 'Supra Transportation Technology',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFF101010),
              appBarTheme: const AppBarTheme(
                  color: Color(0xFF1F1F1F),
                  iconTheme: IconThemeData(color: Colors.white)),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: Color(0xFF1F1F1F)),
              iconTheme: const IconThemeData(color: Colors.white)),
          locale: Provider.of<LanguageProvider>(context, listen: true)
              .currentLocale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          onGenerateRoute: CustomRouter.allRoutes,
          home: SplashPage(),
        )),
      ),
    );
  }
}
