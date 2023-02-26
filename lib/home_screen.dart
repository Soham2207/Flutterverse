import 'package:flutter/material.dart';
import 'package:flutterverse/constants.dart';

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
              onPressed: () {},
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
