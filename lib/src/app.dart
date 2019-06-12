import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../src/providers/auth_provider.dart';
import '../src/providers/tmdb_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/user_screen.dart';

class App extends StatelessWidget {

  Widget build(context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => AuthProvider.instance()),
        ChangeNotifierProvider(builder: (_) => TmdbProvider() ),
      ],
      child: MaterialApp(
        title: 'iTrak',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {

          switch(settings.name) {

            case 'home':
            
              return MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                }
              );

            case 'login':

              return MaterialPageRoute(
                builder: (context) => LoginScreen()
              );

            case 'register':

              return MaterialPageRoute(
                builder: (context) => RegisterScreen()
              );

            case 'user':

              final data = settings.arguments;

              return MaterialPageRoute(
                builder: (context) => UserScreen( data )
              );

            
            default:

              return MaterialPageRoute(
                builder: (context) => SplashScreen()
              );

          }

        },
        
      ),
    );

  }

}
