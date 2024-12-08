import 'package:modern_ecommerce/modern_ecommerce/models/category.dart';
import 'package:modern_ecommerce/modern_ecommerce/models/product.dart';
import 'package:modern_ecommerce/modern_ecommerce/constants/svg_icons.dart';

/// Dummy Categories
final List<Category> dummyCategories = [
  Category(
    id: '1',
    name: 'Electronics',
    imageUrl: 'https://images.pexels.com/photos/343457/pexels-photo-343457.jpeg?auto=compress&cs=tinysrgb&w=600',
    svgIcon: MESvgIcons.electronics,
  ),
  Category(
    id: '2',
    name: 'Fashion',
    imageUrl: 'https://images.pexels.com/photos/934070/pexels-photo-934070.jpeg?auto=compress&cs=tinysrgb&w=600',
    svgIcon: MESvgIcons.fashion,
  ),
  Category(
    id: '3',
    name: 'Home',
    imageUrl: 'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=600',
    svgIcon: MESvgIcons.home,
  ),
  Category(
    id: '4',
    name: 'Beauty',
    imageUrl: 'https://images.pexels.com/photos/3373736/pexels-photo-3373736.jpeg?auto=compress&cs=tinysrgb&w=600',
    svgIcon: MESvgIcons.beauty,
  ),
];

/// Dummy Products
final List<Product> dummyProducts = [
  Product(
    id: '1',
    name: 'Sony WH-1000XM4',
    description: 'Wireless Premium Noise Canceling Headphones',
    price: 349.99,
    imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
    rating: 4.8,
    reviews: 1256,
    category: 'Electronics',
  ),
  Product(
    id: '2',
    name: 'Apple Watch Series 7',
    description: 'GPS, 45mm Aluminum Case with Sport Band',
    price: 399.99,
    imageUrl: 'https://images.unsplash.com/photo-1434494878577-86c23bcb06b9?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
    rating: 4.7,
    reviews: 892,
    category: 'Electronics',
  ),
  Product(
    id: '3',
    name: 'Nike Air Max 270',
    description: 'Men\'s Running Shoes, Black/White',
    price: 150.00,
    imageUrl: 'https://images.unsplash.com/photo-1491553895911-0055eca6402d?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
    rating: 4.5,
    reviews: 2341,
    category: 'Fashion',
  ),
  Product(
    id: '4',
    name: 'Philips Hue Starter Kit',
    description: 'Smart LED Bulb Kit with Bridge, Multi-color',
    price: 199.99,
    imageUrl: 'https://images.unsplash.com/photo-1550434280-103ad77f1f8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
    rating: 4.6,
    reviews: 567,
    category: 'Home',
  ),
  Product(
    id: '5',
    name: 'La Mer Moisturizer',
    description: 'Crème de la Mer Moisturizing Cream, 2 oz',
    price: 350.00,
    imageUrl: 'https://images.unsplash.com/photo-1570194065650-d99fb4b8ccb0?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
    rating: 4.9,
    reviews: 445,
    category: 'Beauty',
  ),
]; 