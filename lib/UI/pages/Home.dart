import 'package:e_cart_app/Core/ViewModel/CartViewModel.dart';
import 'package:e_cart_app/UI/widgets/CartManager.dart';
import 'package:e_cart_app/UI/widgets/GridShop.dart';
import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import '../../locator.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showCount = true;

  ScrollController _scrollController = ScrollController();
  var _cartViewModel = locator.get<CartViewModel>();

  @override
  initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              controller: _scrollController,
              slivers: <Widget>[
                SliverToBoxAdapter(child: GridShop()),
                SliverToBoxAdapter(child: CartManager()),
              ],
            ),
          ],
        ),
        floatingActionButton: Visibility(
          visible: _showCount,
          child: FloatingActionButton(
            onPressed: () {
              _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  curve: Curves.fastOutSlowIn,
                  duration: Duration(milliseconds: 1200));

              setState(() {
                _showCount = !_showCount;
              });
            },
            backgroundColor: Colors.amber,
            child: Text(
              _cartViewModel.currentCart.orderCount.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black),
            ),
          ),
        ),
      ),
      onSwipeUp: () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          curve: Curves.fastOutSlowIn,
          duration: Duration(
            milliseconds: 1200,
          ),
        );
        setState(() {
          _showCount = !_showCount;
        });
      },
      onSwipeDown: () {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          curve: Curves.fastOutSlowIn,
          duration: Duration(milliseconds: 1200),
        );
        setState(() {
          _showCount = !_showCount;
        });
      },
    );
  }

  @override
  void dispose() {
    // _cartBloc.dispose();
    super.dispose();
  }
}
