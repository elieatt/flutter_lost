import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/presentation/widgets/auth_page_widgets/confirm_password_form_field.dart';
import 'package:lostsapp/presentation/widgets/auth_page_widgets/email_form_field.dart';
import 'package:lostsapp/presentation/widgets/auth_page_widgets/password_form_field.dart';
import 'package:lostsapp/presentation/widgets/auth_page_widgets/phonenumber_formf_ield.dart';
import 'package:lostsapp/presentation/widgets/auth_page_widgets/user_name_form_field.dart';

import 'package:lostsapp/presentation/widgets/dialogs/awesome_dia.dart';

import '../../constants/enums.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AuthPageState();
  }
}

class AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  AuthMode _mode = AuthMode.login;
  late String _email;
  late String _password;
  late String _phoneNumber;
  late String _userName;
  bool _acceptterms = false;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late AnimationController _controller;
  late Animation<Offset> _slidAnimation;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _slidAnimation =
        Tween<Offset>(begin: const Offset(0.0, -0.2), end: Offset.zero).animate(
            CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _loginOrSignupString(bool? value) {
    if (value == null) {
      return _mode == AuthMode.signup ? "Sign up" : "Login";
    } else {
      return _mode == AuthMode.signup
          ? "Switch to Login"
          : "Switch to  Sign up";
    }
  }

  void setUserName(String name) {
    _userName = name;
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  String getPassword() {
    return _password;
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.primary,
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
          if (_mode == AuthMode.login) {
            setState(() {
              _mode = AuthMode.signup;
            });

            _controller.forward();
          } else {
            _controller.reverse();

            Future.delayed(
              const Duration(milliseconds: 301),
              () {
                setState(() {
                  _mode = AuthMode.login;
                });
              },
            );
          }
        }));
  }

  void _submitForm(BuildContext context) {
    if (!_formkey.currentState!.validate() || !_acceptterms) return;
    _formkey.currentState!.save();
    if (_mode == AuthMode.signup) {
      BlocProvider.of<AuthCubit>(context)
          .signUP(_email, _password, _phoneNumber, _userName);
    } else {
      BlocProvider.of<AuthCubit>(context).login(_email, _password);
    }
  }

  Widget _buildPage(double targetWidth, double deviceWidth) {
    return Scaffold(
      /*  appBar: AppBar(
        title: Center(child: Text(_loginOrSignupString(null))),
      ), */
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.5),
        decoration: BoxDecoration(
            /* image: _buildBackgroundImage(), */
            ),
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(40),
            child: Text(
              "LostsApp",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 70,
                  fontFamily: "Pacifico",
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
          Form(
            key: _formkey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.10),
              child: Column(
                children: [
                  _buildModeToggleButton(),
                  EmailFormField(setEmail: setEmail),
                  const SizedBox(
                    height: 30.0,
                  ),
                  PasswordFormField(setPassword: setPassword),
                  const SizedBox(
                    height: 30.0,
                  ),
                  _mode == AuthMode.login
                      ? Container()
                      : FadeTransition(
                          opacity: CurvedAnimation(
                              parent: _controller, curve: Curves.easeIn),
                          child: SlideTransition(
                            position: _slidAnimation,
                            child: Column(
                              children: [
                                ConfirmPasswordFormField(
                                    getPassword: getPassword),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                UserNameFormField(setUserName: setUserName),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                PhoneNumberFormField(
                                    setPhoneNumber: setPhoneNumber),
                                const SizedBox(
                                  height: 30.0,
                                )
                              ],
                            ),
                          ),
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
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;

    return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSignedUp) {
            buildAwrsomeDia(
                    context, "Succeed", "You signed up successfully", "OK",
                    type: DialogType.SUCCES)
                .show();
            _controller.reverse();
            setState(() {
              _mode = AuthMode.login;
            });
          } else if (state is AuthFailed) {
            buildAwrsomeDia(
                    context, "Auth Failed", state.message.toUpperCase(), "OK",
                    type: DialogType.ERROR)
                .show();
          }
        },
        child: _buildPage(targetWidth, deviceWidth));
  }
}
