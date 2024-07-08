import 'package:flutter/material.dart';
import 'package:hitung_keuangan/database/database_helper.dart';
import 'package:hitung_keuangan/model/model_database.dart';

class PageInputPemasukan extends StatefulWidget {
  final ModelDatabase? modelDatabase;
  PageInputPemasukan({this.modelDatabase});

  @override
  _PageInputPemasukanState createState() => _PageInputPemasukanState();
}

//detail pemasukan
class _PageInputPemasukanState extends State<PageInputPemasukan> {
  TextEditingController? tipe;
  TextEditingController? keterangan;
  TextEditingController? tanggal;
  TextEditingController? jml_uang;
  TextEditingController? kategori;
  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void initState() {
    tipe = TextEditingController(
        text: widget.modelDatabase == null ? '' : widget.modelDatabase!.tipe);
    keterangan = TextEditingController(
        text: widget.modelDatabase == null
            ? ''
            : widget.modelDatabase!.keterangan);
    tanggal = TextEditingController(
        text:
            widget.modelDatabase == null ? '' : widget.modelDatabase!.tanggal);
    jml_uang = TextEditingController(
        text:
            widget.modelDatabase == null ? '' : widget.modelDatabase!.jmlUang);
    kategori = TextEditingController(
        text:
            widget.modelDatabase == null ? '' : widget.modelDatabase!.kategori);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.modelDatabase == null
            ? 'Tambah Pemasukan'
            : 'Edit Pemasukan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: tipe,
              decoration: InputDecoration(
                labelText: 'Tipe',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: keterangan,
              decoration: InputDecoration(
                labelText: 'Keterangan',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: tanggal,
              decoration: InputDecoration(
                labelText: 'Tanggal',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: jml_uang,
              decoration: InputDecoration(
                labelText: 'Jumlah Uang',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: kategori,
              decoration: InputDecoration(
                labelText: 'Kategori',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (tipe!.text.isNotEmpty &&
                    keterangan!.text.isNotEmpty &&
                    tanggal!.text.isNotEmpty &&
                    jml_uang!.text.isNotEmpty &&
                    kategori!.text.isNotEmpty) {
                  ModelDatabase data = ModelDatabase(
                    id: widget.modelDatabase?.id,
                    tipe: tipe!.text,
                    keterangan: keterangan!.text,
                    tanggal: tanggal!.text,
                    jmlUang: jml_uang!.text,
                    kategori: kategori!.text,
                  );
                  if (widget.modelDatabase == null) {
                    await dbHelper.insertData(data, 'pemasukan');
                  } else {
                    await dbHelper.updateData(data, 'pemasukan');
                  }
                  Navigator.pop(context, true);
                }
              },
              child: Text(widget.modelDatabase == null ? 'Simpan' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
