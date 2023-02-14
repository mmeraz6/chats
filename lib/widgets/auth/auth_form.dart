import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  final bool isLoading;

  const AuthForm({super.key, required this.submitFn, required this.isLoading});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
      // use those values to send auth request
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                key: const ValueKey('email'),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email Address'),
                onSaved: (value) {
                  _userEmail = value!;
                },
              ),
              if (!_isLogin)
                TextFormField(
                  key: const ValueKey('username'),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 4) {
                      return 'Usernames need to be at least 4 characters';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Username'),
                  onSaved: (value) {
                    _userName = value!;
                  },
                ),
              TextFormField(
                key: const ValueKey('password'),
                validator: (value) {
                  if (value!.isEmpty || value.length < 7) {
                    return 'Password must be at least 7 characters long';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (value) {
                  _userPassword = value!;
                },
              ),
              const SizedBox(
                height: 13,
              ),
              if (widget.isLoading) CircularProgressIndicator(),
              if (!widget.isLoading)
                ElevatedButton(
                  child: Text(_isLogin ? 'Login' : 'Sign Up'),
                  onPressed: _trySubmit,
                ),
              if (!widget.isLoading)
                TextButton(
                  child: Text(_isLogin
                      ? 'Create New Account'
                      : 'I already have an account'),
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                )
            ]),
          ),
        ),
      ),
    ));
  }
}
