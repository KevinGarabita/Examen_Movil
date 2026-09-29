class Cart {
  const Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      products: (json['products'] as List)
          .map((item) => CartProduct.fromJson(item))
          .toList(),
    );
  }

  final int id;
  final int userId;
  final DateTime date;
  final List<CartProduct> products;
}

/// El carrito solo trae el id del producto y la cantidad; los datos del
/// producto se consultan por separado.
class CartProduct {
  const CartProduct({required this.productId, required this.quantity});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  final int productId;
  final int quantity;
}
