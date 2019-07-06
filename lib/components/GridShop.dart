import 'package:flutter/material.dart';
import 'package:e_cart_app/models/Product.dart';
import 'package:e_cart_app/repositories/ProductsRepository.dart';
import 'package:e_cart_app/components/CategoryDropMenu.dart';
import 'package:e_cart_app/components/ProductWidget.dart';
import 'package:e_cart_app/components/MinimalCart.dart';

class GridShop extends StatefulWidget {
  @override
  _GridShop createState() => _GridShop();
}

class _GridShop extends State<GridShop> {
  @override
  Widget build(BuildContext context) {
    double _gridSize = MediaQuery.of(context).size.height * 0.90;
    double containerHeight =
        MediaQuery.of(context).size.height * 0.79; //88% of screen
    double childAspectRatio = MediaQuery.of(context).size.width /
        (MediaQuery.of(context).size.height / 1.0);

    List<Product> _products = ProductsRepository().fetchAllProducts();

    return Column(
      children: <Widget>[
        Container(
          height: _gridSize,
          decoration: BoxDecoration(
            color: const Color(0xFFeeeeee),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CategoryDropMenu(),
                        MaterialButton(
                          onPressed: () {},
                          child: Icon(Icons.filter_list),
                        )
                      ],
                    ),
                    Container(
                        height: containerHeight,
                        margin: EdgeInsets.only(top: 0),
                        child: PhysicalModel(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: GridView.builder(
                                itemCount: _products.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: childAspectRatio),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          top: index % 2 == 0 ? 20 : 0,
                                          right: index % 2 == 0 ? 5 : 0,
                                          left: index % 2 == 1 ? 5 : 0,
                                          bottom: index % 2 == 1 ? 20 : 0),
                                      child: ProductWidget(
                                          product: _products[index]));
                                })))
                  ]))
            ],
          ),
        ),
        MinimalCart(_gridSize)
      ],
    );
  }
}
