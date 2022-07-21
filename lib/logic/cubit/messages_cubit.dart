// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:lostsapp/data/network_services/get_messages_network_service,.dart';
import 'package:meta/meta.dart';

import 'package:lostsapp/data/models/message.dart';
import 'package:lostsapp/data/repositories/get_messages_repository.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  GetMessagesRepository repo =
      GetMessagesRepository(gmns: GetMessagesNetworkService());
  MessagesCubit() : super(MessagesProgress());

  Future<void> getSentMessages(String token, String userId) async {
    emit(MessagesProgress());
    List<Message>? sentMessages = await repo.getSentMessages(token, userId);
    if (sentMessages == null) {
      emit(MessagesNoInternet());
      return;
    }
    if (sentMessages.isEmpty) {
      emit(MessagesNoSentMessagesFound());
      return;
    }
    emit(MessagesSentMessagesFound(sentMessages: sentMessages));
    return;
  }

  Future<void> getRecivedMessages(
      String token, String userId, bool refresh) async {
    emit(MessagesProgress());
    List<Message>? recivedMessages =
        await repo.getRecivedMessages(token, userId, refresh);
    if (recivedMessages == null) {
      emit(MessagesNoInternet());
      return;
    }
    if (recivedMessages.isEmpty) {
      emit(MessagesNoRecivedMessagesFound());
      return;
    }
    emit(MessagesrecivedMessagesFound(
        recivedMessages: recivedMessages,
        unReadMessagesCount: repo.getNumOfUnReadMessages()));
  }

  void readMessage(String token, String userId, String messageId) async {
    await repo.readMessage(token, messageId);
    await getRecivedMessages(token, userId, false);
  }

  @override
  void onChange(Change<MessagesState> change) {
    super.onChange(change);
  }
}
