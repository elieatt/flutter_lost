// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_user_info_cubit.dart';

@immutable
abstract class EditUserInfoState {}

class EditUserInfoInitial extends EditUserInfoState {}

class EditUserInfoProgress extends EditUserInfoState {}

class EditUserInfoFailed extends EditUserInfoState {
  final String failMessage;

  EditUserInfoFailed({required this.failMessage});
}

class EditUserInfoSuccessed extends EditUserInfoState {
  final String successMessage;
  final Map<String, String> info;

  EditUserInfoSuccessed({
    required this.successMessage,
    required this.info,
  });
}
