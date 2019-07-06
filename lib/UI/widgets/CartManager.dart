import 'package:e_cart_app/Core/ViewModel/CartViewModel.dart';
import 'package:e_cart_app/UI/pages/BaseView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'OrderWidget.dart';

class CartManager extends StatefulWidget {
  @override
  _CartManager createState() => _CartManager();
}

class _CartManager extends State<CartManager> {
  // CartBloc _cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    double _gridSize = MediaQuery.of(context).size.height * 0.90;
    // var model = Provider.of<CartViewModel>(context);

    return BaseView<CartViewModel>(
        builder: (context, model, child) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
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
                          itemCount: model.observableCart.orders.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              background: Container(color: Colors.transparent),
                              key: Key(
                                  model.observableCart.orders[index].id.toString()),
                              onDismissed: (_) {
                                model.removerOrderOfCart(
                                    model.observableCart.orders[index]);
                              },
                              child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: OrderWidget(
                                      model.observableCart.orders[index],
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "\$${model.observableCart.totalPrice().toStringAsFixed(2)}",
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
                                if (model.currentCart.isEmpty)
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
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
