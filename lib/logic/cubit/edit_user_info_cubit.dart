import 'package:bloc/bloc.dart';
import 'package:lostsapp/data/network_services/edit_user_info_network_service.dart';
import 'package:meta/meta.dart';

part 'edit_user_info_state.dart';

class EditUserInfoCubit extends Cubit<EditUserInfoState> {
  final EditUserInfoNetworkService _euiNS = EditUserInfoNetworkService();
  EditUserInfoCubit() : super(EditUserInfoInitial());

  Future<void> editUserInfo(String token, Map<String, String> info) async {
    Map<String, String> infoCopyForLocalUpdate = info;

    emit(EditUserInfoProgress());
    final String _result = await _euiNS.editUserInfo(token, info);
    if (_result == "successed") {
      emit(EditUserInfoSuccessed(
          successMessage: "Changed Successfully",
          info: infoCopyForLocalUpdate));
      return;
    } else if (_result == "errorHttp") {
      emit(EditUserInfoFailed(
          failMessage: "Failed. please check your internet connection"));
      return;
    } else if (_result == "oldPassordIncorrect") {
      emit(EditUserInfoFailed(failMessage: "Failed old password is incorrect"));
      return;
    }
    emit(EditUserInfoFailed(failMessage: "Something went wrong! try again"));
    return;
  }
}
