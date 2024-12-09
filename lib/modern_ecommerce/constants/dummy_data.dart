import 'package:modern_ecommerce/modern_ecommerce/models/category.dart';
import 'package:modern_ecommerce/modern_ecommerce/models/product.dart';
import 'package:modern_ecommerce/modern_ecommerce/constants/svg_icons.dart';
import 'package:modern_ecommerce/modern_ecommerce/models/banner.dart';

/// Dummy Categories
final List<Category> dummyCategories = [
  Category(
    id: '1',
    name: 'Electronics',
    imageUrl: 'https://images.pexels.com/photos/343457/pexels-photo-343457.jpeg?auto=compress&cs=tinysrgb&w=300',
    svgIcon: MESvgIcons.electronics,
  ),
  Category(
    id: '2',
    name: 'Fashion',
    imageUrl: 'https://images.pexels.com/photos/934070/pexels-photo-934070.jpeg?auto=compress&cs=tinysrgb&w=300',
    svgIcon: MESvgIcons.fashion,
  ),
  Category(
    id: '3',
    name: 'Home',
    imageUrl: 'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=300',
    svgIcon: MESvgIcons.home,
  ),
  Category(
    id: '4',
    name: 'Beauty',
    imageUrl: 'https://images.pexels.com/photos/3373736/pexels-photo-3373736.jpeg?auto=compress&cs=tinysrgb&w=300',
    svgIcon: MESvgIcons.beauty,
  ),
  Category(
    id: '5',
    name: 'Sports',
    imageUrl: 'https://images.pexels.com/photos/4761352/pexels-photo-4761352.jpeg?auto=compress&cs=tinysrgb&w=300',
    svgIcon: MESvgIcons.sports,
  ),
  Category(
    id: '6',
    name: 'Books',
    imageUrl: 'https://images.pexels.com/photos/2908984/pexels-photo-2908984.jpeg?auto=compress&cs=tinysrgb&w=300',
    svgIcon: MESvgIcons.books,
  ),
  Category(
    id: '7',
    name: 'Toys',
    imageUrl: 'https://images.pexels.com/photos/163696/toy-car-toy-box-mini-163696.jpeg?auto=compress&cs=tinysrgb&w=300',
    svgIcon: MESvgIcons.toys,
  ),
];

