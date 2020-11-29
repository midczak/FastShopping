import 'package:bloc_test/bloc_test.dart';
import 'package:fast_shopping_bloc/src/bloc/shopping_lists_cubit.dart';
import 'package:fast_shopping_bloc/src/data/shopping_list_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../clock.dart';
import '../fixtures.dart';
import '../mocks.dart';

void main() {
  group('ShoppingListsCubit', () {
    ShoppingListRepository repository;
    ShoppingListsCubit cubit;
    setUp(() {
      repository = MockShoppingListRepository();
      cubit = ShoppingListsCubit(repository, clock);
    });
    tearDown(() => cubit.close());

    test('has correct initial state', () {
      expect(cubit.state, ShoppingListsState());
    });

    blocTest<ShoppingListsCubit, ShoppingListsState>(
      'loads lists from repository',
      build: () {
        when(repository.getSelectedListId()).thenAnswer((_) async => null);
        when(repository.getLists()).thenAnswer((_) async => [shoppingList1]);
        return cubit;
      },
      act: (cubit) => cubit.load(),
      expect: [
        ShoppingListsState(lists: [shoppingList1]),
      ],
      verify: (cubit) {
        verify(repository.getSelectedListId()).called(1);
        verify(repository.getLists()).called(1);
      },
    );

    blocTest<ShoppingListsCubit, ShoppingListsState>(
      'saves lists to repository on every emit',
      build: () => cubit,
      act: (cubit) => cubit
        ..emit(ShoppingListsState(lists: []))
        ..emit(ShoppingListsState(lists: [shoppingList1])),
      verify: (cubit) {
        verify(repository.saveSelectedListId(any)).called(2);
        verify(repository.saveLists(any)).called(2);
      },
    );

    blocTest<ShoppingListsCubit, ShoppingListsState>(
      'adds a shopping list correctly',
      build: () => cubit,
      act: (cubit) => cubit.add(shoppingList1),
      expect: [
        ShoppingListsState(lists: [shoppingList1]),
      ],
    );

    blocTest<ShoppingListsCubit, ShoppingListsState>(
      'updates existing shopping list correctly',
      build: () => cubit,
      seed: ShoppingListsState(lists: [shoppingList1]),
      act: (cubit) => cubit.update(
        shoppingList1.copyWith(name: 'Test!'),
      ),
      expect: [
        ShoppingListsState(
          lists: [shoppingList1.copyWith(name: 'Test!')],
        ),
      ],
    );

    blocTest<ShoppingListsCubit, ShoppingListsState>(
      'selects a shopping list correctly',
      build: () => cubit,
      seed: ShoppingListsState(lists: [shoppingList1]),
      act: (cubit) => cubit.select(shoppingList1.id),
      expect: [
        ShoppingListsState(
          selectedId: shoppingList1.id,
          lists: [shoppingList1],
        ),
      ],
    );

    blocTest<ShoppingListsCubit, ShoppingListsState>(
      'fails to select a shopping list not on the list',
      build: () => cubit,
      seed: ShoppingListsState(lists: [shoppingList1]),
      act: (cubit) => cubit.select('im not here'),
      errors: [isA<Exception>()],
    );

    blocTest<ShoppingListsCubit, ShoppingListsState>(
      'renames a shopping list correctly',
      build: () => cubit,
      seed: ShoppingListsState(lists: [shoppingList1]),
      act: (cubit) => cubit.rename(shoppingList1.id, 'new name'),
      expect: [
        ShoppingListsState(
          lists: [
            shoppingList1.copyWith(name: 'new name'),
          ],
        ),
      ],
    );

    blocTest<ShoppingListsCubit, ShoppingListsState>(
      'archives a shopping list correctly',
      build: () => cubit,
      seed: ShoppingListsState(lists: [shoppingList1]),
      act: (cubit) => cubit.archive(shoppingList1.id),
      expect: [
        ShoppingListsState(
          lists: [
            shoppingList1.copyWith(archivedAt: clock.now()),
          ],
        ),
      ],
    );

    blocTest<ShoppingListsCubit, ShoppingListsState>(
      'unarchives a shopping list correctly',
      build: () => cubit,
      seed: ShoppingListsState(lists: [
        shoppingList1.copyWith(archivedAt: clock.now()),
      ]),
      act: (cubit) => cubit.unarchive(shoppingList1.id),
      expect: [
        ShoppingListsState(
          lists: [
            shoppingList1.copyWith(archivedAt: null),
          ],
        ),
      ],
    );

    blocTest<ShoppingListsCubit, ShoppingListsState>(
      'removes a shopping list correctly',
      build: () => cubit,
      seed: ShoppingListsState(lists: [shoppingList1]),
      act: (cubit) => cubit.remove(shoppingList1.id),
      expect: [
        ShoppingListsState(lists: []),
      ],
    );
  });

  group('ShoppingListsState', () {
    test('returns correct selected list', () {
      expect(
        ShoppingListsState(
          selectedId: shoppingList1.id,
          lists: [shoppingList1],
        ).selected,
        shoppingList1,
      );
    });

    test('returns null selected list if none is selected', () {
      expect(
        ShoppingListsState(
          lists: [shoppingList1],
        ).selected,
        null,
      );
    });

    test('returns current lists correctly', () {
      expect(
        ShoppingListsState(
          lists: [shoppingList1, shoppingList2],
        ).current,
        [shoppingList1],
      );
    });

    test('returns archived lists correctly', () {
      expect(
        ShoppingListsState(
          lists: [shoppingList1, shoppingList2],
        ).archived,
        [shoppingList2],
      );
    });
  });
}
