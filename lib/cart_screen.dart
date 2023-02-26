import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutterverse/constants.dart';
import 'package:flutterverse/item_model.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Item> cartItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartItems = context.read<CartProvider>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
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
                    onPressed: () {}, icon: Icon(Icons.shopping_cart))),
          )
        ],
      ),
      body: Consumer<CartProvider>(
        builder: ((context, provider, child) {
          if (provider.cart.isEmpty) {
            return const Center(
                child: Text(
              'Your Cart is Empty',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ));
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.cart.length,
                      itemBuilder: ((context, index) {
                        return CartItem(item: provider.cart[index]);
                      })),
                ),
                Consumer<CartProvider>(builder: (context, provider, child) {
                  final ValueNotifier<int?> totalPrice = ValueNotifier(null);
                  for (var element in provider.cart) {
                    totalPrice.value =
                        (int.parse(element.price) * element.quantity!.value) +
                            (totalPrice.value ?? 0);
                  }
                  return ValueListenableBuilder(
                      valueListenable: totalPrice,
                      builder: (context, val, child) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sub-Total',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                              ),
                              Text(
                                val.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        );
                      });
                }),
              ],
            );
          }
        }),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment Successful'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          color: Colors.yellow.shade600,
          alignment: Alignment.center,
          height: 50.0,
          child: const Text(
            'Proceed to Pay',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  CartItem({required this.item});
  Item item;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Consumer<CartProvider>(builder: (context, provider, child) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: R.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              item.image,
              height: 100,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${item.name}'),
                Text('Unit: Kg'),
                Text('Price: ₹${item.price}'),
              ],
            ),
            ValueListenableBuilder<int>(
                valueListenable: provider.getQuantity(item.name),
                builder: (context, val, child) {
                  return PlusMinusButtons(
                      addQuantity: () {
                        cart.addQuantity(item.name);
                      },
                      deleteQuantity: () {
                        cart.removeQuantity(item.name);
                      },
                      text: val.toString());
                }),
            IconButton(
                onPressed: () {
                  provider.removeItem(item.name);
                  provider.removeCounter();
                },
                icon: Icon(Icons.delete))
          ],
        ),
      );
    });
  }
}

class PlusMinusButtons extends StatelessWidget {
  final VoidCallback deleteQuantity;
  final VoidCallback addQuantity;
  final String text;
  const PlusMinusButtons(
      {Key? key,
      required this.addQuantity,
      required this.deleteQuantity,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: deleteQuantity, icon: const Icon(Icons.remove)),
        Text(text),
        IconButton(onPressed: addQuantity, icon: const Icon(Icons.add)),
      ],
    );
  }
}
