import 'package:flutter/material.dart';

void main() => runApp(Codigo());

class Codigo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Codigo Qr'),
        backgroundColor: Colors.orange[800],
      ),
      body: ListView(
        children: [
          SizedBox(height: 50.0),
              Image.network(
                'https://cdn.urbantecno.com/rootear/2015/07/qr.jpg', // Reemplaza con tu URL de imagen
                width: 300.0,
                height: 300.0,
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  'Este es nuestro codigo Qr',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
      ),
    );
  }
}
