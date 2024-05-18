import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo/provider/session_provider.dart';
import 'home_provider.dart';
import 'login_provider.dart';


class ProvidersList {
  List<SingleChildWidget> appProviders() {
    return [
      ChangeNotifierProvider(create: (context) => LoginProvider(
        sessionProvider: SessionProvider()
      )),
      ChangeNotifierProvider(create: (context) => HomeProvider(
        sessionProvider:SessionProvider()
      )),
      ChangeNotifierProvider(create: (context) => SessionProvider()),
    ];
  }
}
