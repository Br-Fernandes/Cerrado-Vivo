import 'dart:math';

import 'package:cerrado_vivo/models/product.dart';

class TradeService {
  static final List<Product> _products = [
    Product(
      id: Random().nextDouble().toString(),
      name: 'Jenipapo',
      price: 99.99,
      description: 'Lorem ipsum dolor sit amet. Vel minus quisquam',
      imageURL: 'assets/images/jenipapo-semente.jpg'
    ),
    Product(
      id: Random().nextDouble().toString(),
      name: 'Pequi',
      price: 89.99,
      description: 'Lorem ipsum dolor sit amet. Vel minus quisquam',
      imageURL: 'assets/images/pequi-semente.jpg'
    ),
    Product(
      id: Random().nextDouble().toString(),
      name: 'Jatobá',
      price: 109.99,
      description: 'Lorem ipsum dolor sit amet. Vel minus quisquam',
      imageURL: 'assets/images/jatoba-semente.jpg'
    )
  ];

  static List<Product> getProducts() {
    return _products;
  }


}
