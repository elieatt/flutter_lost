// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:lostsapp/data/repositories/auth_repository.dart';
import '../../data/models/user.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  late Timer _authTimer;
  final AuthRepository repo;
  late User? user;
  late DateTime _expire;

  AuthCubit(
    this.repo,
  ) : super(AuthInitial()) {
    startUpLogin();
  }

  Future signUP(String email, String password) async {
    emit(AuthProgress());
    Map<String, dynamic>? response = await repo.signup(email, password);

    if (response == null || response["message"] != "User was created") {
      emit(AuthFailed(response != null ? response["message"] : "Auth Failed "));
    } else {
      emit(AuthSignedUp());
    }
  }

  void startUpLogin() {
    repo.getStoredToken().then((mapofUserAndExpire) {
      //print(mapofUserAndExpire);

      if (mapofUserAndExpire != null) {
        _expire = DateTime.parse(mapofUserAndExpire["expire"] as String);
        if (_expire.isBefore(DateTime.now())) {
          return;
        }
        autoLogout(_expire.difference(DateTime.now()).inSeconds);
        user = mapofUserAndExpire["user"] as User;

        emit(AuthLoginedIn(user: user!));
      }
    });
  }

  Future login(String? email, String? password) async {
    if (email != null) {
      emit(AuthProgress());
      Map<String, dynamic>? response = await repo.login(email, password!);
      if (response == null || response["message"] != "auth succeded") {
        emit(AuthFailed(response!["message"] ?? "Auth failed"));
      } else {
        _expire = DateTime.parse(response["expire"] as String);
        autoLogout(_expire.difference(DateTime.now()).inSeconds);
        emit(AuthLoginedIn(user: User.fromMap(response["user"])));
      }
    }
  }

  Future<void> logOut() async {
    await repo.deleteStoredToke();
    _authTimer.cancel();
    emit(AuthInitial());
  }

  void autoLogout(int time) {
    _authTimer = Timer(Duration(seconds: time), logOut);
  }
}
