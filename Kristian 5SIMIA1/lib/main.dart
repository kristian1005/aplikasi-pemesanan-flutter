import 'package:flutter/material.dart';

// Model Menu
class MenuItem {
  final String nama;
  final double harga;
  final String gambar;

  MenuItem({required this.nama, required this.harga, required this.gambar});
}

// Model Pesanan
class PesananItem {
  final MenuItem menu;
  int jumlah;

  PesananItem({required this.menu, this.jumlah = 1});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Pemesanan',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<MenuItem> menuList = [
    MenuItem(nama: "Ayam Kentucky", harga: 20000, gambar: "lib/assets/images/ayam_kentucky.png"),
    MenuItem(nama: "Ikan Arsik", harga: 155000, gambar: "lib/assets/images/ikan_arsik.png"),
    MenuItem(nama: "Nasi Padang", harga: 20000, gambar: "lib/assets/images/nasi_padang.png"),
  ];

  List<PesananItem> keranjang = [];

  void _tambahPesanan(MenuItem menu) {
    int jumlah = 1;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              title: Text("Tambah Pesanan", style: TextStyle(fontWeight: FontWeight.bold)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(menu.gambar, width: 120, height: 120, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 10),
                  Text(menu.nama, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Rp ${menu.harga.toStringAsFixed(0)}", style: TextStyle(color: Colors.orange)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          if (jumlah > 1) setStateDialog(() => jumlah--);
                        },
                      ),
                      Text("$jumlah", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: Icon(Icons.add_circle, color: Colors.green),
                        onPressed: () => setStateDialog(() => jumlah++),
                      ),
                    ],
                  )
                ],
              ),
              actions: [
                TextButton(
                  child: Text("Batal"),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: Text("Tambahkan"),
                  onPressed: () {
                    setState(() {
                      var pesanan = keranjang.firstWhere(
                        (p) => p.menu.nama == menu.nama,
                        orElse: () => PesananItem(menu: menu, jumlah: 0),
                      );
                      if (pesanan.jumlah == 0) {
                        keranjang.add(PesananItem(menu: menu, jumlah: jumlah));
                      } else {
                        pesanan.jumlah += jumlah;
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _ubahJumlah(PesananItem item, int delta) {
    setState(() {
      item.jumlah += delta;
      if (item.jumlah <= 0) {
        keranjang.remove(item);
      }
    });
  }

  Widget _buildMenuPage() {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: menuList.length,
      itemBuilder: (context, index) {
        final menu = menuList[index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(menu.gambar, height: 120, width: double.infinity, fit: BoxFit.cover),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(menu.nama, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text("Rp ${menu.harga.toStringAsFixed(0)}", style: TextStyle(color: Colors.orange)),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => _tambahPesanan(menu),
                      child: Text("Tambah"),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildPesananPage() {
    double total = keranjang.fold(0, (sum, item) => sum + (item.menu.harga * item.jumlah));

    return keranjang.isEmpty
        ? Center(child: Text("Keranjang kosong"))
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: keranjang.length,
                  itemBuilder: (context, index) {
                    final item = keranjang[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: ListTile(
                        leading: Image.asset(item.menu.gambar, width: 50, height: 50),
                        title: Text(item.menu.nama),
                        subtitle: Text("Rp ${item.menu.harga.toStringAsFixed(0)} x ${item.jumlah}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () => _ubahJumlah(item, -1),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle, color: Colors.green),
                              onPressed: () => _ubahJumlah(item, 1),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Total: Rp ${total.toStringAsFixed(0)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [_buildMenuPage(), _buildPesananPage()];

    return Scaffold(
      appBar: AppBar(title: Text("Aplikasi Pemesanan")),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Pesanan"),
        ],
      ),
    );
  }
}