import 'package:flutter_riverpod/flutter_riverpod.dart';

final listFavProvider =
    StateNotifierProvider<FavoriteController, List<Map<String, dynamic>>>(
        (ref) {
  return FavoriteController();
});

class FavoriteController extends StateNotifier<List<Map<String, dynamic>>> {
  FavoriteController() : super([]);

  void addToFav(int index, List<Map<String, dynamic>> data) {
    data[index]['isFavorite'] = true;
    final result =
        data.where((element) => element['isFavorite'] == true).toList();
    state = [...result];
  }

  void removeFromFav(int id) {
    for (final item in state) {
      if (item['id'] == id) {
        item['isFavorite'] = false;
      }
    }
    final result =
        state.where((element) => element['isFavorite'] == true).toList();
    state = [...result];
  }
}
