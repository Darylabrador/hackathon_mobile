import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../providers/auth_provider.dart';

class ProvidersService {
  static List<SingleChildWidget> providerList() {
    return [
      ChangeNotifierProvider(create: (ctx) => AuthProvider()),
    ];
  }
}
