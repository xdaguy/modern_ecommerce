import 'package:flutter/foundation.dart';
import 'package:modern_ecommerce/modern_ecommerce/models/product.dart';
import 'package:modern_ecommerce/modern_ecommerce/constants/dummy_data.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}

class CartProvider extends ChangeNotifier {
  // Initialize with some dummy data
  final List<CartItem> _items = [
    CartItem(product: dummyProducts[0], quantity: 2),
    CartItem(product: dummyProducts[1], quantity: 1),
    CartItem(product: dummyProducts[2], quantity: 3),
  ];
  
  List<CartItem> get items => _items;
  
  int get itemCount => _items.length;
  
  double get subtotal => _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  double get shipping => itemCount > 0 ? 10.00 : 0.00;
  double get tax => subtotal * 0.1;
  double get total => subtotal + shipping + tax;

  void addItem(Product product) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
} 