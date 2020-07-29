import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import 'notifiers/auth_change_notifier.dart';
import 'pages/home.dart';
import 'pages/my_account.dart';
import 'pages/signin.dart';
import 'pages/splash.dart';
import 'utils/push_notifications.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var _pushNotificationManager = PushNotificationsManager();

  @override
  void initState() {
    _pushNotificationManager.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthChangeNotifier(),
      child: MaterialApp(
        theme: ThemeData(
          accentColor: Color.fromRGBO(13, 194, 112, 1),
          appBarTheme: AppBarTheme(
            color: Color.fromRGBO(13, 194, 112, 1),
          ),
        ),
        title: "Student",
        home: Consumer<AuthChangeNotifier>(
          builder: (context, auth, _) => auth.isAuthenticated
              ? Home()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? Splash()
                          : Signin(),
                ),
        ),
        routes: {
          MyAccount.routeName: (context) => MyAccount(),
        },
      ),
    );
  }
}
