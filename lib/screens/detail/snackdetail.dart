import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/snacks.dart';
import '../home/widget/cart_item_provider.dart';
import '../home/widget/checkoutpage.dart';
import 'package:cafe_project/models/coffee.dart';

import '../home/widget/favouritesprovider3.dart';

class DetailPage3 extends StatefulWidget {
  final Snacks snacks;

  const DetailPage3({Key? key, required this.snacks}) : super(key: key);

  @override
  _DetailPage3State createState() => _DetailPage3State();
}

class _DetailPage3State extends State<DetailPage3> {
  int quantity = 1;
  void onIncrement(){
    setState(() {
      quantity=quantity + 1;
    });
  }
  void onDecrement(){
    setState(() {
      quantity=quantity - 1 > 0?quantity-1:1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider3>(context);
    bool isFavorite = favoritesProvider.favorites.contains(widget.snacks);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              favoritesProvider.toggleFavorite(widget.snacks, context);              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Product Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
              child: Hero(
                tag: 'coffeeImage${widget.snacks.title}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    widget.snacks.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Display Title and Price
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.snacks.title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.snacks.price,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0),
              child: RichText(
                text: TextSpan(
                    text: 'Ingredients:',
                    style: TextStyle(
                      fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: '${widget.snacks.ingredients}',
                          style: TextStyle(
                            fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black,
                          )
                      )
                    ]
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0),
              child: RichText(
                text: TextSpan(
                    text: 'Description:',
                    style: TextStyle(
                      fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: '${widget.snacks.description}',
                          style: TextStyle(
                            fontSize: 13,fontWeight: FontWeight.normal,color: Colors.black,
                          )
                      )
                    ]
                ),
              ),
            ),
            SizedBox(height: 106),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Quantity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: onDecrement,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.brown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Icon(Icons.remove),
                      ),
                      SizedBox(width: 16),
                      Text(
                        '$quantity',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: onIncrement,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.brown,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      List<CartItem> cartItems = Provider.of<CartItemProvider>(context, listen: false).cartItems;
                      CartItem newItem = CartItem(
                        productImageUrl: widget.snacks.imageUrl,
                        productName: widget.snacks.title,
                        productPrice: widget.snacks.price,

                        productQuantity: quantity, productId: '',
                      );

                      Provider.of<CartItemProvider>(context, listen: false).addToCart(newItem);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.black,
                      // backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuantityButton extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  QuantityButton({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: onDecrement,
        ),
        Text(
          '$quantity',
          style: TextStyle(fontSize: 18),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: onIncrement,
        ),
      ],
    );
  }
}