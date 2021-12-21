import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../providers/auth_provider.dart';
import '../providers/reset_pwd_forgotten_provider.dart';
import '../providers/account_provider.dart';
import '../providers/phase_provider.dart';
import '../providers/recap_provider.dart';
import '../providers/project_provider.dart';
import '../providers/team_provider.dart';
import '../providers/help_provider.dart';
import '../providers/invitation_provider.dart';

class ProvidersService {
  static List<SingleChildWidget> providerList() {
    return [
      ChangeNotifierProvider(create: (ctx) => AuthProvider()),
      ChangeNotifierProvider(create: (ctx) => ResetPwdForgottenProvider()),
      ChangeNotifierProxyProvider<AuthProvider, AccountProvider>(
        create: (ctx) => AccountProvider(),
        update: (ct, auth, prevState) => AccountProvider(
          authToken: auth.token,
        ),
      ),
      ChangeNotifierProxyProvider<AuthProvider, PhaseProvider>(
        create: (ctx) => PhaseProvider(),
        update: (ct, auth, prevState) => PhaseProvider(authToken: auth.token),
      ),
      ChangeNotifierProxyProvider<AuthProvider, RecapProvider>(
        create: (ctx) => RecapProvider(),
        update: (ct, auth, prevState) => RecapProvider(authToken: auth.token),
      ),
      ChangeNotifierProxyProvider<AuthProvider, ProjectProvider>(
        create: (ctx) => ProjectProvider(),
        update: (ct, auth, prevState) => ProjectProvider(authToken: auth.token),
      ),
      ChangeNotifierProxyProvider<AuthProvider, TeamProvider>(
        create: (ctx) => TeamProvider(),
        update: (ct, auth, prevState) => TeamProvider(authToken: auth.token),
      ),
      ChangeNotifierProxyProvider<AuthProvider, HelpProvider>(
        create: (ctx) => HelpProvider(),
        update: (ct, auth, prevState) => HelpProvider(authToken: auth.token),
      ),
      ChangeNotifierProxyProvider<AuthProvider, InvitationProvider>(
        create: (ctx) => InvitationProvider(),
        update: (ct, auth, prevState) => InvitationProvider(authToken: auth.token),
      ),
    ];
  }
}
