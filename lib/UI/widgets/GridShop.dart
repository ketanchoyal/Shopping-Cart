import 'package:e_cart_app/Core/ViewModel/CartViewModel.dart';
import 'package:e_cart_app/Core/models/Product.dart';
import 'package:e_cart_app/Core/Services/ProductsRepository.dart';
import 'package:flutter/material.dart';
import 'CategoryDropMenu.dart';
import 'MinimalCart.dart';
import 'ProductWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GridShop extends StatefulWidget {
  @override
  _GridShop createState() => _GridShop();
}

class _GridShop extends State<GridShop> {
  // var _cartViewModel = locator.get<CartViewModel>();

  @override
  Widget build(BuildContext context) {
    double _gridSize = MediaQuery.of(context).size.height * 0.88;
    double containerHeight =
        MediaQuery.of(context).size.height * 0.77; //88% of screen
    double childAspectRatio = MediaQuery.of(context).size.width /
        (MediaQuery.of(context).size.height / 1.05);

    List<Product> _products = ProductsRepository().fetchAllProducts();
    // _cartViewModel.clearLastOrder();
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
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CategoryDropMenu(),
                        MaterialButton(
                          onPressed: () {},
                          child: Icon(
                            FontAwesomeIcons.slidersH,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: containerHeight,
                      margin: EdgeInsets.only(top: 0),
                      child: PhysicalModel(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
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
                                product: _products[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        MinimalCart(_gridSize)
      ],
    );
  }
}
