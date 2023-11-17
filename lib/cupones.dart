import 'package:flutter/material.dart';

class Coupon {
  final String title;
  final String description;


  Coupon({required this.title, required this.description});
}

class CouponPage extends StatelessWidget {
  final List<Coupon> coupons = [
    Coupon(
      title: "Descuento 20%",
      description: "Obtén un 20% de descuento en tu próxima orden.",
    ),
    Coupon(
      title: "2x1 en Postres",
      description: "Compra un postre y llévate otro gratis.",
    ),
    Coupon(
      title: "Envío Gratis",
      description: "Envío gratis en todas las órdenes superiores a \$50.",
    ),
    // Agrega más cupones según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cupones de Comida'),
        backgroundColor: Colors.orange[800],
      ),
      body: ListView.builder(
        itemCount: coupons.length,
        itemBuilder: (context, index) {
          return CouponCard(coupon: coupons[index]);
        },
      ),
    );
  }
}

class CouponCard extends StatelessWidget {
  final Coupon coupon;

  CouponCard({required this.coupon});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  coupon.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(coupon.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
