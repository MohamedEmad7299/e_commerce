
import '../../network/models/products_models/Product.dart';

class CartItem{

  final Product product;
  final int count;

  CartItem({
    required this.product,
    required this.count,
  });
}