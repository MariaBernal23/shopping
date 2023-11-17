import 'package:flutter/material.dart';
import 'package:shopping/cupones.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        title: Center(
            child: Text(
          'Shopping',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              _showCartDrawer(context);
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Image.asset("img/food1.png"),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cupones',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Image.asset(
                    'img/cupon.png', // Reemplaza con la ruta de tu imagen
                    height: 30, // Ajusta la altura según tus necesidades
                    width: 30, // Ajusta el ancho según tus necesidades
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CouponPage()),
                );
              },
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Productos',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Image.asset(
                    'img/producto.png', // Reemplaza con la ruta de tu imagen
                    height: 30, // Ajusta la altura según tus necesidades
                    width: 30, // Ajusta el ancho según tus necesidades
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: products[index],
                  onAddToCart: () {
                    addToCart(products[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void addToCart(Product product) {
    setState(() {
      var existingItem = cartItems.firstWhere(
        (item) => item.product == product,
        orElse: () => CartItem(product: product, quantity: 0),
      );

      if (existingItem.quantity == 0) {
        cartItems.add(CartItem(product: product, quantity: 1));
      } else {
        existingItem.quantity++;
      }
    });
  }

  void removeFromCart(CartItem cartItem) {
    setState(() {
      if (cartItem.quantity > 0) {
        cartItem.quantity--;
        if (cartItem.quantity == 0) {
          cartItems.remove(cartItem);
        }
      }
    });
  }

  void _showCartDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Carrito de Compras',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return CartItemCard(
                      cartItem: cartItems[index],
                      onRemove: () {
                        removeFromCart(cartItems[index]);
                      },
                      onIncrease: () {
                        increaseQuantity(cartItems[index]);
                      },
                      onDecrease: () {
                        decreaseQuantity(cartItems[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  void increaseQuantity(CartItem cartItem) {
    setState(() {
      cartItem.quantity++;
    });
  }

  void decreaseQuantity(CartItem cartItem) {
    setState(() {
      if (cartItem.quantity > 1) {
        cartItem.quantity--;
      } else {
        removeFromCart(cartItem);
      }
    });
  }
}