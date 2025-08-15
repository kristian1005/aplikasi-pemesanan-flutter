import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Home'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Selamat Datang di HomeView',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
