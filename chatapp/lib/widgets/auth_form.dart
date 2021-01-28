import 'dart:io';

import '../widgets/pick_user_image.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,
      bool isLogin, File imageFile, BuildContext ctx) _submitData;
  final bool _isLoading;

  AuthForm(this._submitData, this._isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //Variables
  final _formKey = GlobalKey<FormState>();
  Map<String, String> _formValues = {
    'email': '',
    'username': '',
    'password': '',
  };

  File _userImageFile;
  var _isLogin = true;

  //Functions

  void _storeUserImageFile(File image) {
    _userImageFile = image;
  }

  bool _isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  void _trySubmit(BuildContext ctx) {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (!isValid || _userImageFile == null) {
      String errorMessageContent = _userImageFile == null
          ? 'No user image has been provided'
          : 'Invalid user credentials';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessageContent),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }

    _formKey.currentState.save();
    widget._submitData(
        _formValues['email'].trim(),
        _formValues['password'].trim(),
        _formValues['username'].trim(),
        _isLogin,
        _userImageFile,
        ctx);
  }

  @override
  Widget build(BuildContext context) {
    Widget confirmButton = (widget._isLoading)
        ? CircularProgressIndicator()
        : RaisedButton(
            child: Text(_isLogin ? 'Login' : 'Signup'),
            onPressed: () => _trySubmit(context));

    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) PickUserImage(_storeUserImageFile),
                  TextFormField(
                    key: ValueKey('email'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    initialValue: _formValues['email'],
                    decoration: InputDecoration(labelText: 'Email address'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !_isValidEmail(value))
                        return 'Please enter a valid email address';
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _formValues['email'] = value;
                      });
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      initialValue: _formValues['username'],
                      decoration: InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4)
                          return 'Username must be at least 4 characters long';
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _formValues['username'] = value;
                        });
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    initialValue: _formValues['password'],
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty || value.length < 7)
                        return 'Password must be at least 7 characters long';
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _formValues['password'] = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  confirmButton,
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin ? 'Create new account' : 'Login'),
                    onPressed: () {
                      _isLogin = !_isLogin;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
