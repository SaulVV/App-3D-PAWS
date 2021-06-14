import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:paws/src/bloc/provider.dart';
import 'package:paws/src/pages/default.dart';
import 'package:paws/src/routes/routes.dart';
//import 'package:provider/provider.dart'; //Lo vamos a usar para la autenticacion de tokens

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: '3D-PAWS App',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          // AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', 'US'), // English, no country code
          const Locale('es', 'MX'), // Arabic, no country code
          // ... other locales the app supports
        ],
        initialRoute: 'login',
        routes: getApplicationRoutes(),
        onGenerateRoute: (RouteSettings settings) {
          print('Ruta llamada: ${settings.name}');
          return MaterialPageRoute(
              builder: (BuildContext context) => DefaultPage());
        },
      ),
    );
  }
}
