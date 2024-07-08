class ModelDatabase {
  int? id;
  String? tipe;
  String? keterangan;
  String? tanggal;
  String? jmlUang;
  String? kategori;

  ModelDatabase({this.id, this.tipe, this.keterangan, this.tanggal, this.jmlUang, this.kategori});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipe': tipe,
      'keterangan': keterangan,
      'tanggal': tanggal,
      'jmlUang': jmlUang,
      'kategori': kategori,
    };
  }

  ModelDatabase.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    tipe = map['tipe'];
    keterangan = map['keterangan'];
    tanggal = map['tanggal'];
    jmlUang = map['jmlUang'];
    kategori = map['kategori'];
  }
}