/// Dummy Products
final List<Product> dummyProducts = [
  // Electronics
  Product(
    id: '1',
    name: 'Sony WH-1000XM4',
    description: 'Wireless Premium Noise Canceling Headphones',
    price: 349.99,
    imageUrl: 'https://images.pexels.com/photos/3394650/pexels-photo-3394650.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.8,
    reviews: 1256,
    category: 'Electronics',
  ),
  Product(
    id: '2',
    name: 'Apple Watch Series 7',
    description: 'GPS, 45mm Aluminum Case with Sport Band',
    price: 399.99,
    imageUrl: 'https://images.pexels.com/photos/437037/pexels-photo-437037.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.7,
    reviews: 892,
    category: 'Electronics',
  ),
  Product(
    id: '3',
    name: 'MacBook Pro 14"',
    description: 'M1 Pro chip, 16GB RAM, 512GB SSD',
    price: 1999.99,
    imageUrl: 'https://images.pexels.com/photos/303383/pexels-photo-303383.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.9,
    reviews: 438,
    category: 'Electronics',
  ),

  // Fashion
  Product(
    id: '4',
    name: 'Nike Air Max 270',
    description: 'Men\'s Running Shoes, Black/White',
    price: 150.00,
    imageUrl: 'https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.5,
    reviews: 2341,
    category: 'Fashion',
  ),
  Product(
    id: '5',
    name: 'Leather Jacket',
    description: 'Classic Motorcycle Jacket, Brown',
    price: 199.99,
    imageUrl: 'https://images.pexels.com/photos/1124468/pexels-photo-1124468.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.6,
    reviews: 567,
    category: 'Fashion',
  ),
  Product(
    id: '6',
    name: 'Ray-Ban Aviator',
    description: 'Classic Sunglasses, Gold Frame',
    price: 154.00,
    imageUrl: 'https://images.pexels.com/photos/701877/pexels-photo-701877.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.7,
    reviews: 1203,
    category: 'Fashion',
  ),

  // Home
  Product(
    id: '7',
    name: 'Philips Hue Starter Kit',
    description: 'Smart LED Bulb Kit with Bridge, Multi-color',
    price: 199.99,
    imageUrl: 'https://images.pexels.com/photos/1036936/pexels-photo-1036936.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.6,
    reviews: 567,
    category: 'Home',
  ),
  Product(
    id: '8',
    name: 'Dyson V15 Detect',
    description: 'Cordless Vacuum Cleaner',
    price: 699.99,
    imageUrl: 'https://images.pexels.com/photos/4108715/pexels-photo-4108715.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.8,
    reviews: 325,
    category: 'Home',
  ),
  Product(
    id: '9',
    name: 'Nespresso Vertuo',
    description: 'Coffee and Espresso Machine',
    price: 199.00,
    imageUrl: 'https://images.pexels.com/photos/4349727/pexels-photo-4349727.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.7,
    reviews: 892,
    category: 'Home',
  ),

  // Beauty
  Product(
    id: '10',
    name: 'La Mer Moisturizer',
    description: 'Crème de la Mer Moisturizing Cream, 2 oz',
    price: 350.00,
    imageUrl: 'https://images.pexels.com/photos/3685530/pexels-photo-3685530.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.9,
    reviews: 445,
    category: 'Beauty',
  ),
  Product(
    id: '11',
    name: 'Dyson Airwrap',
    description: 'Complete Styler for Multiple Hair Types',
    price: 599.99,
    imageUrl: 'https://images.pexels.com/photos/3993449/pexels-photo-3993449.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.7,
    reviews: 1567,
    category: 'Beauty',
  ),
  Product(
    id: '12',
    name: 'SK-II Essence',
    description: 'Facial Treatment Essence, 230ml',
    price: 185.00,
    imageUrl: 'https://images.pexels.com/photos/4465124/pexels-photo-4465124.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.8,
    reviews: 892,
    category: 'Beauty',
  ),

  // Sports
  Product(
    id: '13',
    name: 'Peloton Bike+',
    description: 'Smart Indoor Exercise Bike',
    price: 2495.00,
    imageUrl: 'https://images.pexels.com/photos/4162489/pexels-photo-4162489.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.9,
    reviews: 756,
    category: 'Sports',
  ),
  Product(
    id: '14',
    name: 'Tennis Racket Pro',
    description: 'Wilson Pro Staff RF97 Autograph',
    price: 259.00,
    imageUrl: 'https://images.pexels.com/photos/209977/pexels-photo-209977.jpeg?auto=compress&cs=tinysrgb&w=400',
    rating: 4.7,
    reviews: 445,
    category: 'Sports',
  ),
];

/// Dummy Banners
final List<PromoBanner> dummyBanners = [
  PromoBanner(
    id: '1',
    imageUrl: 'https://images.pexels.com/photos/6214476/pexels-photo-6214476.jpeg?auto=compress&cs=tinysrgb&w=800',
    title: 'Summer Sale',
    subtitle: 'Up to 50% off on selected items',
    actionText: 'Shop Now',
    actionRoute: '/category',
    actionParams: {'category': 'summer-sale'},
  ),
  PromoBanner(
    id: '2',
    imageUrl: 'https://images.pexels.com/photos/5624966/pexels-photo-5624966.jpeg?auto=compress&cs=tinysrgb&w=800',
    title: 'New Arrivals',
    subtitle: 'Check out our latest collection',
    actionText: 'Explore',
    actionRoute: '/category',
    actionParams: {'category': 'new-arrivals'},
  ),
  PromoBanner(
    id: '3',
    imageUrl: 'https://images.pexels.com/photos/5632398/pexels-photo-5632398.jpeg?auto=compress&cs=tinysrgb&w=800',
    title: 'Flash Sale',
    subtitle: '24 hours only - Don\'t miss out!',
    actionText: 'View Deals',
    actionRoute: '/flash-sale',
  ),
]; 