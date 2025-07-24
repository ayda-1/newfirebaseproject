import 'package:flutter/material.dart';

class StateManagementKullanimi extends StatefulWidget {
  const StateManagementKullanimi({super.key});

  @override
  State<StateManagementKullanimi> createState() =>
      _StateManagementKullanimiState();
}

class _StateManagementKullanimiState extends State<StateManagementKullanimi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("data")));
  }
}
