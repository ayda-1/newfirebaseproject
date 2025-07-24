import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseFirestoreKullanimi extends StatefulWidget {
  const FirebaseFirestoreKullanimi({super.key});

  @override
  State<FirebaseFirestoreKullanimi> createState() =>
      _FirebaseFirestoreKullanimiState();
}

class _FirebaseFirestoreKullanimiState
    extends State<FirebaseFirestoreKullanimi> {
  late FirebaseFirestore firestore;
  late StreamSubscription userSubscribe;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firestore = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Auth"),
        backgroundColor: Colors.pink.shade100,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 55,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade200,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  veriEklemeAdd();
                },
                child: Text(
                  "add ile veri ekle ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 55,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade200,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  veriEklemeSet();
                },
                child: Text(
                  "set ile veri ekle ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 15),

            SizedBox(
              height: 55,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade200,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  veriGuncelle();
                },
                child: Text(
                  "veri güncelle ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 55,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade200,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  veriSil();
                },
                child: Text(
                  "veri sil ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 55,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade200,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  veriOkuOnTime();
                },
                child: Text(
                  "veri oku ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 55,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade200,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  veriOkuRealTime();
                },
                child: Text(
                  "veri oku real time ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 55,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade100,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  streamDurdur();
                },
                child: Text(
                  "stream durdur",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 55,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade100,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  changesAllDoc();
                },
                child: Text(
                  "değişim varsa hepsini getir",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 55,
              width: 280,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade100,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  queryInData();
                },
                child: Text(
                  "veri sorgulama",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  void veriEklemeAdd() async {
    //eger böyle bir colection yoksa olsutrurur varsa içine bu doc'u ekler
    Map<String, dynamic> _eklenecekUser = {};
    _eklenecekUser["name"] = "Esra";
    _eklenecekUser["yas"] = 30;
    _eklenecekUser["isStudent"] = true;
    _eklenecekUser["adress"] = {
      "city": "Istanbul",
      "district": "Bostanci",
      "street": "kediler",
      "neighborhood": "merkez",
    };
    _eklenecekUser["colors"] = FieldValue.arrayUnion([
      "Pink",
      "Purple",
      "Turqoise",
    ]);
    await firestore.collection("users").add(_eklenecekUser);
  }

  void veriEklemeSet() async {
    /*
  //oto azaltma metodu
    await firestore.doc("users/2ZbIaUwX6swCvUP3hvMaaa").set({
      "yas": FieldValue.increment(-3),
    }, SetOptions(merge: true));*/
    //mutlaka bir doc id gerekir

    var yeniDocId = firestore.collection("users").doc().id;
    Map<String, dynamic> _eklenecekUser = {};
    _eklenecekUser["userID"] = yeniDocId;
    _eklenecekUser["name"] = "ayda";
    _eklenecekUser["age"] = 27;
    _eklenecekUser["school"] = "marmara";
    _eklenecekUser["adress"] = {
      "city": "istanbul",
      "district": "bostanci",
      "neighborhood": "merkez",
      "street": "sahilyolu",
    };
    _eklenecekUser["colors"] = FieldValue.arrayUnion([
      "pembe",
      "turuncu",
      "mor",
    ]);

    _eklenecekUser["createAt"] = FieldValue.serverTimestamp();
    await firestore
        .doc("users/$yeniDocId")
        .set(_eklenecekUser, SetOptions(merge: true));
  }

  void veriGuncelle() async {
    await firestore.doc("users/2ZbIaUwX6swCvUP3hvMc").update({"age": 28});
  }

  void veriSil() async {
    //await firestore.doc("users/2ZbIaUwX6swCvUP3hvMaaa").delete();
    await firestore.doc("users/2ZbIaUwX6swCvUP3hvMc").update({
      "yas": FieldValue.delete(),
      "adress.city": "sivas",
    });
  }

  void veriOkuOnTime() async {
    /*
    //koleksiyondan okuma yani tüm userslar gelecek


    var userDocuments = await firestore.collection("users").get();
    debugPrint(userDocuments.size.toString());
*/
    //debugPrint(usersDocuments.docs.length.toString());

    //elemanları gezmek için yani ekrana yazdırmak için
    /*
    for (var user in userDocuments.docs) {
      //debugPrint("Döküman id: ${user.id}");
      Map userMap = user.data();
      debugPrint(userMap["name"]);

    }*/
    var aydaDoc = await firestore.doc("users/QQh16zDXkZSoSOP3paD7").get();
    //hepsi yazar
    debugPrint(aydaDoc.data().toString());
    debugPrint(aydaDoc.data()!["age"].toString());
    debugPrint(aydaDoc.data()!["adress"]["street"].toString());
  }

  void veriOkuRealTime() {
    //stream yapısını kulak gibi düsüünebilirsiniz. burda bi olay olmus bana haber ver kolakjyisonu ya dokumanı dinleyebilirsin, streamdönüdür dinleme icin ön hazırlık
    var userStream = firestore.collection("users").snapshots();
    //dinleme yapyoz
    userSubscribe = userStream.listen((event) {
      //sadece bana değişeni ver aslında tek eleman verir ama foreach ile kullanılır
      event.docChanges.forEach((user) {
        //değişiklik olanın bilgilerini ver
        debugPrint(user.doc.data().toString());
      });
    });
  }

  void streamDurdur() async {
    await userSubscribe.cancel();
  }

  void changesAllDoc() async {
    var userStream = firestore.collection("users").snapshots();

    userSubscribe = userStream.listen((event) {
      event.docs.forEach((user) {
        debugPrint(user.data().toString());
      });
    });
  }

  void queryInData() async {
    //bir sorgulama yapılıyorsa kolaksiyon uzerınden yapılmalıdır
    var userRef = firestore.collection("users");
    //yasi 38 a esit olanı getir
    //var result = await userRef.where("age", isEqualTo: 38).get();
    //var result = await userRef.where("age", isGreaterThan: 38).get();
    //var result = await userRef.where("colors", arrayContains: "Siyah").get();
    var result = await userRef.orderBy("name").startAt(["Ay"]).endAt([
      "Gül" + "\uf8ff",
    ]).get();

    for (var user in result.docs) {
      debugPrint(user.data().toString());
    }
  }
}

/*
firebase firestore nosql bir yapıdadır. dönüş değeri mapdir.
collection ve doncument kavramları vardır.
collection tablo anlamına gelir. içinde documentleri barındırır
document dediğimiz veri anlamına gelir.


set varsa günceller yoksa olusturur
update varsa günceller yoksa hata verir

 */
