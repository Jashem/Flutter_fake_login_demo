import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifiers/auth_change_notifier.dart';
import 'my_account.dart';

class Home extends StatelessWidget {
  static const routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_box),
          onPressed: () {
            Navigator.of(context).pushNamed(MyAccount.routeName);
          },
        ),
      ),
      body: Center(
        child: Consumer<AuthChangeNotifier>(
          builder: (context, auth, _) => Text(
            "Welcome Back \n ${auth.user.firstName} ${auth.user.lastName}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
