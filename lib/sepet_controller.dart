import 'package:get/get.dart';

import 'model.dart';

class SepetController extends GetxController {
  var sepetUrunleri = <Urun>[].obs;

  void urunEkle(Urun urun) {
    int index = -1;

    for (int i = 0; i <= sepetUrunleri.length; i++) {
      if (sepetUrunleri[i].id == urun.id) {
        index = 1;
        break;
      }
    }
    if (index >= 0) {
      var guncelUrun = sepetUrunleri[index].kopyala(
        adet: sepetUrunleri[index].adet + 1,
      );
      sepetUrunleri[index] = guncelUrun;
    } else {
      sepetUrunleri.add(urun);
    }
  }
}
