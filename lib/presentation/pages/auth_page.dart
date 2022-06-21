import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/presentation/widgets/alert_dialog.dart';
import 'package:lostsapp/presentation/widgets/awesome_dia.dart';

import '../../constants/enums.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> {
  AuthMode _mode = AuthMode.signup;
  late String _email;
  late String _password;
  bool _acceptterms = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  /* DecorationImage _buildBackgroundImage() {
    return DecorationImage(
        image: AssetImage('assets/background.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.5),
          BlendMode.dstATop,
        ));
  } */

  String _loginOrSignupString(bool? value) {
    if (value == null) {
      return _mode == AuthMode.signup ? "Sign up" : "Login";
    } else {
      return _mode == AuthMode.signup
          ? "Switch to Login"
          : "Switch to  Sign up";
    }
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        filled: true,
        icon: const Icon(
          Icons.account_box,
          size: 40,
          color: Colors.blue,
        ),
        fillColor: Colors.amber[100],
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        helperText: 'Enter your email.',
        helperStyle: const TextStyle(fontSize: 15),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.blue),
        ),
      ),
      keyboardType: TextInputType.text,
      validator: (String? value) {
        if (value == null ||
            value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Enter a valid email.';
        }
      },
      onSaved: (String? value) {
        setState(() {
          _email = value!;
        });
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: const TextStyle(fontSize: 20, color: Colors.black),
        filled: true,
        icon: const Icon(
          Icons.mode_edit,
          size: 40,
          color: Colors.blue,
        ),
        fillColor: Colors.amber[100],
        helperText: 'Password must be More Than 8',
        helperStyle: TextStyle(fontSize: 15),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.blue),
        ),
      ),
      obscureText: true,
      validator: (String? value) {
        if (value!.isEmpty || value.length < 5) return 'Password  Invaild';
      },
      onChanged: (String value) {
        setState(() {
          _password = value;
        });
      },
      onSaved: (String? value) {
        setState(() {
          _password = value!;
        });
      },
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: 'Confirm Password',
          labelStyle: const TextStyle(fontSize: 20, color: Colors.black),
          filled: true,
          icon: const Icon(
            Icons.mode_edit,
            size: 40,
            color: Colors.blue,
          ),
          fillColor: Colors.amber[100],
          helperText: 'Password must be More Than 8',
          helperStyle: TextStyle(fontSize: 15),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.blue),
          ),
        ),
        obscureText: true,
        validator: (String? value) {
          if (value != _password) return 'Passwords dont match';
        });
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      activeColor: Colors.blue,
      value: _acceptterms,
      onChanged: (bool value) {
        setState(() {
          _acceptterms = value;
        });
      },
      title: const Text(
        'Accept Terms',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildModeToggleButton() {
    return TextButton(
        child: Text(_loginOrSignupString(true)),
        onPressed: (() {
          setState(() {
            if (_mode == AuthMode.login) {
              _mode = AuthMode.signup;
            } else {
              _mode = AuthMode.login;
            }
          });
        }));
  }

  void _submitForm(BuildContext context) {
    if (!_formkey.currentState!.validate() || !_acceptterms) return;
    _formkey.currentState!.save();
    if (_mode == AuthMode.signup) {
      BlocProvider.of<AuthCubit>(context).SignUp(_email, _password);
    } else {
      BlocProvider.of<AuthCubit>(context).login(_email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedUp) {
          buildAwrsomeDia(
                  context, "Succeed", "You signed up successfully", "OK")
              .show();
          setState(() {
            _mode = AuthMode.login;
          });
        } else if (state is AuthFailed) {
          buildAwrsomeDia(context, "Auth Failed", state.message, "OK").show();
        } else if (state is AuthLoginedIn) {
          Navigator.of(context).pushReplacementNamed("/home");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Center(child: Text(_loginOrSignupString(null))),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.5),
          decoration: BoxDecoration(
              /* image: _buildBackgroundImage(), */
              ),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: targetWidth,
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      _buildModeToggleButton(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildEmailTextField(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTextField(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _mode == AuthMode.login
                          ? Container()
                          : Column(
                              children: [
                                _buildConfirmPasswordTextField(),
                                const SizedBox(
                                  height: 30.0,
                                )
                              ],
                            ),
                      _buildAcceptSwitch(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is AuthProgress) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ElevatedButton(
                            child: Text(_loginOrSignupString(null)),
                            onPressed: () => _submitForm(context),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
