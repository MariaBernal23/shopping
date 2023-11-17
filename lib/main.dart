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
  List<Product> products = [
    Product(
      name: "Pizza 4 estaciones",
      description: "Pizza con 4 diferentes ingredientes a elección",
      price: 12.99,
      imageUrl: "img/food2.png",
    ),
    Product(
      name: "Churrazco de res",
      description: "Trozo de carne de ternera que se obtiene del costillar o de la paleta y que se asa a la brasa o a la parrilla.",
      price: 10.99,
      imageUrl: "img/food3.png",
    ),
    Product(
      name: "Combo hamburguesa",
      description: "Combo de una hamburguesa, papas y una gaseosa pepsi",
      price: 5.99,
      imageUrl: "img/food4.png",
    ),
    Product(
      name: "Empanadas",
      description: "Empanadas venezolanas de diferentes carnes",
      price: 6.99,
      imageUrl: "img/food8.png",
    ),
    // Add more products as needed
  ];

  List<CartItem> cartItems = [];

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

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  ProductCard({required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(product.imageUrl,
              height: 150, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(product.description),
                Text('\$${product.price.toStringAsFixed(2)}'),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: onAddToCart,
          ),
        ],
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  CartItemCard({
    required this.cartItem,
    required this.onRemove,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: ListTile(
        leading: Image.asset(
          cartItem.product.imageUrl,
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
        title: Text(cartItem.product.name),
        subtitle: Text(
            '\$${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: onDecrease,
            ),
            Text('Quantity: ${cartItem.quantity}'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: onIncrease,
            ),
          ],
        ),
      ),
    );
  }
}