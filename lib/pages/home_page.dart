import 'package:flutter/material.dart';
import 'package:hitung_keuangan/database/database_helper.dart';
import 'package:hitung_keuangan/model/model_database.dart';
import 'package:hitung_keuangan/pages/page_input_pemasukan.dart';
import 'package:hitung_keuangan/pages/page_input_pengeluaran.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  int selectedIndex = 0;
  String selectedTable = 'pemasukan';

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
      selectedTable = index == 0 ? 'pemasukan' : 'pengeluaran';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KeuanganKu', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: dbHelper.getData(selectedTable),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final data = snapshot.data as List<Map<String, dynamic>>?;
                  return ListView.builder(
                    itemCount: data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          title: Text(data![index]['keterangan'], style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(data[index]['tanggal']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.green),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => selectedIndex == 0
                                          ? PageInputPemasukan(
                                              modelDatabase: ModelDatabase.fromMap(data[index]),
                                            )
                                          : PageInputPengeluaran(
                                              modelDatabase: ModelDatabase.fromMap(data[index]),
                                            ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  await dbHelper.deleteData(data[index]['id'], selectedTable);
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,  // Mengubah warna tombol menjadi hijau
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => selectedIndex == 0 ? PageInputPemasukan() : PageInputPengeluaran(),
                  ),
                );
              },
              child: Text(selectedIndex == 0 ? 'Tambah Pemasukan' : 'Tambah Pengeluaran'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.green,  // Mengubah warna ikon terpilih menjadi hijau
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Pemasukan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            label: 'Pengeluaran',
          ),
        ],
      ),
    );
  }
}