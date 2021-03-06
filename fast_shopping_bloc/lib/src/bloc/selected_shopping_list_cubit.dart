import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clock/clock.dart';
import 'package:fast_shopping_bloc/shopping_lists.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

import '../models/item.dart';
import '../models/shopping_list.dart';

part 'selected_shopping_list_cubit.freezed.dart';

class SelectedShoppingListCubit extends Cubit<SelectedShoppingListState> {
  SelectedShoppingListCubit(this._listsCubit, this._clock, this._uuid)
      : super(SelectedShoppingListState(_listsCubit.state.selected)) {
    _listsCubitSubscription = _listsCubit
        .listen((state) => emit(this.state.copyWith(list: state.selected)));
  }

  final ShoppingListsCubit _listsCubit;
  final Clock _clock;
  final Uuid _uuid;
  StreamSubscription _listsCubitSubscription;

  @override
  Future<void> close() async {
    await _listsCubitSubscription.cancel();
    return super.close();
  }

  void addItem(String title) {
    if (state.list == null) {
      throw Exception(
        'You cannot add an item without any shopping list selected.',
      );
    }

    _listsCubit.update(state.list.copyWith(
      items: List.of(state.list.items)
        ..add(Item(
          id: _uuid.v4(),
          title: title,
        )),
    ));
  }

  void removeItem(String itemId) {
    _updateItem(itemId, (item) => item.copyWith(removed: true));
  }

  void undoRemoveItem(String itemId) {
    _updateItem(itemId, (item) => item.copyWith(removed: false));
  }

  // ignore: avoid_positional_boolean_parameters
  void setItemDone(String itemId, bool done) {
    _updateItem(
      itemId,
      (item) => item.copyWith(doneAt: done ? _clock.now() : null),
    );
  }

  void setItemTitle(String itemId, String newTitle) {
    _updateItem(itemId, (item) => item.copyWith(title: newTitle));
  }

  void _updateItem(String itemId, Item Function(Item) itemUpdate) {
    if (state.list == null) {
      throw Exception(
        'You cannot update an item without any shopping list selected.',
      );
    }

    _listsCubit.update(state.list.copyWith(
      items: state.list.items
          .map((item) => item.id == itemId ? itemUpdate(item) : item)
          .toList(),
    ));
  }

  void expandItem(String itemId) {
    emit(state.copyWith(itemActionState: ItemActionState.expanded(itemId)));
  }

  void collapseItem() {
    emit(state.copyWith(itemActionState: const ItemActionState.none()));
  }

  void startEditingItem() {
    state.itemActionState.maybeWhen(
      expanded: (itemId) => emit(state.copyWith(
        itemActionState: ItemActionState.editing(itemId),
      )),
      orElse: () => throw Exception(
        'Item action must be expanded before starting editing.',
      ),
    );
  }

  void stopEditingItem() {
    state.itemActionState.maybeWhen(
      editing: (itemId) => emit(state.copyWith(
        itemActionState: ItemActionState.expanded(itemId),
      )),
      orElse: () => throw Exception(
        'Item action must be editing before going back to expanded.',
      ),
    );
  }
}

@freezed
abstract class ItemActionState with _$ItemActionState {
  const factory ItemActionState.none() = ItemActionNone;
  const factory ItemActionState.expanded(String itemId) = ItemActionExpanded;
  const factory ItemActionState.editing(String itemId) = ItemActionEditing;
}

@freezed
abstract class SelectedShoppingListState with _$SelectedShoppingListState {
  const factory SelectedShoppingListState(
    @nullable ShoppingList list, {
    @Default(ItemActionState.none()) ItemActionState itemActionState,
  }) = _SelectedShoppingListState;
}
