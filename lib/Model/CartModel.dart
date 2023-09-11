import 'ProductModel.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
     this.quantity=1,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'] ?? 1, // Default to 1 if quantity is not present
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}
