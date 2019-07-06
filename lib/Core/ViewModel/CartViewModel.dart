import 'dart:async';

import 'package:e_cart_app/Core/ViewModel/BaseModel.dart';
import 'package:e_cart_app/Core/models/Cart.dart';
import 'package:e_cart_app/Core/models/Order.dart';
import 'package:e_cart_app/Core/models/Product.dart';

class CartViewModel extends BaseModel {
  int _orderId = 0;
  Cart _currentCart;
  Order _lastOrder;
  Cart _publishSubjectCart;
  StreamController<Order> _publishSubjectOrder;  

  CartViewModel() {
    _currentCart = Cart();
    _publishSubjectCart = Cart();
    _publishSubjectOrder = StreamController.broadcast();
  }

  Cart get observableCart => _publishSubjectCart;
  StreamController<Order> get observableLastOrder => _publishSubjectOrder;

  _updateCart() {
    _publishSubjectCart = _currentCart;
    notifyListeners();
  }

  _updateLastOrder() {
    _publishSubjectOrder.add(_lastOrder);
    notifyListeners();
  }

  addOrderToCart(Product product, int quantity) async {
    // Add Async and wait int update methods
    _lastOrder = new Order(product, quantity, _orderId++);
    _currentCart.addOrder(_lastOrder);
    await _updateLastOrder();
    await _updateCart();
  }

  removerOrderOfCart(Order order) {
    _currentCart.removeOrder(order);
    _updateCart();
  }

  Cart get currentCart => _currentCart;

  Order get lastOrder => _lastOrder;
}
