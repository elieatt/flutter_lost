import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:lostsapp/data/repositories/post_and_update_network_repository.dart';
import 'package:meta/meta.dart';

part 'post_item_state.dart';

class PostItemCubit extends Cubit<PostItemState> {
  final AddnUpdateRepository _repo;
  PostItemCubit(this._repo) : super(PostItemInitial());
  Future? postItem(Map<String, dynamic> values, String token) async {
    emit(PostItemProgress());
    String? response = await _repo.postAnItem(values, token);
    print(response);
    if (response != null) {
      emit(PostItemSuccessed());
    } else {
      emit(PostItemFailed("Failed please check your internet connection"));
    }
  }

  @override
  void onChange(Change<PostItemState> change) {
    //print(change);
    super.onChange(change);
  }
}
