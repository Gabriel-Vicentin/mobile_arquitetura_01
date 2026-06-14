class FavoritesController {
  static final FavoritesController instance = FavoritesController._();

  FavoritesController._();

  final Set<int> _favoriteIds = {};

  bool isFavorite(int productId) => _favoriteIds.contains(productId);

  void toggle(int productId) {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }
  }

  List<int> get favoriteIds => List.unmodifiable(_favoriteIds);
}
