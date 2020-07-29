import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifiers/auth_change_notifier.dart';
import '../utils/validator.dart';
import '../widgets/button.dart';
import '../widgets/form_input.dart';
import '../widgets/image_picker_modal.dart';
import '../widgets/snack_bar_builder.dart';

class MyAccount extends StatefulWidget {
  static const routeName = "/myaccount";
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _imageUrl;
  File _image;
  String _email;
  String _firstName;
  String _lastName;
  String _phone;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      var user = Provider.of<AuthChangeNotifier>(context, listen: false).user;
      _imageUrl = user.imageUrl;
      _email = user.email;
      _firstName = user.firstName;
      _lastName = user.lastName;
      _phone = user.phone;
    }
    super.didChangeDependencies();
  }

  Future<void> _handleSave(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<AuthChangeNotifier>(context, listen: false)
          .updateUserInfo(
        firstName: _firstName,
        lastName: _lastName,
        email: _email,
        phone: _phone,
        imagePath: _image != null ? _image.path : _imageUrl,
      );
      Scaffold.of(context).showSnackBar(
        buildSnackBar(
          message: "Profile updated successfully!",
          color: Theme.of(context).accentColor,
        ),
      );
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        buildSnackBar(
          message: "Something went wrong!",
          color: Colors.red,
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final circleWidth = deviceSize.width * 0.3;
    return Scaffold(
      appBar: AppBar(),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "My Account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    padding: EdgeInsets.only(top: 16),
                  ),
                  GestureDetector(
                    onTap: () => _showImagePicker(context),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: buldImagePlaceholder(context, circleWidth),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        FormInput(
                          label: "First Name",
                          icon: Icons.person,
                          initalValue: _firstName,
                          onSaved: (String value) => setState(() {
                            _firstName = value;
                          }),
                          validator: Validateor.emptyValidator,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        FormInput(
                          label: "Last Name",
                          initalValue: _lastName,
                          icon: Icons.person,
                          onSaved: (String value) => setState(() {
                            _lastName = value;
                          }),
                          validator: Validateor.emptyValidator,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        FormInput(
                          label: "Email",
                          initalValue: _email,
                          icon: Icons.email,
                          onSaved: (String value) => setState(() {
                            _email = value;
                          }),
                          validator: Validateor.emailValidator,
                        ),
                        SizedBox(height: 16),
                        FormInput(
                          label: "Phone",
                          initalValue: _phone,
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          onSaved: (String value) => setState(() {
                            _phone = value;
                          }),
                          validator: Validateor.phoneValidator,
                        ),
                        SizedBox(height: 16),
                        _isLoading
                            ? CircularProgressIndicator()
                            : Button(
                                title: "Save",
                                onPress: () {
                                  _handleSave(context);
                                },
                              ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buldImagePlaceholder(BuildContext context, double circleWidth) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(circleWidth / 2),
      child: Stack(
        children: <Widget>[
          Container(
            height: circleWidth,
            width: circleWidth,
            child: _image == null
                ? _imageUrl.contains("http")
                    ? Image.network(
                        _imageUrl,
                        fit: BoxFit.cover,
                        height: circleWidth,
                        width: circleWidth,
                      )
                    : Image.file(
                        File(_imageUrl),
                        fit: BoxFit.cover,
                        height: circleWidth,
                        width: circleWidth,
                      )
                : Image.file(
                    _image,
                    fit: BoxFit.cover,
                    height: circleWidth,
                    width: circleWidth,
                  ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: circleWidth * 0.02,
              ),
              color: Color.fromRGBO(100, 100, 100, 0.8),
              alignment: Alignment.topCenter,
              width: circleWidth,
              height: circleWidth * 0.3,
              child: Text(
                "Change",
                style: TextStyle(
                  fontSize: circleWidth * 0.12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ImagePickerModal(
        setState: (image) => setState(() {
          _image = image;
        }),
      ),
    );
  }
}
