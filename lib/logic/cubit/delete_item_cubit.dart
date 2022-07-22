import 'package:bloc/bloc.dart';
import 'package:lostsapp/data/repositories/delete_item_repository.dart';
import 'package:meta/meta.dart';

part 'delete_item_state.dart';

class DeleteItemCubit extends Cubit<DeleteItemState> {
  DeleteItemRepository repo = DeleteItemRepository();
  DeleteItemCubit() : super(DeleteItemInitial());

  Future<void> deleteAnItem(String token, String itemId) async {
    emit(DeleteItemProgress());
    String result = await repo.deleteAnItem(token, itemId);
    print(result);
    if (result == 'succeed') {
      emit(DeleteItemSuccess("Item was deleted successfully"));
      return;
    }
    emit(DeleteItemFailed(
        "Error deleting item please check your internet connection"));
    return;
  }

  @override
  void onChange(Change<DeleteItemState> change) {
    print(change);
    super.onChange(change);
  }
}
