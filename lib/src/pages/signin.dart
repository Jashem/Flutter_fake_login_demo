import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../error/failure.dart';
import '../notifiers/auth_change_notifier.dart';
import '../utils/validator.dart';
import '../widgets/button.dart';
import '../widgets/form_input.dart';
import '../widgets/snack_bar_builder.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _email;
  String _password;
  var _isLoading = false;

  Future<void> _handleLogin(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<AuthChangeNotifier>(context, listen: false)
          .login(_email, _password);
    } on Failure catch (f) {
      Scaffold.of(context).showSnackBar(
        buildSnackBar(message: f.message, color: Colors.red),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) =>
            SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FormInput(
                      label: "Email",
                      icon: Icons.email,
                      validator: Validateor.emailValidator,
                      onSaved: (String value) => setState(() {
                        _email = value;
                      }),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FormInput(
                      label: "Password",
                      icon: Icons.lock,
                      secureText: true,
                      validator: Validateor.passwordValidator,
                      onSaved: (String value) => setState(() {
                        _password = value;
                      }),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    _isLoading
                        ? CircularProgressIndicator()
                        : Button(
                            title: "Login",
                            onPress: () {
                              _handleLogin(context);
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
