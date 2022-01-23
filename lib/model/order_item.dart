import 'cart_item.dart' show  CartItem;


class OrderItem {
  final String id;
  final double amont;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amont,
    required this.products,
    required this.dateTime,
  });
}