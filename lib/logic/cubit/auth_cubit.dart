// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:lostsapp/data/repositories/auth_repository.dart';
import '../../data/models/user.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repo;
  late User? user;
  AuthCubit(
    this.repo,
  ) : super(AuthInitial()) {
    repo.getStoredToken().then((storedUser) {
      print(storedUser);
      if (storedUser != null) {
        user = storedUser;

        emit(AuthLoginedIn(user: user!));
      }
    });
  }
  Future SignUp(String email, String password) async {
    emit(AuthProgress());
    Map<String, dynamic>? response = await repo.signup(email, password);
    // print(response ?? "nores");
    if (response == null || response["message"] != "User was created") {
      emit(AuthFailed(response != null ? response["message"] : "Auth Failed "));
    } else {
      emit(AuthSignedUp());
    }
  }

  Future login(String? email, String? password) async {
    if (email != null) {
      emit(AuthProgress());
      Map<String, dynamic>? response = await repo.login(email, password!);
      if (response == null || response["message"] != "auth succeded") {
        emit(AuthFailed(response!["message"] ?? "Auth failed"));
      } else {
        emit(AuthLoginedIn(user: User.fromMap(response["user"])));
      }
    } else {
      user = await repo.getStoredToken();
      if (user != null) {
        emit(AuthLoginedIn(user: user!));
      } else {
        emit(AuthInitial());
      }
    }
  }

  Future<void> logOut() async {
    await repo.deleteStoredToke();
    emit(AuthInitial());
  }
}
