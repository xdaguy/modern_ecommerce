import 'package:flutter/foundation.dart';
import 'package:modern_ecommerce/modern_ecommerce/models/product.dart';
import 'package:modern_ecommerce/modern_ecommerce/constants/dummy_data.dart';

class WishlistProvider extends ChangeNotifier {
  // Initialize with some dummy data
  final List<Product> _items = [
    dummyProducts[0],
    dummyProducts[2],
    dummyProducts[4],
  ];
  
  List<Product> get items => _items;
  
  bool isInWishlist(String productId) {
    return _items.any((item) => item.id == productId);
  }

  void toggleWishlist(Product product) {
    final isExist = _items.any((item) => item.id == product.id);
    if (isExist) {
      _items.removeWhere((item) => item.id == product.id);
    } else {
      _items.add(product);
    }
    notifyListeners();
  }
} 