import 'package:flutter/material.dart';

class Coupon {
  final String title;
  final String description;


  Coupon({required this.title, required this.description});
}

class CouponPage extends StatelessWidget {
  final List<Coupon> coupons = [
    
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
