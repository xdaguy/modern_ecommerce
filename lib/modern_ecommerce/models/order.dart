import 'package:modern_ecommerce/modern_ecommerce/models/product.dart';

class OrderItem {
  final String id;
  final Product product;
  final int quantity;
  final double price;
  final String size;
  final String color;

  const OrderItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.price,
    required this.size,
    required this.color,
  });
}

class Order {
  final String id;
  final List<OrderItem> items;
  final String status;
  final DateTime date;
  final double subtotal;
  final double shipping;
  final double tax;
  final String shippingAddress;
  final String paymentMethod;

  const Order({
    required this.id,
    required this.items,
    required this.status,
    required this.date,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.shippingAddress,
    required this.paymentMethod,
  });

  double get total => subtotal + shipping + tax;
} 