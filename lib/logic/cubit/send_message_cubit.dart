// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:lostsapp/data/repositories/send_message_repository.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageRepository repo = SendMessageRepository();
  SendMessageCubit() : super(SendMessageInitial());

  Future<void> sendMessage(
      String token, String reciverId, String itemId, String messageText) async {
    emit(SendMessageProgress());
    String result =
        await repo.sendMessage(token, reciverId, itemId, messageText);
    if (result == "errorHttp") {
      emit(SendMessageFailed(
          message: "Send Failed check your internet connection"));
      return;
    } else if (result == "Cant Send") {
      emit(SendMessageFailed(
          message:
              "Send Failed you cann't send multiple messages for same item"));
      return;
    } else {
      emit(SendMessageSuccessed());
      return;
    }
  }
}
