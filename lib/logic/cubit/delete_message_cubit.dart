import 'package:bloc/bloc.dart';
import 'package:lostsapp/data/repositories/delete_message_repository.dart';
import 'package:meta/meta.dart';

part 'delete_message_state.dart';

class DeleteMessageCubit extends Cubit<DeleteMessageState> {
  final DeleteMessageRepository repo = DeleteMessageRepository();
  DeleteMessageCubit() : super(DeleteMessageInitial());

  Future<void> deleteMessage(String token, String messageId) async {
    emit(DeleteMessageProgress());
    String result = await repo.deleteMessage(token, messageId);
    if (result == "succeed") {
      emit(DeleteMessageSucceed("Message was deleted successfully"));
      return;
    }
    emit(DeleteMessageFailed(
        "Error deleting message please check your internet connection"));
    return;
  }
}
