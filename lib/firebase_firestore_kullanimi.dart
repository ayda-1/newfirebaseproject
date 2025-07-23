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
    //mutlaka bir doc id gerekir

    var yeniDocId = firestore.collection("users").doc().id;
    Map<String, dynamic> _eklenecekUser = {};
    _eklenecekUser["userID"] = yeniDocId;
    _eklenecekUser["name"] = "eyup";
    _eklenecekUser["yas"] = 26;
    _eklenecekUser["okul"] = "anadoluuni";
    _eklenecekUser["adress"] = {
      "city": "istanbul",
      "district": "zeytinburnu",
      "neighborhood": "merkez",
      "street": "sahilyolu",
    };
    _eklenecekUser["colors"] = FieldValue.arrayUnion([
      "siyah",
      "kirmizi",
      "beyaz",
    ]);

    _eklenecekUser["createAt"] = FieldValue.serverTimestamp();
    await firestore
        .doc("users/$yeniDocId")
        .set(_eklenecekUser, SetOptions(merge: true));
  }
}

/*
firebase firestore nosql bir yapıdadır. dönüş değeri mapdir.
collection ve doncument kavramları vardır.
collection tablo anlamına gelir. içinde documentleri barındırır
document dediğimiz veri anlamına gelir.

 */
