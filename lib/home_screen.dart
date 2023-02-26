import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutterverse/cart_provider.dart';
import 'package:flutterverse/cart_screen.dart';
import 'package:flutterverse/constants.dart';
import 'package:flutterverse/item_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imageList = [
    'assets/images/apple.png',
    'assets/images/black-grapes.png',
    'assets/images/cherry.png',
    'assets/images/grapes.png',
    'assets/images/lemons.png',
    'assets/images/orange.png',
    'assets/images/strawberry.png',
    'assets/images/watermelons.png',
  ];

  List<String> itemNames = [
    'Apple',
    'Black Grapes',
    'Cherry',
    'Grapes',
    'Lemon',
    'Orange',
    'Strawberry',
    'Watermelon',
  ];

  List<String> priceList = [
    '200',
    '500',
    '400',
    '350',
    '300',
    '250',
    '300',
    '750'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: R.webBlue,
        title: Text("Shopping Items"),
        actions: [
          Badge(
            badgeContent:
                Consumer<CartProvider>(builder: (context, value, child) {
              return Text(
                value.getCounter().toString(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            }),
            position: BadgePosition.bottomStart(start: 30, bottom: 30),
            child: Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen()));
                    },
                    icon: Icon(Icons.shopping_cart))),
          )
        ],
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: itemNames.length,
              itemBuilder: (context, index) => ItemWidget(
                  image: imageList[index],
                  name: itemNames[index],
                  price: priceList[index]))),
    );
  }
}

class ItemWidget extends StatelessWidget {
  ItemWidget({required this.image, required this.name, required this.price});
  String image, name, price;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: R.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            image,
            height: 100,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: $name'),
              Text('Unit: Kg'),
              Text('Price: ₹$price'),
            ],
          ),
          TextButton(
              onPressed: () {
                cart.addCounter();
                Item newItem =
                    Item(name: name, unit: 'Kg', price: price, image: image);
                cart.addItem(newItem);
              },
              style: TextButton.styleFrom(backgroundColor: Colors.black),
              child: Container(
                  height: 20,
                  width: 75,
                  child: Center(
                    child: Text(
                      'Add to cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  )))
        ],
      ),
    );
  }
}
