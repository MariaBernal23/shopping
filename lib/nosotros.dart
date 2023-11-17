import 'package:flutter/material.dart';

class Acerca extends StatelessWidget {
  Widget _buildProfile(String name, String email, String imagePath) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.purple,
            ),
          ),
          SizedBox(height: 8),
          CircleAvatar(
            backgroundImage: AssetImage('img/$imagePath'),
            radius: 100, // Ajusta el tamaño de la imagen
          ),
          SizedBox(height: 8),
          Text(
            email,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: Colors.pink,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
        backgroundColor: Colors.orange[800],
      ),
      body: ListView(
        children: [
          _buildProfile(
            'Maria Haydee Villalta',
            'maria.villalta22@itca.edu.sv',
            'profile1.jpeg',
          ),
          _buildProfile(
            'Jenifer Milena Duran',
            'jenifer.duran22@itca.edu.sv',
            'profile2.jpeg',
          ),
          _buildProfile(
            'Maria Jose Bernal Gamez',
            'maria.bernal22@itca.edu.sv',
            'profile3.jpeg',
          ),
          _buildProfile(
            'Michel Sarai Montes Leiva',
            'michel.montes22@itca.edu.sv',
            'proffile4.jpeg',
          ),
        ],
      ),
    );
  }
}
