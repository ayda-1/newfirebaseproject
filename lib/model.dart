class Urun {
  final int id;
  final String isim;
  final double fiyat;
  final int adet;

  Urun({
    required this.id,
    required this.isim,
    required this.fiyat,
    required this.adet,
  });

  Urun kopyala({int? adet}) {
    return Urun(id: id, isim: isim, fiyat: fiyat, adet: adet ?? this.adet);
  }
}
