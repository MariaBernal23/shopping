import 'package:flutter/material.dart';
import 'package:shopping/cupones.dart';
import 'package:shopping/nosotros.dart';

void main() => runApp(MyApp());

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

class _MyHomePageState extends State<MyHomePage> {
  List<Product> products = [
    Product(
      name: "Pizza 4 estaciones",
      description: "Pizza con 4 diferentes ingredientes a elección",
      price: 12.99,
      imageUrl: "img/food2.png",
    ),
    Product(
      name: "Churrazco de res",
      description:
          "Trozo de carne de ternera que se obtiene del costillar o de la paleta y que se asa a la brasa o a la parrilla.",
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
    Product(
      name: "Sushi variado",
      description: "Selección de sushi fresco y variado",
      price: 18.99,
      imageUrl: "img/food9.png",
    ),
    Product(
      name: "Ensalada mediterránea",
      description: "Ensalada con ingredientes frescos y aderezo mediterráneo",
      price: 8.99,
      imageUrl: "img/food10.png",
    ),
    Product(
      name: "Tacos mexicanos",
      description:
          "Tacos con tortillas de maíz rellenos de carne y guarniciones",
      price: 9.99,
      imageUrl: "img/food11.png",
    ),
    Product(
      name: "Pasta carbonara",
      description: "Plato de pasta con salsa carbonara y queso parmesano",
      price: 11.99,
      imageUrl: "img/food12.png",
    ),
    Product(
      name: "Ceviche peruano",
      description: "Ceviche de pescado fresco con limón y ají",
      price: 14.99,
      imageUrl: "img/food13.png",
    ),

    Product(
      name: "Burrito de pollo",
      description: "Burrito relleno de pollo, arroz y frijoles",
      price: 7.99,
      imageUrl: "img/food14.png",
    ),
    Product(
      name: "Pancakes con frutas",
      description: "Pancakes esponjosos con sirope de arce y frutas frescas",
      price: 6.49,
      imageUrl: "img/food15.png",
    ),
    Product(
      name: "Pastel de chocolate",
      description: "Pastel rico y húmedo de chocolate con cobertura de ganache",
      price: 8.99,
      imageUrl: "img/food16.png",
    ),
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
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Acerca de ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(width: 8), // Espaciado entre el icono y el texto
                  Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acerca()),
                );
              },
            ),
          ],
        ),
      ),
      // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)
      body: GridView.builder(
        padding: const EdgeInsets.all(4.0),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
      if (cartItem.quantity > 1 || cartItem.quantity == 1) {
        cartItem.quantity--;
      } else {
        if (cartItem.quantity == 0) {
          removeFromCart(cartItem);
        }
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
        elevation: 4.0,
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: new Image.asset(product.imageUrl, fit: BoxFit.contain),
                ),
                Text(
                  product.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Text('\$${product.price.toStringAsFixed(2)}'),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                        bottom: 8.0,
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          child: IconButton(
                            icon: Icon(Icons.shopping_cart),
                            onPressed: onAddToCart,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ));
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
