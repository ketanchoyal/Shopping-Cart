import 'package:e_cart_app/Core/bloc/CartBloc.dart';
import 'package:e_cart_app/Core/models/Cart.dart';
import 'package:flutter/material.dart';

import 'OrderWidget.dart';

class CartManager extends StatefulWidget {
  @override
  _CartManager createState() => _CartManager();
}

class _CartManager extends State<CartManager> {
  CartBloc _cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    double _gridSize = MediaQuery.of(context).size.height * 0.90;

    return Container(
      height: MediaQuery.of(context).size.height,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder(
              initialData: _cartBloc.currentCart,
              stream: _cartBloc.observableCart,
              builder: (context, AsyncSnapshot<Cart> snapshot) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: _gridSize,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          "Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height: _gridSize * 0.75,
                        child: ListView.builder(
                          itemCount: snapshot.data.orders.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              background:
                                  Container(color: Colors.transparent),
                              key: Key(snapshot.data.orders[index].id
                                  .toString()),
                              onDismissed: (_) {
                                _cartBloc.removerOrderOfCart(
                                    snapshot.data.orders[index]);
                              },
                              child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10),
                                  child: OrderWidget(
                                      snapshot.data.orders[index],
                                      _gridSize)),
                            );
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            // height: _gridSize * 0.2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "\$${snapshot.data.totalPrice().toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 0,
                            ),
                            width: MediaQuery.of(context).size.width - 100,
                            child: RaisedButton(
                              color: Colors.amber,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60),
                              ),
                              padding: EdgeInsets.all(20),
                              onPressed: () {
                                if (_cartBloc.currentCart.isEmpty)
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Cart is empty",
                                      ),
                                    ),
                                  );
                              },
                              child: Text(
                                "Next",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
