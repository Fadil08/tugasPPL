// ignore_for_file: public_member_api_docs, sort_constructors_first
class ItemCatatan {
  final String itemJudul;
  final String itemIsi;
  ItemCatatan({
    required this.itemJudul,
    required this.itemIsi,
  });
  Map<String, dynamic> toJson() {
    return {"name": itemJudul, "usia": itemIsi};
  }


  factory ItemCatatan.fromJson(Map<String, dynamic> json) {
    return ItemCatatan(
      itemJudul: json['namaProduct'],
      itemIsi: json['jumlah']
    );
  }
  
}
