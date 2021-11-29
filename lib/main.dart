import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './routes.dart';
import './layout/custom_theme.dart';

import './providers/auth_provider.dart';
import './services/providers_service.dart';

import './screens/login_screen.dart';
import './screens/splash_screen.dart';
import './screens/dashboard_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProvidersService.providerList(),
      child: Consumer<AuthProvider>(
        builder: (ctx, authData, child) {
          return MaterialApp(
            title: 'Hackathon',
            theme: CustomTheme.appTheme(),
            home: authData.isAuth
                ? const DashboardScreen()
                : FutureBuilder(
                    future: authData.tryAutoLogin(),
                    builder: (ct, authSnapshot) {
                      if (authSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const SplashScreen();
                      }
                      return const LoginScreen();
                    },
                  ),
            routes: Routes.appRoutes(),
          );
        },
      ),
    );
  }
}
